Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A50C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:39:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A79218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mxWexErB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YBQLAO5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A79218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pY7yZxLoz+3MGIohqLIDJNT+O6kDZ5NaIaLr1mtGvQY=; b=mxWexErBTTCczw
	HPcwFptWsxDIwwGY9VKVuo7VAFZ2c6zRUi4EOzi9HvufFEc2AjNY7C3Ial1XqC6OXKkt7CV1TTccQ
	HOGqLQoeP6AwiPSsPDZiuSQncdUPtjfEPnfAuK4vBXvWeg23w1GkFD1nEF/VYjEAh7scdUfuIxxHu
	cUo0Ul7VEhyAPwGk0fIg46jwqGU6/XplR57icwf5tyQzZQAI6HfKpwKzJKXFu9tpgYhtAZv9pb1Ho
	4Jo6x3bSgk2RQgNKKnrLMmc5FJy5MBWdZQVLoBuFBbGJmSBnt23qmePWN9koj0yfk3YEc+/SP8s07
	9xwy+4MB1ImFsiMbiPJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyssJ-0002I0-QV; Wed, 27 Feb 2019 06:39:27 +0000
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gysrG-00010y-MN
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 06:38:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znr2T6ovlH7mTq+u1NnPVFs5YNm/YXTxwScDcqrMY/A=;
 b=YBQLAO5pJqx4GcLv6m+yIyUcG+3n7uxIRX1c/hgJ8s13cKqlOR2ZC6OYROzpfK/9VRh0Jjq+DNGJJVUwhvwmXSUP904ASSREYA2+2YfKsVJZs5ee9izSBpcfi/wDLjeLHtKNAtEWRq4odss9S/ut/d1ny6bGxyam9bKYoMt6u1s=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3615.eurprd04.prod.outlook.com (52.134.7.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 06:38:14 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:38:14 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v4 5/5] arm64: dts: imx8mq-evk: Enable wm8524 codec
