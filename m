Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22431C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:23:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35D521855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YQ4idMdA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEU2sCxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35D521855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XFOxuwUtyc/lKqkKCjQaMVlAZOxOttGqI+ULHxltjaw=; b=YQ4idMdAlB7x5b
	i506lgJUlnssAc5rhoqB1xNOUBfuKgNH89zQli7Bek6lLTT8xp7tCNJeys0jN/XIukmXQwSD2Zylk
	ARkcBj64vly7a0X501k0fCMbh52ZhXatAL7zC5qu9lsL0fPldq5CCM85JNHqcXxPmqiX1FxCsq41m
	ERHN6lJg8PkBoqD2rKAOxPrNnRKuOSF/3HeWo20COZ0tJx3xfVWMV00C+Va7P783sPh8JX8aLLB1t
	Bqus0KG+EmoMUXBVgZ+5RLHrlRPtuEm44S7M8t5dojC6M+SmENVvBq5DEn+4H7w7lwIPZef5Jqy0R
	7szbFxAXgpHBez598u0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmeyo-0005ec-G0; Thu, 24 Jan 2019 13:23:38 +0000
Received: from mail-db3eur04on061d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::61d]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmexy-0004wT-GE
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 13:22:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x9cfRGjfPu3Vbtwo6fMJQ5g1NRz+du9RGN+MvD1ElU=;
 b=eEU2sCxmtZKE7VvCwbMuySXrBEIAs9RAz4L3eWrKaTtvJedYq7j5CaQrml0wjT6yFeNhBMAH3GPX9WhKWHRO2NlJf45duJocI34jnAw/fYIMBooo0Y/YyUjk1XLsX/AgbTIYfJL1TYeE6zOaOepzL2fUhd1Qr9+taB0tbcUfKDM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5443.eurprd04.prod.outlook.com (20.178.112.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Thu, 24 Jan 2019 13:22:40 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 13:22:40 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V3 3/5] dt-bindings: clock: update CPU clock ID name
Thread-Topic: [PATCH V3 3/5] dt-bindings: clock: update CPU clock ID name
Thread-Index: AQHUs+fhfq3L0RgXGUm25sTWxq5Enw==
Date: Thu, 24 Jan 2019 13:22:40 +0000
Message-ID: <1548335800-6438-4-git-send-email-aisheng.dong@nxp.com>
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
 6:ueB0z6Hqe7FcMQLE2PQIQ3h6CGhI1iHtekQwl1WPg/u4fJovwwnEWd3HbABkStVywTTmY1gbhLEtH03LB0YijkHIDWxhfw3n8gkYqYxeeIIhbcfQ9peGG3ptePz4YicIBW5xD3aw7qVd2R8BUoAC1KQT2OXuzWxYqW5cXj4AqIvCQl56wm+RNd269c9h8oIRtFYfnSXiA32L3VOXchOkJst4Fae6tuWlVUeqoDLu29mcqLHHZmqepiZ7iUM0oEjcQmD5i2q3kOHjD37wHKnKX/FLzVpcNJknKa/+QkFiC1BnrZ6xZOHxWzGAUXyT8MDYmQ1QY4++tFUF6cKGktIzGKOrJPMPXV2d3KVFiy08T6nZBRQPkYUr98kgx4GdSfoG0IKjAdWprY84M2TH1IDeCW27k6LtnOb/Z+WtZF4LPX1QGRgVDHI1bJtN1EDyUxbrWpMBZeJD0eFQQLRWLDX4rA==;
 5:Xaw85Pr+d2IQjXwGyaaaAYLijcWmMxpo5V1WgPEFaHnOiR1JeCV73az8cX9krX4xrU03B1vehfLPQrZY2dPBPC/g1C+Qp9E+eUZ51HyzE4s4ScBa5cxE7w40+M2ZpmtqYMqSJeCGC5U4PXMpjhykmcfZAWlKlYhTVEFG06fAZpfS7sRPxV2dTLFdo53Cj3mcW3qluw9IVdXpvAZyV4kesA==;
 7:uHBT09I/uVdcbfx/d4Iwtqi2duDSz1y8BXRPyDWjmGAH9niyv+gsE6jcz0MG+6VftCLCNBoYIdRf4w59aFtBr193hzuYiAcMocrArb9s2OwYNM8CF5t2Q5G/2OJlJ/fL44mKOGPE1AAPxKSLM3NSKw==
x-ms-office365-filtering-correlation-id: 1f22f3b3-e00f-4ab2-e8d0-08d681ff040c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5443; 
x-ms-traffictypediagnostic: AM0PR04MB5443:
x-microsoft-antispam-prvs: <AM0PR04MB54431CDFC3599B22BA02F9E2809A0@AM0PR04MB5443.eurprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(50226002)(6916009)(5640700003)(6512007)(6116002)(66066001)(305945005)(15650500001)(7736002)(486006)(44832011)(97736004)(86362001)(99286004)(316002)(6486002)(68736007)(81156014)(106356001)(81166006)(6436002)(8676002)(8936002)(54906003)(476003)(2351001)(11346002)(446003)(2616005)(71200400001)(14454004)(102836004)(2501003)(2906002)(105586002)(36756003)(71190400001)(478600001)(4326008)(186003)(52116002)(256004)(3846002)(14444005)(53936002)(76176011)(26005)(25786009)(6506007)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5443;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MbALupIqzCnHVq5Tb+ZydlspQGKZCbpCYLH3UAllyDNP1xJ04kli3d/lY4LJLlI5tvytF5gfQWRe7zEWHf3ew0V/nI9E4+L65fd28IsPAzPpKFCYppphiW8NyTXaOm+bQMeVEbBMgvfmYgFm3A6NWzObl9qrwpoq2RRZVYw575sLlq+oAKDRxVl0cRMK+y21m+M5O1b9lZFjLVDvWK/Yd9Yue+oyooC96azXk4FvNfWiwQOR6IhoyB5We+Q/dIQh4uoAQ5prJCp1zW4iMTLjW/9ckIemKKqdRqrek5tTmd1XTh0syeBYWy299e0dRSeLXl2SWRdbvyeziNTLtTQCZ0MiPaj6T4nCI2hQkXsILF3Or7rLuy90XSTqJrAer8rb/nB3gftpIenf1n+YJSl2fBDVZtpaDyYDufyal1StiLo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f22f3b3-e00f-4ab2-e8d0-08d681ff040c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 13:22:36.9287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5443
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_052246_912362_6B41DFE2 
X-CRM114-Status: GOOD (  10.35  )
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

Update the CPU clocks to CPU cluster clock.

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
 * change name to cpu cluster clock according to Rob's suggestion
v2->v3:
 * keep IMX_CLK_A35 to not break building as clk driver already uses it
---
 include/dt-bindings/clock/imx8-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 4236818..b149e63 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -13,6 +13,7 @@
 
 /* CPU */
 #define IMX_A35_CLK					1
+#define IMX_CPU_CLUSTER_A35_CLK				1
 
 /* LSIO SS */
 #define IMX_LSIO_MEM_CLK				2
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
