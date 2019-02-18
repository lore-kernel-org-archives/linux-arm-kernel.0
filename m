Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DDCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEB7218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gS6T5EUg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HTk1LZxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEB7218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rgPssyGtAgb7d4HW4ydQ2e4sdR8+2kP9LSC7d9o1HrE=; b=gS6T5EUg3P0V6w
	qWKGRjtV0FWd0z37poPaDl07k5X0zzNiMyANI7mLRNpNMjmg08j4Wk66sUul4ziQOZEDE0J6flCEd
	wMZnUUK//kTc3Jy4fxHSQ+SvgrRA+tmLOqxYYOzCE4OLqGDg0hoZ216Vb+B8+1EEzfXb33gSer/g3
	mebm/NpfIootEdDn88I62H3MYX+4NRfbFIaipPzvGx4CS66d21YWcFjbizQ2uIaaKTtAf3D6KUwUS
	7Eu3F2NGJhTe32Ui0m//PnSgbmd+d94QDnlCxW9aAsp35m4VblDl2ToI1aFrsF5+PpcuWUxHc7nAs
	0xhkxyD9sMVjMMfJph4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvYGG-0003FF-LO; Mon, 18 Feb 2019 02:02:24 +0000
Received: from mail-am5eur02on0604.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::604]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvYFp-0002kP-Rc
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 02:02:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QMLSql6EjevgxNZgbmNG/v6osMU2U68fnrDgNX1W5w=;
 b=HTk1LZxy0+S0Q7ZGsbR6SPL9TzZkmcm/A7lfzPsmwz5ESCgv668GXNKfdkAI0uHZfbRGSk54/UuFmn5SbGWKIftUovLuKCa+JCIq2fqE9C1QG4w++VF1i9q5qXFkVvlHHRwI6pUXHfm9LhLGcLcdoGqTZSnykyhbCCMw50i/ZFs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 02:01:46 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 02:01:46 +0000
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
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH V2 4/4] arm64: dts: freescale: imx8qxp: add watchdog support
Thread-Topic: [PATCH V2 4/4] arm64: dts: freescale: imx8qxp: add watchdog
 support