Thread-Topic: [PATCH v4 5/5] arm64: dts: imx8mq-evk: Enable wm8524 codec
Thread-Index: AQHUzmcEULvmnDg7TU+BAacRV1wDzA==
Date: Wed, 27 Feb 2019 06:38:14 +0000
Message-ID: <20190227063737.24445-6-daniel.baluta@nxp.com>
References: <20190227063737.24445-1-daniel.baluta@nxp.com>
In-Reply-To: <20190227063737.24445-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0152.eurprd07.prod.outlook.com
 (2603:10a6:802:16::39) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22b439a5-a46d-45b8-c6ef-08d69c7e2660
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3615; 
x-ms-traffictypediagnostic: VI1PR0402MB3615:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3615;
 23:+gipX/dV2EM2umJjF832Gngn67gWY5uFYdzfl?=
 =?iso-8859-1?Q?iVP1CyqqyM/KGFjKo6ZOwuZY7GEQyE3IF+nQ6zfae+uyUC9RuhmWX06n1v?=
 =?iso-8859-1?Q?qP7M4R4PVsbAobodYYlUyYqm/G/uHNd13YT3grZ/ZhbZsw5BSCjKwptemr?=
 =?iso-8859-1?Q?o8b0HBzXL6SYW6yTWuXWjo3Uxj56Yg1h1/SHhZ+TrxLQpkEusQNVrTTIxt?=
 =?iso-8859-1?Q?A2Nb31+cuYcQCjLzVDO8qDqUtEN+Ol+x23dHhTpCEWhXlYbs5zt3KKgWu6?=
 =?iso-8859-1?Q?B75/rt86EEQo+RdgwCnFKkBps3aX8ldK201KT5Ug3qLhdzXjbwzXdVT9C2?=
 =?iso-8859-1?Q?hobjODy8Jcpkg7eWXZ5Kg24NNvKih+vzpeG9Po/TLHYSEzYEEVw0zeU/yk?=
 =?iso-8859-1?Q?1IJTqMfglVi4STNIZwgO1OmjkhBg8rEbxBkz76mHMdfPdrekhJz6adAYG+?=
 =?iso-8859-1?Q?6lzFyV9GWFNks9T7+I5Nu1u8pCQfxYEsayD92dPT1qEWe3Q6sGm4kx870r?=
 =?iso-8859-1?Q?Ojcfdojx68zK7pTf0VBD+uULy4vaUd3J37mwTT0VNeicyhf6Xx58CiTVYm?=
 =?iso-8859-1?Q?+vINVSpW5NisvURXiqmx4N3zxUmVE8UHITR5nxDg6gFeISUlqfvkZwy6Ti?=
 =?iso-8859-1?Q?RhHxjkPuhOMe9RAjwZP2MzmIZc0nUZmgWkhkEJC8tJGgrohqR9VcQ/j2YE?=
 =?iso-8859-1?Q?8StDIY7UR5JtHQJEFpe1p27zdtFNbojfxv0JnWF9+KEcasRo9P2K2jjvVc?=
 =?iso-8859-1?Q?Ho/xrM1HeorA9LfEPNpz4cP6PT78Ey9uiOa8R6Hdl5zNFW8h+gz0996Jo4?=
 =?iso-8859-1?Q?4LFbGq3tvBObOmiata7E/07eOOJXN0uDePLd3PNclObhlYPkLD44sI8xJr?=
 =?iso-8859-1?Q?jLUW3jmlU5ffX2+nvU3skZGv0gl7seuAiCJ4pw0M/SIhZaNYRMqamEWJTz?=
 =?iso-8859-1?Q?0Ykm0jwqt7OqINN+ck4lObyWqrhJY+r0ksVQzcAb0V86/MKHDHr7LX3YPz?=
 =?iso-8859-1?Q?vMYafWzmUh/KpKV+OmkvNbeopIrUnumZWVqz6WfADauBh5wBePARAugEAP?=
 =?iso-8859-1?Q?kV+zF7qX73ifUHdxCOOl4Cfl6yrjXS/umVV3Srnpx6Q+sP+Y3zmfnhiIx/?=
 =?iso-8859-1?Q?+d5JwukqGvR8Ei2uOmF0geJc5X6oHgv1rsqtKxAjzyOanOi35o6yj6lb5y?=
 =?iso-8859-1?Q?ZkYm1oB/p6zO6gAd1sso755CFDS5eUD5SzPL2oQuGkVCQaJF6XhFnhEV0a?=
 =?iso-8859-1?Q?xuufs0tz2Izt6D6fGrLJKelYaU8UHUD2xhcZk7KreKTAHLRylezQBLf/cP?=
 =?iso-8859-1?Q?t4YxwwJSFLSKeDVS19DucsXoQyh7EjiGleRpiGllds5D+0kK6BlSKRf9jN?=
 =?iso-8859-1?Q?o+vx0xbIwG9/NqALJhReOCXMDqLLEfO1wBin7s7WTVjk5t9DEyUlg=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3615B34E74E333B2043F7A01F9740@VI1PR0402MB3615.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(2616005)(446003)(71190400001)(7736002)(11346002)(97736004)(71200400001)(305945005)(66066001)(81166006)(81156014)(44832011)(7416002)(5660300002)(26005)(105586002)(486006)(68736007)(106356001)(6486002)(476003)(86362001)(1730700003)(8676002)(2351001)(1076003)(52116002)(8936002)(3846002)(2906002)(36756003)(99286004)(316002)(76176011)(6116002)(25786009)(478600001)(53936002)(5640700003)(102836004)(6916009)(54906003)(186003)(6436002)(256004)(6512007)(14454004)(50226002)(4326008)(6506007)(386003)(2501003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3615;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: //fShRMHUsRYYZVytwpfWa5E63QdnOHhnwdIsZao+8PbMYpw580K/45RNHl0231Awt1zxvK69jUDU5ekVVGJQfcwIBwUCL7xJ63j9uV6stZeqjFlceUdwTAXlxZEqNzzwDetOikxf28OEFd8chzuJivPun9yQmeIym9akMv5p4SbKkuyKZ0GmwFHSMzNbaeP/cp9EqJkXGm4D8OumAieROBGMa33CpPmG3sqpWuqKg5adB8pFThn+UQxpR76xmL1MTeZfq+ubjXl2nKeIG7Rp/VsgEu53666gkkenXGbfb7Yj01dHyqgPmfB2mh28oKViX3I5jNAgO6iFexfCQxmE0OaKuu1j3l992cJEpwQUMcaZlNpiu3MoR1u/X8JzIiM2FdyPGU4MzVp/8LIyAdL1LIXRSMpL19FwYAGRi5BgAU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b439a5-a46d-45b8-c6ef-08d69c7e2660
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:38:13.5037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3615
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_223823_020179_DADEBB12 
X-CRM114-Status: UNSURE (   9.52  )
X-CRM114-Notice: Please train this message.
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "spencercw@gmail.com" <spencercw@gmail.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This uses simple-audio-card machine driver adding 1 CPU DAI
and 1 Codec DAI.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 58de4a3d6029..77f590c13ee0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,35 @@
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	wm8524: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8524";
+		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		clock-names = "mclk";
+		wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	};
+
+	sound-wm8524 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8524-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,widgets =
+			"Line", "Left Line Out Jack",
+			"Line", "Right Line Out Jack";
+		simple-audio-card,routing =
+			"Left Line Out Jack", "LINEVOUTL",
+			"Right Line Out Jack", "LINEVOUTR";
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+		link_codec: simple-audio-card,codec {
+			sound-dai = <&wm8524>;
+			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		};
+	};
 };
 
 &fec1 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
