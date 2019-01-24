Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5B3C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:23:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD57421855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hs9BDD6i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EUxINkFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD57421855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t+xNEWNmEBmgzqJ7rfE3Ao1Sse1Ccqp2DOz3PW8DpGg=; b=Hs9BDD6i1WIh30
	Sq8ideMk1mGKU90FEZwU70mifDfY1K8xcyUsdXicgR5MDagNkfsasum+bc/HhvX0Wm5fOJpNh/Ohb
	MB775Lv8W7ZcT2zV18QbeHDGvjqRJ/27+zZRro0cAKP/Bmri2jqiwN87qihQdn352Iw1Kc3GtDFzF
	WgCGoVTxGM20o6bVf8LqxIRAZ/bZytPssaYEcnBIR1bQqRDxlC3QY7kWDw94bd7G3m9ntbpDrz1pB
	0L55f1pAinUG6jakD2vI+3bLZDF50JsRBE00Uj2gUgtkl2nFBZ8zMP8Ar7cVteRy30cf2vBBq4SJ4
	3l800FpFLVeCKi0WAmPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmez2-0005pq-88; Thu, 24 Jan 2019 13:23:52 +0000
Received: from mail-db3eur04on061d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::61d]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmey4-0004wT-2M
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 13:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mEAFUmkxdPtR1a1a4c3fjlIDBu+f8E/jLVCf5lgndo=;
 b=EUxINkFKixK/YCqYlK1Vzr8xhxy4+Q/xW1H7Ed5voFQPaFoEw5a1SnLvgc+/ltLp83QodjprzHNsLgDbTes7RmP1I6Tf9ajCXXhbBwzAgeeJCVZYtunqHm4uiqZ5vFWlQxRFiND/CyMgIsGdDhLn3f/dXON9RrYw3rgbA7ATKes=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5443.eurprd04.prod.outlook.com (20.178.112.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Thu, 24 Jan 2019 13:22:45 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 13:22:45 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V3 4/5] dt-bindings: imx8-clock: add a53 and a72 clock id
Thread-Topic: [PATCH V3 4/5] dt-bindings: imx8-clock: add a53 and a72 clock id
Thread-Index: AQHUs+fk5QuAi9LtjEObRRH5vLY3yQ==
Date: Thu, 24 Jan 2019 13:22:45 +0000
Message-ID: <1548335800-6438-5-git-send-email-aisheng.dong@nxp.com>
References: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:203:2f::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5443;
 6:MFqwWay+HFhTccIv9j6jbVs3J0BaP0QqsdOy2PF5DcgI2vOb0q9Hhbrp3xNN0h0F2mpJC+xp9L5B1X9mZnE2jiDseDE1iNvNDJiTteqq1aZU7Gb5fcArZGyQAgaKKrO5Scw993udaLZQlKLB9hlskRcyb4SrIzQl07B2qPcTqx3Ey8kiXeS2cmkPP2+8g44C5j09kkfrSThIsRBhKDlcIxwrX75XQyZMhU8zl937Kkx5OGc05uD994BL41ypJOfCEj53IVh4ahx9+wSNRppOo9Yqkz70kwyQyklQFgrBFDGjFM3jpD5ti9ubQbYVMQQiOHwfJJAU6LMl384HZc5xSsd0Suny0vIyvDWtk1Zx+hwJis8rqdPRFSyN2XZUXcCGOlnCDnxxDm9MNdMLDHjjPhJdnTnleoQcXwCldQMnlpEGUOWcbKIKzZCrPnaJQE/FFbajoUboqNUBg5Z+2ybSlQ==;
 5:ULTrwFDuPTz+4H2+5RH7o+OH+hbAVtSrwtjlBdSJknvlZtVoYwy3xKKn14J83KcItfmpVR8MvtoTc494o+1GYR1iQhKzRy1EG4m5y0HkPFT8wD4YDM5IBQchHp+ls3YJRw3KH7vVPWgMFURzJe2HsOsw1IDRLGFJWeFf5w9YwCUPCPWwuHYXFrjw+iz0dP1ZWGA/AsNSKYm/JhaOw58mhQ==;
 7:prODsfONCWlVyuvuvyow2kjfFPjJDhcfI6BN4BScDPbS2UrFF6if17rrMuEbIgm+HVI5FpZ1cp35MUQwq9kv72M6iQfiB7kL8J4ej7w6sdTdZVM6Q6wpjmfy6/wRujBAGW3Nkzkc4mR+U5k8rPQGQA==
x-ms-office365-filtering-correlation-id: 6bb13496-2b6b-4e67-0628-08d681ff068f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5443; 
x-ms-traffictypediagnostic: AM0PR04MB5443:
x-microsoft-antispam-prvs: <AM0PR04MB54437F376D6427C85D46124C809A0@AM0PR04MB5443.eurprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(50226002)(6916009)(5640700003)(6512007)(6116002)(66066001)(305945005)(7736002)(486006)(44832011)(97736004)(86362001)(99286004)(316002)(6486002)(68736007)(81156014)(106356001)(81166006)(6436002)(8676002)(8936002)(54906003)(476003)(2351001)(11346002)(446003)(2616005)(71200400001)(14454004)(102836004)(2501003)(2906002)(105586002)(36756003)(71190400001)(478600001)(4326008)(186003)(52116002)(256004)(3846002)(14444005)(53936002)(76176011)(26005)(25786009)(6506007)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5443;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kKtRDJ7agN8DPjrbKT2x1MeNVmr1ZUOLS18nRlBU7jj3NvLwab8VuuHOGC6Djm/Hnt76QYYKvMFl2Zd3IC74cEQbem4aaDG95yVDkYtmoONNUyWPjqTk5lp5ravRM0x3VYcqP/g+9BprTalQSCKFmSvuWMcU9UPUAuPfVhJI/X0czIWJhgPRmj8OQCraTkb5JFOqiz1iX0QaKPL/a1RpK/cp0kTykO+SL9fJH0cpAp+KRau99V/3Y5ftYoWyDRsxocSpMMAkvUVKGSIbys17PMjttWMR4iJOXR/xCJevKa5tNfOeoeGY+tS7t7BLJYuRU0XXMFfOiu6G7kKfUJFgCLOZaeBCVGTAf4Oj3MWtzuCUtTnurXn/j9dtQLSh1KBrhdRvcIDWpVPHZnL/AmUeyeOXOUkDOD9I8XjJTxRSj04=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb13496-2b6b-4e67-0628-08d681ff068f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 13:22:41.1387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5443
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_052252_690343_85B31D88 
X-CRM114-Status: GOOD (  11.09  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a53 and a72 clock id, as there's still no users, we update
IMX_LSIO_MEM_CLK base to start from 6 to allow a53 and a72 clock
id to be continued with a35 clk.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * change cpu clock to cpu cluster clock per Rob's suggestion
---
 include/dt-bindings/clock/imx8-clock.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index b149e63..dcce744 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -14,10 +14,12 @@
 /* CPU */
 #define IMX_A35_CLK					1
 #define IMX_CPU_CLUSTER_A35_CLK				1
+#define IMX_CPU_CLUSTER_A53_CLK				2
+#define IMX_CPU_CLUSTER_A72_CLK				3
 
 /* LSIO SS */
-#define IMX_LSIO_MEM_CLK				2
-#define IMX_LSIO_BUS_CLK				3
+#define IMX_LSIO_MEM_CLK				6
+#define IMX_LSIO_BUS_CLK				7
 #define IMX_LSIO_PWM0_CLK				10
 #define IMX_LSIO_PWM1_CLK				11
 #define IMX_LSIO_PWM2_CLK				12
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
