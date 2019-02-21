Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C17C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D812084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KMED4/RT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tAE9Oj2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D812084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZIv1eNUnsHwwjcL2ajlQO2OmAGZa/d3QMVfGAF8ti18=; b=KMED4/RTQy3Wk9
	29gOGBivklX3J8wKEh318ZZMKaDzQsoNv1YGsaGJBaqH5BxJfSANZfdUV9kHefNAjEe+0CbRwh3ya
	xYCwGPBfP36ruPzA+scC9V3QwScVPioEeXLCmHyiOUM/S2nfdLMMDiqUL5rP+VyPI8H9kzuwoTjts
	287ruoAExjb24UMQKvkDbbp+w3ix4XHE4dYQlyTuFizM45U34PRRknh5PUuFQUhIvBOFsPDghr9jk
	SZFgljauqwdCUTGuj/hR3wr0WubNJM4+lPq39Ht0DhT3U6062BDfEEza2UnK2aS++LEA0JUWHq9cE
	LEwutkum3+POAt7Dn9hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwt1i-0007AH-SD; Thu, 21 Feb 2019 18:24:54 +0000
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwt1f-00078w-Ai
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnvcsDBxt1PgMZxTnbwyKjSydSkHHsmiYBw5iiuo7qE=;
 b=tAE9Oj2ZoqQiywQIDMOqw9uLB5/RY8BJnJrro5aN1bMrJc/vd9oPezXWvbZBLfxKkQrBtVFfNByXV3Cj8AMVhYvljO/uWGl20ZM/m+ZXqYD9hHH+vsLmI/VSoNacB/XVeGnIvjPeiQJdxbVwO0U2xWBsXHdcYzb3hMiuvwxlnrs=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5599.eurprd04.prod.outlook.com (20.178.125.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 18:24:47 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:24:47 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/14] arm64: dts: imx8: architecture improvement and adding
 imx8qm support
Thread-Topic: [PATCH 00/14] arm64: dts: imx8: architecture improvement and
 adding imx8qm support
Thread-Index: AQHUyhK5HIlcqARyxUuDwYokqv0lcw==
Date: Thu, 21 Feb 2019 18:24:47 +0000
Message-ID: <1550773093-13349-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100cdb78-a8f0-45cc-ccfe-08d69829dbfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5599; 
x-ms-traffictypediagnostic: VI1PR04MB5599:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5599;
 23:Q/YXYKKm09stCbRmpMYxO8wGETOKJwAdNQUWdnR?=
 =?iso-8859-1?Q?67FVTmtYa97urboPUW82WU3bzQeu7qSm19wKKCY/OuT22LpKlYqG+LB/aE?=
 =?iso-8859-1?Q?G9+KeoFe8TJbKu4L+gcuC0Tefle4aHD5EiUuNB/aqmB7KizMu0BLCu5Vhx?=
 =?iso-8859-1?Q?HCy07O7n8py/MiHXE2Z6iEb+c1CAM0B4l+Ul4U3c1xL1rlHIQxOEeDmFmF?=
 =?iso-8859-1?Q?7zWVW1JkdvvUwrNUhLfz/ZTJOM8NLWyTYY/vQ5RVCMWMZpL9hh0NPNoDQJ?=
 =?iso-8859-1?Q?1DjVsqsyY4fGEae1U+G2n95edYbjyB6IXWWl1ctLzuYwV+tGnzP2XZemxI?=
 =?iso-8859-1?Q?upnA3IvptzPmwUWrrGUuO17omyMop2lBUMRPPBotmz09WS9y1QezuHpbMx?=
 =?iso-8859-1?Q?vN2X5eA0EbBicZkdcp25CMZrZ/4+mvs0X7MuGd8LXkg6cTf72a4hIW7P1w?=
 =?iso-8859-1?Q?n4b6PSx461zcv4AqH54lrFNNX/1eoIB+NkuLBw/QERzejSVaiy3GAQ8jMI?=
 =?iso-8859-1?Q?eH2gkirRv/ceLN6UMLfJYeIwtUOHlEIRLlWHerBvi/EsjswKg2Ehdv7zw4?=
 =?iso-8859-1?Q?R+mjbQmicTQ07K2xQiDsprc6HZfQT0jz/4b+Tg1rwqU9TY8kTrQgvvjyPD?=
 =?iso-8859-1?Q?rbMQBcLpW70SifihSMp18cYD3eJs+Az8zB7HWILTclbdKPqtW1RVMrf/DV?=
 =?iso-8859-1?Q?EjrKZ7Z1qwPpYWVUI56uv6hSZNKQ6BYS/TyC78JoqokBkZ2ryzSm1IZzBs?=
 =?iso-8859-1?Q?BVwUMdRFjqJLiYQWPVA7EMYMF9hTQ+ZJ2fJJHYzSbF+Qb8L7l16xS+bv9/?=
 =?iso-8859-1?Q?zGtDl1e+5kZwno3f6gNF226wIIdl51hUVfhnOU6QYORQzHFVAsM9m42Nv0?=
 =?iso-8859-1?Q?HeLhCdS6+mGDayyJuwGhwwADJWIJzP5exI0EYSufMDgkZZEtVSxCcqwoyV?=
 =?iso-8859-1?Q?WIafPCAr7IC7dLM42EkQWNh34aFvgGU+hQLKezd5MZS4vkWtghKr1AqkBN?=
 =?iso-8859-1?Q?1MB281cFnxd5V70RZ2nUHVB7lqMCTNmm+EDAzIGYerKqNseAuEHgxemrk4?=
 =?iso-8859-1?Q?pvhTS4ZuZ8AtPWgFrx/1xC7F08XhOpe/ffZPn2MMIu7WA9eHEZZScHWDqb?=
 =?iso-8859-1?Q?Mgxu2+Z6Ks+/ThrsnctPKMAJ2zqbTGhDEhz8FJA5tiOvVC8tLOyjv6HYCw?=
 =?iso-8859-1?Q?ACOrB9LhiyMntw00PA1UANZ8Pmomt8KdHsAk4YVZ4CIUJCvWQlCrrA83Ee?=
 =?iso-8859-1?Q?3w3Jg1TnR1taVPD+tdFp0utK81iEbAIZiLhGkK9UZR8pfp8ZLl2qFE2qKM?=
 =?iso-8859-1?Q?5pX34n+0qwBuHLS/cjxIFms?=
