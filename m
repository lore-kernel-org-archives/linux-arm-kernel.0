Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9BC218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="owjg/UP0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="seigI/Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9BC218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kIVBO1EEniqaVDE4Z3+JRGCiBgFrMX088BU/kIlAv+M=; b=owjg/UP03lfTo8
	ijc2mI5BagG2lk+ijatmRFoiT+E+7PmdcBSPHdmMU+A6Sqo5OnSvLjJAJIZoM4ImWv6av4jnx3AoF
	/bb2oQ4aJktT+bkSFEASLYQMN9tPywkkUmCOeezQ9gvgm97DpKYH3NmVBQzR3/dtyV2kMLjSwUWRM
	WKcf81ZYckqMQpBiqd+uhzDLH1BPo10VvIqabaTangRFK10AFmknEpxRQ4iQuaoXKw7uM7x39lyu3
	TVcLtb/UI3455zEP35verSxudyMu79yWZlyu+j+UmbyyYLw0K/AV6TFGN55/uwj/LgXA1wbU32aA2
	TdHov6Y2bQtQ9byfynuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gysrX-0001HZ-HT; Wed, 27 Feb 2019 06:38:39 +0000
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gysrC-00010y-KU
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 06:38:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPUsXWxsZB5XW8r5ONaJ3SD95O0BkKIXaPFIzHU0wmc=;
 b=seigI/KpgSphiFQcqP0vCcDB+uQG4HbZB2sw3UW3hyokqArF+T+gAUNrm0KRn/7cT2Wc5o7uuiVIUGB1NVGcVO3UCLbnG617Eu0JeRfTryg3fla0rnBZQ72LJ4dFMRy3e2Kd72xEj+jvqGIEvq8EHpqGvaFx9z7kIt1mFQ163e0=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3615.eurprd04.prod.outlook.com (52.134.7.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 27 Feb 2019 06:38:10 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:38:10 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v4 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH v4 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUzmcB24s3cEdmLkqI5IzLVEaBRQ==
Date: Wed, 27 Feb 2019 06:38:09 +0000
Message-ID: <20190227063737.24445-2-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: 28e2cb24-5462-4af2-f27b-08d69c7e239d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3615; 
x-ms-traffictypediagnostic: VI1PR0402MB3615:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3615;
 23:kaduvLqmk7stOvletJDf4wLqNbIcI/gLuV6rN?=
 =?iso-8859-1?Q?Ve8YzSdWOLqDTa7eyLsI8+TJz06f6ZxmI4JL7fl5NhMI8Uwihsxr3XAED8?=
 =?iso-8859-1?Q?eSc2urBQsL8SHlqt6vY4hGYW2GPteY33ARpDZH/Ogs1GyYC8c98carbY15?=
 =?iso-8859-1?Q?yiB2v62EtvgyehRRsIn+nDDHRzWMZF/0mP94DXiN1y7LuLaplRf99YjdiJ?=
 =?iso-8859-1?Q?/r+WkOJV2UlkFRcwh869FnQXzD9OKUgiyY38GBnkp4AJgxlM/KJgSdIG4j?=
 =?iso-8859-1?Q?x561ffDPdmUGRWq/9gEESdtcQjomyfcNREbYJaBls8jfvPvBYgW58BNZas?=
 =?iso-8859-1?Q?hlxGpZ/kXO8jWqjgSxw3KosH9fpP8Iivp7gV3zKJ4SSK6t1yh2+loRgSLS?=
 =?iso-8859-1?Q?VuSPE/XnulFlZZOIoJv/SYBGIK6BhTkcx3VqoFE7nFLiK9RsHZj7a3VY+7?=
 =?iso-8859-1?Q?VWZp3QXrkX6QJtUKU9McVLY6yeaAVTRLkXW3VMieSQ1tPfvy2xyo2OVV99?=
 =?iso-8859-1?Q?w+Cbcxei7Sv2RqVJXAsXn77OycPNmeJ4W5sPbiNBhESYfTNe2J0TJM6pxA?=
 =?iso-8859-1?Q?EwWCYWDEwN4jSh0JlkdtkdgjhJZBOmHQv1H6vJZnxNn8MaD8Jid5JfwEuL?=
 =?iso-8859-1?Q?fZnN2x95c1NjTZwvd079VqTh5DQ7tMERk5x6MqazBYvKO6obi615PZavGQ?=
 =?iso-8859-1?Q?uN7zmX0SOmqAD2YSkAvGSsNCOjNWAKvLj53zaRTleMpEUeTrC+mWmbaysk?=
 =?iso-8859-1?Q?QRlXwx1f6v6QXW1x7cQL58ZNKJtUqkcJx/pYVpvD9MUcXLllXna1Et2kMQ?=
 =?iso-8859-1?Q?6nY49HU4+MIKBx7ZJNlBrOhvG/WTB1wp0NWw2h/qdAmMmwJt5UqpXS5wtn?=
 =?iso-8859-1?Q?4VqnUui7flKp8DS1Wzub8xvYBBMvHF+66+0RYe5eEAqRZ8/kCOsM3oAWsj?=
 =?iso-8859-1?Q?A8TbI/eWg7JBqirMWgvNLxU2R2tqZF9UZ85QzF/Q90U0BGY1W5RdYwkMHT?=
 =?iso-8859-1?Q?o+MyqoNl5vS//YNC3iSZX7s3KRiVL+p0ByjcQqwSTY5L+RogPVPk59MTfD?=
 =?iso-8859-1?Q?yUgDRaEmz18h0Y352ijLHYIIogTNxnh3oR8DdybamJQMJfurEN7y0uMSpc?=
 =?iso-8859-1?Q?NYdZDFhuZoxe9kK332+aWW1fOdPa/XQKRjvjF6ff95EQZoZ7If2PqKrq3+?=
 =?iso-8859-1?Q?+KBMfT5Tg6wbLbJwgcWYue6V5iHgkD/ZtgeY3pubebpwvpN7tW5qWU+G6u?=
 =?iso-8859-1?Q?DR7ruugEBuN8R+af3MO6MOcfCRnhmG9AxtVH62uAuetb4N5LEbICWdTtnE?=
 =?iso-8859-1?Q?4eYfzbcWDgeHczTXM/WQGZS1rFlhfIzgyLwQG9TXebqybqTO014rEZJr3n?=
 =?iso-8859-1?Q?pprManCTEao/Lnvzs5YPGkgYzHvqEWrtbv9H0lQUgp6Kpy37tuQQERFPDN?=
 =?iso-8859-1?Q?mD9j/itjr+1LIyow=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3615A36FE6A9A114055B7A4AF9740@VI1PR0402MB3615.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(2616005)(446003)(71190400001)(7736002)(11346002)(97736004)(71200400001)(305945005)(66066001)(81166006)(81156014)(44832011)(7416002)(5660300002)(26005)(105586002)(486006)(68736007)(106356001)(6486002)(476003)(86362001)(1730700003)(8676002)(2351001)(1076003)(52116002)(8936002)(3846002)(2906002)(36756003)(99286004)(316002)(76176011)(6116002)(25786009)(478600001)(53936002)(5640700003)(102836004)(6916009)(54906003)(186003)(6436002)(256004)(14444005)(6512007)(14454004)(50226002)(4326008)(6506007)(386003)(2501003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3615;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l1VRMr8b3gceRmbv3u4YDv5lGxVo2s0kWc/XwmF4kbbc2kHj/VnqVWVC04uwAlhb80spGNjtExinfifMHNiqW3NJKg+0ftxBp2DzcQEJfvVABBHL0pmfSmpyn6rrwziEoa+nkr9HqwX/NGLtlRhYclgltOWSjXDYTY3ITiZNVsZ9gHlaOKoAmwQN2gTuGrTemeWBCBJd+AVZHyjyrptUspcPMjpkl4f6wJa8gDs5iUTGj+nI9uiiS+iRA6WKi8i2n0S5uKZcW7ylTh2SmcObOw5WAWmC8I9iGynDamXGRErwO3vzb1gQMr++LZX9gdRRAw5r2GfpN02Dl/ji9Ailtv5yGCsdDIThlCqNudxBoMCoqI4DIoLPeEI2YxdNX1v7YTZVTu/ggwRDWrn0vhUX3/3EBaV2NXmuM0YZFzd69Gc=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e2cb24-5462-4af2-f27b-08d69c7e239d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:38:08.8333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3615
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_223818_828448_45ED2D0A 
X-CRM114-Status: UNSURE (   9.54  )
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
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Anson Huang <anson.huang@nxp.com>,
 Abel Vesa <abel.vesa@nxp.com>,
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

SDMA1 is part of AIPS-3 region and SDMA2 is part
of AIPS-1 region.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
[initial submit in i.MX internal tree]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[adaptation for linux-next]
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4784eb..9d48450453fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,17 @@
 				status = "disabled";
 			};
 
+			sdma2: sdma@302c0000 {
+				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
+				reg = <0x302c0000 0x10000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible = "fsl,imx8mq-iomuxc";
 				reg = <0x30330000 0x10000>;
@@ -575,6 +586,17 @@
 				status = "disabled";
 			};
 
+			sdma1: sdma@30bd0000 {
+				compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
+				reg = <0x30bd0000 0x10000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
