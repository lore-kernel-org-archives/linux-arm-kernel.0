Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49696C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:45:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1587D2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YBZQ5u66";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vllE9uvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1587D2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EX/f9giWNtmmtLO1AU/EL42SZA9yw1hOPAurGpvq1Ms=; b=YBZQ5u66D6kS6x
	+JdvMc8ZNDy92898SGGX1HTSRYq8o4U9S3yEDh6ZhW8Ew7F6vuinOjQyx2NtIJSKeXRHMlhWhQZr1
	ahMWDmmuVsqyFnpIqtzKxh7m1bdKinRv5U53Wv60Xgh04cd4/+pthUCqKi1rMY3sBx4NtfiVw5Q3b
	6deOW42eOWVjQjyjc//PveXXKKFSqUKPHu0XVhBsixMNMXkpJ/H2SDJSBHIGUjuppxrACkBmrn4QU
	P68P7pkG1CpFwI2G4fIhMkyUjISnmLaHnDsMjdA4aD5CoOkz2+UrB651XUM6OLlEaZl6J7xB/HKT2
	3X65a5zA66DsxLTSTJiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guFSg-0007ks-P6; Thu, 14 Feb 2019 11:45:50 +0000
Received: from mail-eopbgr150074.outbound.protection.outlook.com
 ([40.107.15.74] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guFSB-000779-Ow
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFxBmBQ5xry+PwCvHhDWVwS/jaUeKvCAaREGg91NBIM=;
 b=vllE9uvW6PtJyJbarZQgNOyV0i9Gw2y2AlnG7w9Ew9SLe5R05uAPkERqXCeAKfZvAZ88DZW/VUIdyE5Tje5iOjTqM8wjfJwmUXH43rrPJ6skqUB5rx4g6LveTMLoOXNsXwPcefZH0CSYj20Kv3F0F2Pc8N9RXhlOpT10OjTjgrw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 11:45:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:45:14 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH 4/4] arm64: dts: freescale: imx8qxp: add watchdog support