x-microsoft-antispam-prvs: <VI1PR04MB5599B1E91E7DA47CCDCDDCE0807E0@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(256004)(53936002)(106356001)(71200400001)(71190400001)(81166006)(2351001)(2906002)(6916009)(105586002)(81156014)(44832011)(316002)(305945005)(97736004)(6306002)(2616005)(8676002)(54906003)(6512007)(7736002)(2501003)(68736007)(386003)(6506007)(3846002)(486006)(14454004)(5640700003)(86362001)(6486002)(52116002)(6436002)(4326008)(8936002)(102836004)(5660300002)(966005)(476003)(26005)(99286004)(478600001)(6116002)(25786009)(50226002)(186003)(36756003)(66066001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5599;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j7CXAyzdcI49h0WACfWn64yYRaqqjUajnSA4sJ3qfcox7TkjcdeCcWMfhfwy79CxtRkbFiQnKDV1Hy5aY7GK9WTiB3o/LSoBTpb4iE5P1xrvCEsQC7hiW7ODjb7sdwREdJgv+oPzQkqF0lSDMAr+eSUgoP5STqZJPNP6Lh/ZuHKbu4wX7AzGpaYJZiBgaY3lNaOkESydLSxWHGlEqMyO1SuDBuoVuA5josSu9WmEHNNSTqP86Q06W8p3YSmOTAVFpX1oVTMjb6yvBh2X6n/lFFlzI/BhPAZLrY+S9r6yKjC+JoALRKN6TlW+FcdMOZbFMirS9SE+boA7/OO/5A26zjBCni/w4DxywRpLAAmqxbL9N5AhrOPDFtjVl4TBC2bmhDMiG7vuZJxSR8BtnbevX32erqSlUF6Jco5nxQIjXrc=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100cdb78-a8f0-45cc-ccfe-08d69829dbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:24:43.9270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_102451_367162_CF21B954 
X-CRM114-Status: GOOD (  12.02  )
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
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

IMX SCU based platforms (e.g. MX8QM/MX8QXP) are comprised of a number of SS
(Subsystems), those SS may be shared between different SoCs while most of them
can be reused like Devices Resources, Clocks, Power domains and etc.

This patch series aims to improve the MX8 architecture to comply with the HW
design to save a lot of duplicated codes and benefits us a better
maintainability and scalability in the future.

This whole architecture improvements still needs other two patch series
which are under review:
1. [0/3] firmware: imx: scu-pd: generalize the implementation
https://patchwork.kernel.org/cover/10822221/

2. [0/4] clk: imx: scu: add parsing clocks from device tree support
https://patchwork.kernel.org/cover/10824443/

This DT patch series depends on the 2.

NOTE: for the missing undocumented compatible strings for the new SoC IMX8QM
in this patch series. It will be sent in another patch series later.

Dong Aisheng (14):
  arm64: dts: imx8qxp: orginize dts in subsystems
  arm64: dts: imx8: add lsio scu clocks
  arm64: dts: imx8: add conn scu clocks
  arm64: dts: imx8: add adma scu clocks
  arm64: dts: imx8: add lsio lpcg clocks
  arm64: dts: imx8: add conn lpcg clocks
  arm64: dts: imx8: add adma lpcg clocks
  arm64: dts: imx8: switch to new clock binding
  arm64: dts: imx8qm: add lsio ss support
  arm64: dts: imx8qm: add conn ss support
  arm64: dts: imx8: split adma ss into dma and audio ss
  arm64: dts: imx8qm: add dma ss support
  arm64: dts: imx: add imx8qm common dts file
  arm64: dts: imx: add imx8qm mek support

 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi    |   7 +
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    | 274 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 279 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    | 351 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       | 144 +++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |  93 ++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   | 171 ++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi  | 145 +++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 173 ++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |   4 +-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi | 129 ++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi |  89 ++++++
 arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi | 145 +++++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         | 320 +------------------
 15 files changed, 2011 insertions(+), 314 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
