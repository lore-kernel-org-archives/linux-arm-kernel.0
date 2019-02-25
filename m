Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B57C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3803213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SO7V5oF3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MH0/iRTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3803213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pY7yZxLoz+3MGIohqLIDJNT+O6kDZ5NaIaLr1mtGvQY=; b=SO7V5oF3a/kZBj
	lrRiRVmqOMqyzd1ICHmvfmtIpQscaf2z955ajrEVwsuYXlRMPUob3sVfpEYwF+DBJ6BBmazRZnPMV
	cd+YxIHwaeb1s4dyl3QmxW6sJEUFo99vDzq4C4pGpv1YMzWnzIQNNIG7iAdXugU8SUQme8T7loePb
	EiUy3rza4j982TGB/Q9MQvheqmZXBz/E8OG2mKMgzxc27Nn9liWqnM5uu3jXq0opGrTdDz2dlG0X1
	zpGExOJU5mStk/I9dJshTUn5Xsj9YgI0axrOjNrG+jsi2NSZgP4u4HeYgCttKholagrazVNQtIkTj
	HruipUT+2M+AEbNA3lUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGIF-00058x-3d; Mon, 25 Feb 2019 13:27:39 +0000
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGHP-00040i-Sr
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:26:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znr2T6ovlH7mTq+u1NnPVFs5YNm/YXTxwScDcqrMY/A=;
 b=MH0/iRTQoacyupeIbl+9Sk24RtLhug750TIbWCiOw9IBg0NTZbTeYvsuZRI3xGw/iNegat++o+U7ijubb/HHMxKQHrEpr6TkBaX0tYMgcKYr6noTcpmaPiEvMPb21peR75vGJkglK7JT0pqd67uvdZWM7LW5bnJLjLqFoomm8hI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2848.eurprd04.prod.outlook.com (10.175.23.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:26:40 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:40 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 5/5 v2] arm64: dts: imx8qm: Enable wm8524 codec
