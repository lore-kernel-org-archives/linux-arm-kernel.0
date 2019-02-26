Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE00CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96E22173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Shu4yJoi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rDypybRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96E22173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pY7yZxLoz+3MGIohqLIDJNT+O6kDZ5NaIaLr1mtGvQY=; b=Shu4yJoi3J0dNw
	8BqJn2ISLiIxKtqXu1v10UKyZfTFO9a1G6k6gjSL6YXywD4xgdUq7WUDCHfyp5DOl3ZXA1mWUKuKR
	XGgcHSRUfhmto4fU8OIYDHLeTcRuEmoWmIOePUHUeMT+I9rf22rkVbRAGUv3l2BSPjAEWlBP6JC0j
	2Ee48Y8MbXna9ZcMXY+scPm+Bn0r3h0+tPUAMWrp9SaLVy+NO9Gby454T1rGG5gwVTtDzEP235qyX
	Qu8e2vq678tdX65cBMa0iyX8w4taos5sIsmcnhEda2p0t8QZtd88y30pyegE+LJa8dvUM0zIVgg2T
	q+9+vF1YUqQd67M+xStw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyWrf-0000BB-VU; Tue, 26 Feb 2019 07:09:19 +0000
Received: from mail-vi1eur04on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::628]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyWqm-0007MF-9P
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 07:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znr2T6ovlH7mTq+u1NnPVFs5YNm/YXTxwScDcqrMY/A=;
 b=rDypybRv7RjvIZ7gVSkCZOolQ9Bx9Kmr7+Dci31jhibASOdXObssHJ3TuCJWMTjuKlAuD0vMcGRqc2XOB3+jL8q0CExprYjD0QxOc7AR8gyz+y6bZDn2LsBHClc8F4Guv8sG+XX/YkUlkWjGAoQPVDPMvjTO87CfBOvdjTgYPNU=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2848.eurprd04.prod.outlook.com (10.175.23.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 07:08:16 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 07:08:16 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v3 5/5] arm64: dts: imx8mq: Enable wm8524 codec
