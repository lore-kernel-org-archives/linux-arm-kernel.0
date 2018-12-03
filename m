Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE9C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7316B20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXNvS5Pw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKXKiKkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7316B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LXmuy+TX0KWJdST+L1cx3Lpa0ZsJLew4OGATA2EwdOE=; b=bXNvS5PwBhCS+q
	bvs9YAwZ0lPxrK2Yb+Y+pDyWWWHA2xLgjTP24LZ0RQ4flpg1F0jZkDyGFLAj3OEJ/SrWugH8tIC5O
	fOTZAmPtFFoCDbCAGsLBlKvWtrsXKx3djDnzEBBZPCRGxO3Cr85lHMkCB/DyM5IvFTkN/zXwKNaS0
	Byq10xpxnzvcgAfKxo0oPIHipYd7XNZWpzcxxQQSND33Yt6LqwApMZRJLdbuZxQ0VhZ/SWOv9JFB3
	faLVkjen81W9ZTmPiHcIlTuKRR94GhhECU+eo50vZT/PhtpFLcDoy0iEnFbP+WY624UFUE7iSAKpg
	gIpY1bn0T/ZFBvS8rvAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTgf2-0000dx-40; Mon, 03 Dec 2018 05:20:48 +0000
Received: from mail-am5eur02on0602.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::602]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTgeq-0000Qh-Ie
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 05:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIxOnDwa4PW8CDgbM+7gHRgXVHdK35kDiL2KnY5zOXc=;
 b=UKXKiKkxc/lulJOBq+NvyDqhVxNWvOdjF8TuXkSrC5N80thRA5544BzFRB16SeM6OKaWCP5UyMSSCZIKGpsNugzSz4Jk3MS8xWwZAdr+jgJRNZCTdSNKmDISrTEqy6cAyuSBwpdP/3uPwsY77e0VrLM6GurHfZuhJrAphhAeEgU=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4138.eurprd04.prod.outlook.com (52.135.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Mon, 3 Dec 2018 05:20:20 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 05:20:20 +0000
From: Joakim Zhang <qiangqing.zhang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>
Subject: [PATCH RESEND V2 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
Thread-Topic: [PATCH RESEND V2 1/4] ARM: dts: imx6sx: Add flexcan stop mode
 wakeup support
Thread-Index: AQHUisfiokpFik6+9E2+K+sgpEulnw==
Date: Mon, 3 Dec 2018 05:20:19 +0000
Message-ID: <20181203051753.1532-2-qiangqing.zhang@nxp.com>
References: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR04MB4138;
 6:S53VstLnDJb1fZm5bVmCcjbGK02iYBRzQxDPYZgGklAUJPmDGgmO4pU780E4/obMu8FQ+VspUjqTMJYDHIHMyunBVljI0e/Av9MK6+RY23w3ABe4F+Ub2o9nrWPqSKtdjrK6pHmT5NUJjjR0Fg45AESaOco/YbUYhFYJQz/7FM/SFzEjamd+tmtvWDrqi8Qk5QHV2JqIela39vqZ6yX5LEBLwbIPgZu1utkkqxB3fhNHtLmeRtLnh+0/L4XncoumCGV3YZjzNWn7uOYZcKM4NzrcY7RfVCV31td1gtehMAgAtoPIYh4z4zvv7iTwOLX8+R0TzPP7HGn18rVwIXLeDL/yi7St61g1T/f+/1/pEurwuNT/o0lG9joCTMcOEaZgA2BX5XQx4z16rT0S8ESgKkDujKXL/5STEm5GXoN1TG+ID3hwJbswGZeHvUXzC08mfah1MVhy37yKHf88G0yf3g==;
 5:VNGrelmMtpbVKnUP+w2jM9l+00oz0uLyLKMfiM9HBvmtURLEHYEvaOa+/ZVqBDtuzk5e1ki9vTqXyQY/QUo2SgtV8WyjvQMqhJuw1bB+dzaYnrIptGCSIT29gJ3x3ZQcvldNAMYoY2xRp+LfndlMFKCFkbZARxKs82JA70tmEwY=;
 7:5oKESIrttqaI25XTxbTD5xpqCQGDmbuFvmEwIfVvgeI+9fS0XSmSTxPeaz4poet9rehKybtTj9+WZG9MJXY+KkIQHvzMJgb3TQLlrZmx1/zxwitm19EIjUJ+hZk5zuF9jZedb54zh0O+HmeGjpnuyA==
x-ms-office365-filtering-correlation-id: 17f5f410-a98d-49fa-1b34-08d658df0473
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4138; 
x-ms-traffictypediagnostic: DB7PR04MB4138:
x-microsoft-antispam-prvs: <DB7PR04MB413831AAD0D81F0B12A23367E6AE0@DB7PR04MB4138.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB7PR04MB4138; BCL:0; PCL:0; RULEID:; SRVR:DB7PR04MB4138; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(366004)(189003)(199004)(6512007)(2906002)(81156014)(478600001)(11346002)(8676002)(6486002)(446003)(110136005)(14454004)(486006)(81166006)(476003)(2616005)(71190400001)(53936002)(25786009)(6436002)(316002)(68736007)(54906003)(4326008)(50226002)(86362001)(2501003)(186003)(8936002)(66066001)(105586002)(106356001)(7736002)(97736004)(5660300001)(305945005)(14444005)(76176011)(102836004)(52116002)(99286004)(217873002)(6506007)(386003)(3846002)(6116002)(71200400001)(256004)(26005)(36756003)(1076002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4138;
 H:DB7PR04MB4618.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rV81X/bydU5lyskyTsJBiFcWOTckdbpnHGqSznGbW93ul758vvB0sZN3yH3G7oyCZ2CT1W1qoiGZRRK1Bohgpy3KT2jJJgqnsH65/6QAH+eLrpedd0BtiuauWfp1QY4xIX4kzRXFYg8Tws5mn+sCS97Yj7mvJG5OHazi5YH2Idkfwx4Ghln55LT4JimHAHB7C70ZNnIgRKTTbwtT+WjZNVpj/ysT1k1+4NWdF7+xfGA9RRHWlsoZg4XEAItWUHxYjSWaCfMhFTObukS0E5ZFdkFjHWM0QFNWZJnLVipi8G7NBU8Fs3xOfRs+3FpBQqP7PmtlVAJYzYmUbpKfDqbXhZWxdKHoWukUYKQehmufgnY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f5f410-a98d-49fa-1b34-08d658df0473
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 05:20:19.9050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_212036_610726_6F31BAD6 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joakim Zhang <qiangqing.zhang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Aisheng Dong <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 6c8d2bb09025..272ff6133ec1 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -451,6 +451,7 @@
 				clocks = <&clks IMX6SX_CLK_CAN1_IPG>,
 					 <&clks IMX6SX_CLK_CAN1_SERIAL>;
 				clock-names = "ipg", "per";
+				fsl,stop-mode = <&gpr 0x10 1 0x10 17>;
 				status = "disabled";
 			};
 
@@ -461,6 +462,7 @@
 				clocks = <&clks IMX6SX_CLK_CAN2_IPG>,
 					 <&clks IMX6SX_CLK_CAN2_SERIAL>;
 				clock-names = "ipg", "per";
+				fsl,stop-mode = <&gpr 0x10 2 0x10 18>;
 				status = "disabled";
 			};
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
