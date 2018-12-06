Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB79AC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFE520892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M+RkSB7E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hgMfSeWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFE520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MrErfs9+7iO4II+F5uvzzVIBi/D49rJKf876rV3fRVU=; b=M+RkSB7EClgsSA
	OUNo5EeagViSrzAqKFECYFdAy+ckNTYEgJ8KUgR7bnSKHZpANAl7fvoxMIqfDWmxO/JJ1fCzaHmFf
	LA9ux/KvzFref3cgGVdTUY8IUkZn5FTmVItx3NBx9ItDoTDoZ7tpwUJoBkI2+Ril/HB6bF2RO+0aQ
	CLln7IqWRJ/ZzNKAOti9KftWq/Waw7mOvQTdWI2Br3buE+wFqODUOlyB9USs7HhIiFPBNmGQVDvhb
	Ur+EDOqfD1ug0Zp1Jm0jDX0XqVMWxlmLQoveS1NAj8K3he9Z0vFiWZrwwL9GgOJWn39zMjuj4/wjF
	+kFjiy0pRPiHGteIR8yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUzEJ-0006aQ-0k; Thu, 06 Dec 2018 19:22:35 +0000
Received: from mail-eopbgr140088.outbound.protection.outlook.com
 ([40.107.14.88] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUzEF-0006Zh-2h
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70Z61OcWT61YbMWScrvDh9Yye/Y4iKWpsjotu/WzN7E=;
 b=hgMfSeWLnaJTLXCZ/29SzLT76jY4c1KfU8j3xXpFiqHn5jgqY8kQS4Joyq3u8DfJR33panr8aO3qkH5G5eeER7v5gjb73/S2yjLt7d9pge2BAgN11u63vGidFNYLh7bU+t1uIwOCH7jtKaryzRKxX3Ybr/aWC6NdnPcn7PXNE1A=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4510.eurprd04.prod.outlook.com (20.177.54.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 19:22:16 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 19:22:16 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 =?iso-8859-1?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: [PATCH] ARM: dts: imx6ul: Remove extra space between node name and {
Thread-Topic: [PATCH] ARM: dts: imx6ul: Remove extra space between node name
 and {
Thread-Index: AQHUjZj/ABFHnE4na0mgvV1RGXlBXQ==
Date: Thu, 6 Dec 2018 19:22:16 +0000
Message-ID: <58cf0fc7b3e0037344de3a02ecc3b210abfbfc28.1544123990.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0402CA0016.eurprd04.prod.outlook.com
 (2603:10a6:203:90::26) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4510;
 6:E8JOLNg+fjV1j7CtoO5B2mrcrBTC9r2JYFrrMyLQ1VXIk3/BOdcCyocQPc4oWs+4okXCtWuIKRz55hylJnMgFvqDzVZ0PLVLiU9r7LvHzfLJkdDcOy4saQNA9M8O9vFChDYAXO31WOV/QLK/MZ/wXuvSzm4OvLQAxaxGg1x8xt0XhpsoGcgMHK4AJnkeiDX3KXPJa2Tnwva6G+Uobr1fR1RAvpT5nK5QanGlx5qWPDlzuhJIwsXrN29cRSiLSyytoopR3S1pYjdxz28XfymdSj9sy0P075PzHbrE+Zue0Q+x5WmmXEu1O+k7K7/CrUghbcO4TaP6i4v8qdxg5KdQGmoYpWbDYH0JHXKqgouIPQlHNhFaEzmNFCE2dCLacijBmdoDc9lEXqZdjYKKkqTzds01QkBAgMsB82k5P5hlqR1/WOSTYfyEfjqlEWAn/Vpqn6aXS7xH18TdkA9knoshDw==;
 5:+TSHRRoRo11rXYU+Sx7FxUmjeCjGTQW4rlLpGxvk5qIlTM7Z6md1Dg+qnvI/Zia6Mcf94I1bNoW361REug3bTjzWuL7PSUS0eozEJ9ojWhP95MFyBEHHFtU53m14YEf+u3vGA9DFXwkBKOji2qn5uKsJWpbyjsPiUeRK0I0MvQc=;
 7:vIlMaIahn/xQQ0AEMbTMCSFHXcYsL3oO+Bdf2QfRzPuZEcsvHu5XWddzMk6isyqgQXzd+sWo7Blj8qbIewEyNafPAOHBv0oBxDt1JJPv/7ShfNUn714rB3hzxwOHyRfwKqOmShyzq1N5Cxm3VI2DCw==
x-ms-office365-filtering-correlation-id: 78ea8875-9988-4d62-bb62-08d65bb02195
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4510; 
x-ms-traffictypediagnostic: VI1PR04MB4510:
x-microsoft-antispam-prvs: <VI1PR04MB451095B317ADC72C932E833BEEA90@VI1PR04MB4510.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4510; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4510; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(199004)(189003)(102836004)(44832011)(316002)(99286004)(4326008)(25786009)(97736004)(486006)(2616005)(14454004)(71190400001)(86362001)(71200400001)(118296001)(52116002)(68736007)(5660300001)(6436002)(2906002)(386003)(6506007)(26005)(476003)(66066001)(8676002)(8936002)(36756003)(6512007)(81166006)(81156014)(186003)(6486002)(256004)(3846002)(54906003)(6116002)(478600001)(110136005)(7736002)(53936002)(14444005)(106356001)(305945005)(50226002)(105586002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4510;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5rqfKVEoQeP9+6h8SDknhsawRTtT/ox/daHqr0/gTw0giAGBWIs7lSKrjejNZCf4xDpx+fAsyz/aA9qkQl8RwBvw32RpEo6eDYvaENvLCx+kiA3TCL2oJqAcrZPgfinYyoSbHBN7AbUgJnYcxbOHZRFs6QiO5sHDi942VR1Qp/9+PmRY19f5dVZM3tAvT2MlIPVn7d51RcDMx56RSHAcUd2XXtvCjsy6iltN66Ng1RbzbnxyjJHwfk9asnDN8wpBB2ASz5SqoDQKfG814r6jQJPZeaL1tJN36UQ47WMkDmYadRzNXwMAtZmR6QYyzYdfkRAkj9zS1epDlH3rifcLThEYLENRyLLJQ3zmI3/vN6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ea8875-9988-4d62-bb62-08d65bb02195
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 19:22:16.0490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4510
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_112231_120648_478DF555 
X-CRM114-Status: GOOD (  13.09  )
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
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes: 7d1cd2978664 ("ARM: dts: imx6ul: add gpmi support")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 083d3446c41d..93ca2405ac8c 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -183,11 +183,11 @@
 			#dma-cells = <1>;
 			dma-channels = <4>;
 			clocks = <&clks IMX6UL_CLK_APBHDMA>;
 		};
 
-		gpmi: gpmi-nand@1806000         {
+		gpmi: gpmi-nand@1806000 {
 			compatible = "fsl,imx6q-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x01806000 0x2000>, <0x01808000 0x2000>;
 			reg-names = "gpmi-nand", "bch";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