Thread-Index: AQHUxy3m3sITWDfB5062cz9aVGPagA==
Date: Mon, 18 Feb 2019 02:01:46 +0000
Message-ID: <1550454997-4398-5-git-send-email-Anson.Huang@nxp.com>
References: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daa3ed33-d690-4e1f-6c66-08d695450921
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3642; 
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3642;
 23:yPD88zGlam796L1B3rXbjwC7t/DMi20vbJFc8?=
 =?iso-8859-1?Q?q+8P6dS2kEfAuNDbd/M4G1offlM3ediBqAR8rCyIYHAUYUrkuVkZad1Syn?=
 =?iso-8859-1?Q?YsDGBDaIHn8MnCHCRfEimjxex5eWzwxvuXwhK1HPvx19Y8DasMU7I+ohV9?=
 =?iso-8859-1?Q?bXtx9uSUsVASHyc/Xd6ZDNx0p6lYbVOZqtrTzlKGZfZjM55NjOiunSIt9m?=
 =?iso-8859-1?Q?OMTms14gdST4RjfVcNNkXCC8I2/vg+b8p74TCBQvdC44kyA9vfSNKtDsm9?=
 =?iso-8859-1?Q?Bc7hnWjsxtxuF9L0hPBvsazRIlzlF4n5SYsYUW92J3rLBDpgOLDM4zRiU+?=
 =?iso-8859-1?Q?4XvPAHPvRGdizLsfYhrkp4cJ6c14Y/UCwjUy/m2Bgh5tkyQW+OdKFNe/Kb?=
 =?iso-8859-1?Q?P7Pbt+PPtrFECtPg+UHXzPry79M7dKb3Sr4FvRs+IfpSUlZDQb/4qwTjpL?=
 =?iso-8859-1?Q?spQOEcLbUdi+ZxhjqTQp7LZTYelpgkdw7QwZn2qQud9IVDz1yVCe7KK2kd?=
 =?iso-8859-1?Q?4qUTy2pmncF4NrhuhJyMYOpl9Wl7mWDthse3wb89YmDUfjiiLtSGpT2IIv?=
 =?iso-8859-1?Q?rWTTtNTV8xovddz0TfVLN5YX9bSMqlL8dJRBJU4XiUqKO3oAQnYDfmWCOh?=
 =?iso-8859-1?Q?2ncK2BPdt6ZQcT8t6otv+cO04VjaCG83ScOigHlKuji2eEE0d7gbobqHdn?=
 =?iso-8859-1?Q?vxIuCNz06tVlwxZUJm2Bqu22Q61Iw+rCu2msWuKf2McyEatuMdq2Buk8zN?=
 =?iso-8859-1?Q?b8zUd5DM46Hk7LNnbIPhHbisVsQxNUVF/SdttaXCrs+EfdiRlCIYjgmgR8?=
 =?iso-8859-1?Q?RpRZdqotr5WvOboLb1HhRnPnrXfdGAtBYklVmqmfE8BqyMIGjubnczs3UK?=
 =?iso-8859-1?Q?ane69EhBLKkICS6kId1I+Iw8duJ2ytCG0zx1LfN0gFaQE2j1NhjYd4R85W?=
 =?iso-8859-1?Q?MvyFfO7ydNjwFyIknwnJUmTleyk6OD2lo5vV32A/+zbGwS/ilYB5AT+uZw?=
 =?iso-8859-1?Q?iBUQlEExJ0aOyANjhNDgCGGeTEr2BJX5UBQJyQQxxcoXAECimZzYkuJ6jm?=
 =?iso-8859-1?Q?rzuH9HMG83gf8Gcf7mF+2r+sUA/sARpyHrp7vzQowQ5/5WL4KIMBPh5xps?=
 =?iso-8859-1?Q?ZPFgoZCDwjT6XkT2iVyGebweUjjyQNXdjKAI13mBameRTkKlA80ib1Q052?=
 =?iso-8859-1?Q?GM08IcjoYveI0pzM0XmwN97h8MP22rgGE89fZNykxEBApH0s3k23/nNyiM?=
 =?iso-8859-1?Q?d7WJ/lWqTTtaGqC36Opj+StK0UEGd1l/LWWX/T0w3VwZgLtI3Dc4HO/DUI?=
 =?iso-8859-1?Q?Y+4bhYVIj25IsPu1C+7qVIwuQ/OhGHKJOoAPdhIK6ynnAoGwmwLu1AhdWZ?=
 =?iso-8859-1?Q?qAaE2teomQQlqx9LQjtvmB2hdEIxmbU?=
x-microsoft-antispam-prvs: <DB3PR0402MB3642CD10872CFEC3EC959C63F5630@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(8676002)(7736002)(8936002)(53936002)(11346002)(446003)(2906002)(186003)(26005)(71190400001)(966005)(14454004)(2616005)(486006)(305945005)(476003)(71200400001)(7416002)(86362001)(386003)(5660300002)(6506007)(6436002)(68736007)(81166006)(81156014)(6486002)(50226002)(256004)(6306002)(102836004)(2201001)(4744005)(6512007)(105586002)(99286004)(76176011)(52116002)(316002)(110136005)(36756003)(6116002)(3846002)(97736004)(106356001)(66066001)(2501003)(478600001)(25786009)(4326008)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3642;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v9l9VLpuUcDa+L0mRkFFggbH5R6xb0EDQRMfigqQoukjSMd3I2YHr1Hxlp6dFAv2uFQNL0VJf4F+u4iJH16SLmkclQarggQJPXLGDEfxFfgSP/fTbn2nQn9lzsAVULv+FREg16M6kSpjOBhsgRSqhJ5rLyop2lfIJmA9OoG+Hn1NU/CEgswkKzERzhlok7g2wVsmNLHUFasGuYWVfVQQmnzMUhDws3O99aKZoDIloDyo/pOkO2fBPs4jSywPsgTuptvITfsKmFViNhG6omjAphpVTbRgr7Gbb8xo8l7mAQG2PaMUeDb+wtdPDNcguBRjNOIv8qDWVFrAa6YjHl66W59RS3/4O9wamGo8m+hrweAXGCe8ctQZ54ZlGFK2QQonbwVeRUsdn9bTbsYnpwQjxnc1bjISUi9LXQyB94qSCOY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa3ed33-d690-4e1f-6c66-08d695450921
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 02:01:37.8714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_180158_272850_58A744FE 
X-CRM114-Status: GOOD (  10.44  )
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
index 88eb04b..bfb77a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -123,6 +123,10 @@
 			tsens-num = <1>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		watchdog: watchdog {
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