Thread-Topic: [PATCH v3 5/5] arm64: dts: imx8mq: Enable wm8524 codec
Thread-Index: AQHUzaILcOyeyWqxiESp2YdPy1C0/w==
Date: Tue, 26 Feb 2019 07:08:16 +0000
Message-ID: <20190226070742.30551-6-daniel.baluta@nxp.com>
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 438082b8-a9f0-4f9b-3860-08d69bb92e25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2848; 
x-ms-traffictypediagnostic: VI1PR0402MB2848:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2848;
 23:MV0Qo44UVN56rqENrkx+DCx525un/+yK14Gho?=
 =?iso-8859-1?Q?4h1iKRvDanlj69MX12ibSDp6RCKgassVrBEu9Vu3gG1+GLR6mWNRViAeBK?=
 =?iso-8859-1?Q?bV12Pdv3RsK4REW6omaAS4wpa3nVz6XMwduWBYSM2ZnroWiJK2FCYF/jfR?=
 =?iso-8859-1?Q?VmsUNsULzjvNJsuSWVR9rHujZhrDwWW9qLtlS2jmad8mS+sy9i4PqRZXRg?=
 =?iso-8859-1?Q?YFHMHcytflBjDkjngz9aT+gp+fqBjaJHYaGJvF6SKOuZRKsetcq9D99Vyf?=
 =?iso-8859-1?Q?F7PAip42GI7lvAyOt8sVfuiuPn7I5xcf5jQWpIJNuaHeSsGT/8NQji8Qnd?=
 =?iso-8859-1?Q?PSzxxvJH5PeXQMsJjOcv1ZgyNvXyGKRjnYvK4fjs3Q2Xfdch4/JDtAQZHk?=
 =?iso-8859-1?Q?+v/rx9lqbRJtlsEJjb61+eB1SJBTD3g0k3RHJbG5ZWwHSA216LwUt32qTM?=
 =?iso-8859-1?Q?I3IX1YEGXI3JPmFSovNJa4ueIQMBnoJ3PEkd//hSz6thZbk0oEQDqK0oyH?=
 =?iso-8859-1?Q?fUHlHukzuf5vkohOQVbRfFtjkJaV2Jf4IqjLgx042sqZAOmJ1Wev+p2aCu?=
 =?iso-8859-1?Q?XGp2SSktA0cACg/y2Mvp0ldS+ITI2mBeKFNCa9+TMpPhwkTBwegf3nQ39e?=
 =?iso-8859-1?Q?lZGU9RS8ZDQSiPkScwhDLh+iQSXL9WmUGkUiBCbzleISUA88aGkcpUeEb3?=
 =?iso-8859-1?Q?UOBroCUIawCEDDHNoE6+LM786Wb6qcxYBMCksBZ0FsdCUeNyg5P6pWkxWX?=
 =?iso-8859-1?Q?ppMCzfN30rl/2Ecpo99pTurAO861rtDUPDG8fCLuvf4+w/CW6wmaANSYzg?=
 =?iso-8859-1?Q?munLwERNGSLHMi5e2Q5sx8Ry1C4bmy1kyos6Tnxj86xX9X6B1Bh2Ug7ikP?=
 =?iso-8859-1?Q?f+nFpPjmOKOtK6fku43G46PZkuKSk44zzUQmmv3D9EwZyp+wt6X5p+mwPJ?=
 =?iso-8859-1?Q?XZuQES4WTMyg/PaIoGiaL9bYJC+TILFXUrsTCu/Mqru+Tklb0iGVUQ8oxj?=
 =?iso-8859-1?Q?tQmdbctxzXYH3Wnrhn/+fzUgBAXII6iZDux8RdXZRw1gmS62CmTQly1Qtp?=
 =?iso-8859-1?Q?WipbpaR/cmmXOU5PKrbTRnM40v0VqFfu0slYnMXl7WUVrjT4ljZyyTfnlV?=
 =?iso-8859-1?Q?IxWWlpjgAvZdIg0nI4QJlUNPVgDnmkOPZElggwcgEHtZLgxA/kPX451RJ1?=
 =?iso-8859-1?Q?Le0J2VOlSmid9UWyusip+wFG7L+raHCLRsR8DFhEqIbwD7xhREhHw9hRYa?=
 =?iso-8859-1?Q?S2C3hLQr9Ui27tugMjHM+KNDT/XCpRvtc+R9dimLJpjGxcF/rcmIqz5E8t?=
 =?iso-8859-1?Q?SA2Bkb0eRgIwrMeQnYi1+RzWtjSVqcNpENa579ELHnY8zbUtvLfJIGZZPk?=
 =?iso-8859-1?Q?XSN2YJ0+2Z0fEVxfkRVmfd6X5s/mfIy5dzaUOAVp7Rtk2PX/ycc2UJJGk+?=
 =?iso-8859-1?Q?cjA2N/5AHgezsRkU=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB28481ECE22ACFBA17A3E3CC3F97B0@VI1PR0402MB2848.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(86362001)(2906002)(316002)(305945005)(6512007)(7736002)(81156014)(1730700003)(102836004)(50226002)(2351001)(5660300002)(8676002)(11346002)(53936002)(106356001)(105586002)(81166006)(486006)(446003)(71200400001)(71190400001)(476003)(2616005)(5640700003)(6116002)(44832011)(54906003)(6436002)(1076003)(3846002)(2501003)(256004)(478600001)(6486002)(386003)(6916009)(4326008)(6346003)(66066001)(99286004)(68736007)(6506007)(36756003)(186003)(8936002)(97736004)(25786009)(7416002)(26005)(52116002)(14454004)(76176011)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2848;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X/OGAqKXMddRcuFZujNMFDykj1QkwL/sUpTGihy7/a0Vvf5cT8wZqg+APKbunVo8a55dHjWKgVoPGTPc+djv8Xp9/6UM1oDY47XQTeN0DFh/po4lnEj2qWX+tdRnTf7s2kABOZDSAUSIVW5DwG/oo9KzxX5WjLPr3/EIc5e3jtmZBs2+SIR3bFiD+MNpFnVLgmkMQblD7/YvsaT8GKpoESg905hX8kRNSh8Gmn5G6XBBsk+k1R2/ydB1q0/dpflRFT826tG8xeZzqY2AEZvYSZoaYr43yWUocklZ/oylBu0XYhbKi9LZvUih7h1tMy1m2yQXh5zPOeDPzUGVBuKX3CukBgT9LVgX9Oziq9fKQeHw5DXeqmzwUiWL/imLIKu2IPPSfty+U3INeMUJhJF3SsGVearoAQglvTHXmdjP8fI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438082b8-a9f0-4f9b-3860-08d69bb92e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 07:08:15.7154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2848
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_230824_745442_2B0FF55A 
X-CRM114-Status: GOOD (  10.12  )
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
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
