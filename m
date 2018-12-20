Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF62C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D35021741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ji16/xeI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gfv3atpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D35021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LXsMltuRkTW13AbdFoLKBKN0K5mJoqgutK6g61vgxLg=; b=ji16/xeIjEJl5R
	p4UBfYM0iu+lEKc0vZPLzaRWMjZBphWpcDOGb08shalvmJzNU/vbVvkLx1V14YlMEvUY0VjSO7Y72
	hxEDNiQu3yhNmudrHD3/N9vxj82yLAjjDYe5EBNRYfiqxA/hRKorWcW+IdTNfhWCFurQClfFtkEme
	tXMNXekhQkw0iC04uNdWUsspY3JtHnAtiDpgsFs02x87nwfNjcNuXo1X9ZS+jc9NLy1tQlGVsxbyw
	ViU6hWUJx8yzbK3p+KHJgWpvtV6MQLIX5XRjagxcJelRSixnhySHeNxcipr3xmEoRRIpFy+KUougI
	TrgZBUdK5VyPeLPdBuDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZu8D-0004PI-PF; Thu, 20 Dec 2018 08:56:37 +0000
Received: from mail-eopbgr140040.outbound.protection.outlook.com
 ([40.107.14.40] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZu7w-00049C-TY
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 08:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXeqg+rKbG9pyWh7Y/AB1xJk3R9skgcXKMC/CA2GPqo=;
 b=gfv3atpXb6z+l2ctgf8SA22Z+9v7GebowfOBY4QD80NaU0v/WTqpIUb3VzWWme7YCSfWtkEw6AszwJ/RXsV2n1P6at+jnyjbsQ9syGjmjzVGaX0yRvrtgKCew0ElP7JiU5/Q/MRxAYTZH9WDYJpD5/RCbwajYrbl7Whp9Ihe0ko=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3653.eurprd04.prod.outlook.com (52.133.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 08:56:07 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 08:56:07 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "a.zummo@towertech.it"
 <a.zummo@towertech.it>, "alexandre.belloni@bootlin.com"
 <alexandre.belloni@bootlin.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-rtc@vger.kernel.org"
 <linux-rtc@vger.kernel.org>
Subject: [PATCH V5 1/4] dt-bindings: fsl: scu: add rtc binding
Thread-Topic: [PATCH V5 1/4] dt-bindings: fsl: scu: add rtc binding
Thread-Index: AQHUmEHY85kRysPGJU+DoCbVC48Xkw==
Date: Thu, 20 Dec 2018 08:56:07 +0000
Message-ID: <1545295872-20169-2-git-send-email-Anson.Huang@nxp.com>
References: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3653;
 6:5GKbkrQ6AHxtExBBe8GfPhOfW1TJpCTZDjQB0LwdZFIc06oKsYvHHlZja9IUxynb5cVYiceTZ43mgu6oiVXanMdvAgNn6apEW8ABOdE9ULb6Gt460BX62WatoKAXWgPEJNFSdv1X5dKh7Jw2XbxrADp09ne3k6Y/8cxkqyFWEp1XAHKjsdfzheqHgYm5MjVc9Uo9gIHZ4PogWL4qpZ36oaXQB/IV0dKjCgnCEs2Be3j11Piphj3PuyRrhtXttWEGxcJfsciRIzcACsrYtu8bvszmuJBhXDkZ6LZRzsALN5gvJdkgpldwiTyMqda6Fz8V66HhcGo2iZpNufeyB8YCQmKSDQ0uh/6Z6NDsX7xwG82rN9XfdKYkC6vUA3H8/lE5dboPlEd7V68RPiwR6BgqzrC7luaYvoiS/tG5Qj7LC02vXKGhwbL/PgWRTBB+Lvirzlnkard9MjYDMdyCuuK4Jw==;
 5:ki+sDXh78kOpcR2OexFJKOBZnNVmVBeR+q7FvP4x8klO9NQ85lzw3LAdut9CFRYLvU5fcugd7Z1v3NzyMSBMFgfFWCGjPWVzhf2uhNjl3KjyIJjyk3qwVQ9bB6vzyLUN377Trll6QcG48HiR1DGJbQyAbT7LZdwWTbk+7SEEnPg=;
 7:aMWwh9/xsx2YCkOCfhHNIQuoMKJXel5hdr4vxnUnx2zmiXD5Pnn3fnBrCz44lC4egiJ7vSo9v3N9VW5xS7AthfYcgMiYget7W1FBXAgO+ymeLTzeluH+nP/2MhCJ0zP8DJyWPIlQnjPJdnoy3eNcYA==
x-ms-office365-filtering-correlation-id: b463d866-2b04-4bce-79e8-08d66658fb0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3653; 
x-ms-traffictypediagnostic: AM6PR0402MB3653:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB36532849570A3830E8E724ECF5BF0@AM6PR0402MB3653.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3653; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3653; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(76176011)(102836004)(11346002)(446003)(2616005)(6506007)(14454004)(386003)(478600001)(52116002)(53936002)(2201001)(6512007)(86362001)(25786009)(71200400001)(71190400001)(50226002)(110136005)(4326008)(6436002)(68736007)(6486002)(5660300001)(106356001)(105586002)(305945005)(316002)(66066001)(2501003)(97736004)(7416002)(99286004)(81166006)(81156014)(8936002)(8676002)(7736002)(3846002)(6116002)(2906002)(256004)(6346003)(26005)(476003)(36756003)(486006)(186003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3653;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: z7OAVUTcjxX5jOkdaSOKMIYgeivrPe7lKf/nhoo1j6lj0ZiLU+gyVbmKHPCVLc6HNLsX0f8bW0jkbvWn2IlpqOhfMmt/V0ukq3058O37WDPfCbP3N8DbRnx7Labc6NANa84AkR5bKLho+CPE5I2CVHP8zMzq5y1DF6dCaD5ZF1DKtDs33C4ioIpIF4fxFMbXxEjHBk9687xjB9DRqGBg+UBLfrahftpALfbIbvOQAU1IVIzGXM5+gwSbboM9eqx4iHtWWtRK8ZkMT4UEX4zrlT5pbGF/SHfDQT8PXuehKW0Wu+AS9SNAeA9WTjFi2XFp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b463d866-2b04-4bce-79e8-08d66658fb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 08:56:07.6868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3653
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_005621_201557_DD8BD233 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation, this patch adds binding doc for i.MX
system controller RTC driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No change since V4.
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index c20f38e..3f3d697 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -106,6 +106,12 @@ Required properties for Pinctrl sub nodes:
 [2] Documentation/devicetree/bindings/power/power_domain.txt
 [3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
 
+RTC bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible: should be "fsl,imx8qxp-sc-rtc";
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -148,6 +154,10 @@ firmware {
 			compatible = "fsl,imx8qxp-scu-pd";
 			#power-domain-cells = <1>;
 		};
+
+		rtc: rtc {
+			compatible = "fsl,imx8qxp-sc-rtc";
+		};
 	};
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