Thread-Topic: [PATCH 5/5 v2] arm64: dts: imx8qm: Enable wm8524 codec
Thread-Index: AQHUzQ29rxqqHbREuU2MYYiTHMV1fg==
Date: Mon, 25 Feb 2019 13:26:40 +0000
Message-ID: <20190225132617.10987-6-daniel.baluta@nxp.com>
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9aa39755-d38e-41cb-1b66-08d69b24e037
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2848; 
x-ms-traffictypediagnostic: VI1PR0402MB2848:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2848;
 23:nTkk5W/BJG+RF/Er7wMgruVmAC06D3F4q/FuO?=
 =?iso-8859-1?Q?b9cGP2qpV/hwTXkYt2eMRE+M9NVYIk3JrWNySuNWIEjZQ1r5eyJ2BHdjLY?=
 =?iso-8859-1?Q?bzddKEwOUyo2+LAXN5kIz+KCqqgMMbCna9Jta+trI790x7qGiqwV+4Ne1t?=
 =?iso-8859-1?Q?8p47sgkiYD8EHUV9gGp4X27L9lLUKH/x2IpQHMw7UNYHbCBG6FYywXok3V?=
 =?iso-8859-1?Q?xh+xDikmlSp+E3H76I0W2D+YYG3o0QoqaSF0mCMJGpxcPNk0aI/kEoOAIP?=
 =?iso-8859-1?Q?e31YeqiOTXY0feRuQcFO4h71mlzQR1DJEVfLV+uS32GZtlwevDZIwaldwU?=
 =?iso-8859-1?Q?bi2+u2i7N+2we/9CIMitJXG1KJhRyaS5kNgkPOwiJYyejHJDv7pDxCa5tH?=
 =?iso-8859-1?Q?t3FnD6Snkn3u1VodTTL3vocbGw2FsmIkffTMW1PTJVVoEUwnbBrK4U6QZW?=
 =?iso-8859-1?Q?pBlrMWt1NIebonJ4Zlmfb6lniA1P/JBAVFEv8l+ls62E6AYWj3LwuGP1s/?=
 =?iso-8859-1?Q?ffBB6EXKW4M46dwkutRVxw0LzrRH4HzO4T0e0BlO9jeVvP9n80sHw+/nhK?=
 =?iso-8859-1?Q?BH9/XzO8SiEDKk1XJHY2Zz4eVDex2lNS0dCvEpXnyubZocnXrSOKH+Y3/m?=
 =?iso-8859-1?Q?RTkMZ5gfTPU5M7BnQmfHrWG9l16QZMUTfAmNWg9JwKbhJ04ZkK3LfUdT2z?=
 =?iso-8859-1?Q?LPb2Ao401r4HJF+q1qs+1FvYwm3Rzz+1Lu27Ah5XoZePKJGXQ9AqYwudbK?=
 =?iso-8859-1?Q?m2xGXHSVCfByv8PszXm3xSAhpQdt0it9wpt0CT7+S5shimRDts6RJc9L2t?=
 =?iso-8859-1?Q?Dx0HxfV9lGh5YYtjey45xSlKAWG7OlZwmKUBBzupfkW0wTI1+sGBmPAanN?=
 =?iso-8859-1?Q?RRVVy4WRiv3sTerovPUDKafSTl1ZfbAmHgUwmBZoM/yq5gvdh1z0Vrykz5?=
 =?iso-8859-1?Q?wQPhpM6Wym848bRRVrtLLelTEm5IfoLyd6gIMWhsbJVhOay/onHQLw2kRa?=
 =?iso-8859-1?Q?tDl3nDsC0o6btxX+8jyRwVVhkhFeUb5Q3OpQImz/6eTweFQj095e03tN95?=
 =?iso-8859-1?Q?Fv3BWfpmCXVC96BkxOE/z4pVHA6LKtqnlnnf7vZ115/hbq09RlAK4JwymV?=
 =?iso-8859-1?Q?upbvS39eLBwDSpejCSh8HJKNGwUArCftvhdGhWnK6vUWBWRAe/IYk2Mavs?=
 =?iso-8859-1?Q?081xacApFICiSfifs9EBZpMMKHNpMxryHWJy24cd3omLvQ1GF7sGk6uhWD?=
 =?iso-8859-1?Q?bExq7MOXc/cdocNnp6drFwlZ7Imh38rXbOJSd3hZ6n2C5lj87psPTGlswj?=
 =?iso-8859-1?Q?GpTyb/YaqABOfXRKoDTf12BNMOAgrMUYqcAlzU2TQkFTPJ/Bz1JNsv2a87?=
 =?iso-8859-1?Q?DYooogcK3DC5zlZynXnzNwl5Q+FkX6YfiPQ30WdkVa5kqoQoURfDj5qI/W?=
 =?iso-8859-1?Q?axTPwb5q8oK33YUk=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2848647F0B8FF4649A4FE279F97A0@VI1PR0402MB2848.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(6346003)(66066001)(4326008)(68736007)(76176011)(99286004)(6916009)(256004)(478600001)(7416002)(386003)(97736004)(25786009)(6486002)(2501003)(26005)(8936002)(6506007)(14454004)(52116002)(36756003)(186003)(50226002)(102836004)(8676002)(81156014)(1730700003)(53936002)(2351001)(11346002)(106356001)(5660300002)(81166006)(316002)(86362001)(6512007)(7736002)(305945005)(71190400001)(2906002)(6116002)(5640700003)(3846002)(6436002)(54906003)(1076003)(44832011)(486006)(446003)(105586002)(2616005)(476003)(71200400001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2848;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jB5cFgSyGf3xWXjjg/EwBu0r/sSga4K448npyy6o+LLwxoBCjUhEfxZhLuNRcDTsRckUO8GKq6/dV7UoHqQEFwXlCgcqzM5tBoKtzKmQUCKtV2JTLTEuAozuA2/40pC5DMmy46lOQ7XWUu/o3vYkAO54Sn2PdWcdn74gsAJhTd4Ofi0l1Kyli/zDj6B9C1RLqRu3npeyU7gosBsTT0Wn2zk1P/HQKBgjidtGwD7XewREZnKi2aoNgp+F2pkC24iEenVCC9Xy5SyHM+YIiFkpbarW2jTpYWstjMXLboun3VPVuFaaGPRqQ4Q1JNH+dJg+G/0Udod3+g5sNegaOY6Ba91pOvNRUcfVDxltCn6C5xiPIZwVArzq58AX1zpI5aKblJ4+n5W870bqFOwQTaHD87mcEL9PJFkhS9fgEAeWbn8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa39755-d38e-41cb-1b66-08d69b24e037
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:39.4664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2848
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_052648_233360_2352DFD9 
X-CRM114-Status: UNSURE (   9.59  )
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