Thread-Topic: [PATCH 4/4] arm64: dts: freescale: imx8qxp: add watchdog support
Thread-Index: AQHUxFq/P3E1yDIEi0CPA+Z0+GhX4w==
Date: Thu, 14 Feb 2019 11:45:14 +0000
Message-ID: <1550144346-1187-5-git-send-email-Anson.Huang@nxp.com>
References: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ce65700-51ec-4331-155a-08d69271e1fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3676; 
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3676;
 23:994hI/KM9+QWwTqXkFvmd6m3QHgp/XXhIgWiC?=
 =?iso-8859-1?Q?4YejjJs7JTd//ovA1NPkHVFjroBSdTWTKmbdlxSp2XM3uZE9JXsBeBon6i?=
 =?iso-8859-1?Q?MXYlX0bwo1LlUAioTlqz36NRZ9rC7xxClP7aI5kceb95TSmxOfxY9zKbab?=
 =?iso-8859-1?Q?9cf4PapZfc3Q7t8vE8cBZNzhKqzSqZwFW6OAnEve5EZrqPkX8CMzlIsUPl?=
 =?iso-8859-1?Q?DcynPax22RkM745TBkcHO3jXeuArJgoPuMLGHhzvJC/v24kRMnPwA4a9wR?=
 =?iso-8859-1?Q?LVECtcJ/IOwM3a6kD14zErajoMrkSmyEomXeFjB+voG0rRgs+5Wr6vTEEG?=
 =?iso-8859-1?Q?2G/VlDuPd5L6egQsF6eQjLU7Hr1sFiVmGf+VLiTUt/WUbI4gr+ZHfhDREs?=
 =?iso-8859-1?Q?lnWSVjeM8+bq74vUzEfPLdquPSvbs1rUWpU0Cx2+2KfSNxAW0fzDbytm83?=
 =?iso-8859-1?Q?loXrm/X32UqazvIx5HNkdPH7KyYkTe3p2AyXPa0kd3bxygbUrHuJ5rD7yQ?=
 =?iso-8859-1?Q?CLp8pyH46hWsRhzaWZVwRR83Vq1LEsT7VrOoZN7g2sULeIldLXf6XrRRmq?=
 =?iso-8859-1?Q?mPCM7yCAowv0G3pXTFsTCexRdHdUQcROcx3vdloGDQjNJ+S6t0mxlO6fR7?=
 =?iso-8859-1?Q?qldDfDDnGWDUVzPELYY2omlyaEe9aWm0VUaJ76DGMFU2yARlhI7jQC/GPi?=
 =?iso-8859-1?Q?ZRVuP+0gsMckovJb5qaJUBWcEmPOe/KL7QWB2SJuQ8OROKgn9nHSWj0/gn?=
 =?iso-8859-1?Q?XTdjs0TBUnDPNyEadZxDUmOUXB2joFvbLj8yrcU23NrQjKAcX3P5zvtE3B?=
 =?iso-8859-1?Q?0r/RdFw+v69pd0TTd6Urv4OEYKTGhFrStJ5zlK5Qz0VfgO81Bmicg43b2M?=
 =?iso-8859-1?Q?9TGN3LhGnQfUG2BcQ7LaiRI1ESirv+AhUS+1PjUqeQUBkndl9CSNT2sPnA?=
 =?iso-8859-1?Q?h9ZZMxknGqaeQp6NGaMy82oG7pCqLdSzYEEzn4z/CZyRLznGgUgnV+K99g?=
 =?iso-8859-1?Q?9WaIZkw4F4olmMrtKrY20tzsFbJStaKEQL6ukirawTYypbB1hRvZs1jYtR?=
 =?iso-8859-1?Q?Ar15d5IkrQ8XsObXBTQLXDOQg4YCs6Izp6snPlbVIpYPESRJyz07DHg4Im?=
 =?iso-8859-1?Q?USvfCLvSwwICWPSQu9ZovQJdvRHqRCE/XbzLYDituun34QxSU65djPvSyM?=
 =?iso-8859-1?Q?uS7cfw1WLs+9CW9wDyxfW8X+q0hikB+JKwH1jaW65Q3wG6APBcyo/+YhV6?=
 =?iso-8859-1?Q?JpJq+00TV3obi86gWvEkhuqg0GKp9CHRJUqavhpy1kluBfSycHskg7GGgn?=
 =?iso-8859-1?Q?TezQCaqmIZ2vwigaxe3Z+KAmsyodwQ2P+wBTcaVSaYlbIL5CG/b3Zc/IOC?=
 =?iso-8859-1?Q?RY1bZQ7nwk=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3676B595C6AB7AD80C28E4E7F5670@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(476003)(2616005)(486006)(2201001)(6436002)(36756003)(66066001)(106356001)(7416002)(446003)(25786009)(105586002)(186003)(6506007)(386003)(11346002)(26005)(3846002)(6116002)(4326008)(102836004)(99286004)(256004)(8936002)(81166006)(81156014)(8676002)(2906002)(14454004)(7736002)(97736004)(966005)(4744005)(305945005)(71200400001)(2501003)(86362001)(316002)(50226002)(68736007)(6512007)(6306002)(478600001)(6486002)(52116002)(76176011)(53936002)(110136005)(71190400001)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3676;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lqT+Ur7IbvCtYDK/U6XF7EfR3clGGsPJbgDCy0k8DegvRsDHcTGABwlVUpqQm+qipwdBm6KtaznL5sKHZAdaDeMNaFidLrwF0KTSV/F2xwAmE3kuroWm3tgdcBrK3PiEcX8vRKI7mH8Wq/fyR8+oDct/mzb3DFx3xf0FiWmAVkTTuJlZLzE5WKoq08zysLMWW8vhv5Pu/Oo75ni07lKwB+R8qzzS4CIUp58HgHWMGjty7uG1wuTMXJ1GQP1Sw9E8PY73ch8yhNHgkspNX82f5tZCe0dF49WYB0rXqoRF/NCgR632LOE/DfCiwccb18+fs02y3rQ/YmxLkeirlOlA1xIEeLaeD81DTLYPIz5wOYfjx9nE2pDQa57c1+roA+iEpkQtPu4e2mO9P2ZEahfi2nA4BT0qanS8Fmk/lokV79o=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce65700-51ec-4331-155a-08d69271e1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:45:05.8229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_034520_146423_CFDCC3A4 
X-CRM114-Status: GOOD (  10.18  )
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

Add i.MX8QXP system controller watchdog support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Note: this patch is based on my thermal patch series: https://patchwork.kernel.org/patch/10800699/
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 1bf0e3b..087ba41 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -155,6 +155,10 @@
 			tsens-num = <1>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		wdog: wdog {
+			compatible = "fsl,imx8qxp-sc-wdt";
+		};
 	};
 
 	timer {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
