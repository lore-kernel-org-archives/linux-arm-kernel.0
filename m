Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD56C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0ADE21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TTMmYq/M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fefV51u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0ADE21B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=21xoVggSXX2Dk8ADFK1bFTVhGp2FfwPPDxfypX3kSSs=; b=TTMmYq/MOuJZjP
	0YLwath+Taf+IMYcGHwSkhq8y2sOb2FaIWzjsjnttTWjE2KL64uDtz6BMiGiMN90nUpGAma02Bw74
	Rwi2JSxn0qoY87CNNX//eIDax0IYbfHWWVZRhcAVWihQNt4erKnK9X2FRCsuEKbcWqd1J5Bo7pyop
	eCSRa2DGVUJ81pf/9fjX9QB1gnIHC2ZbpwQubUlsI80ZLJlbCTcSK+4Y3jKvQvkJFNkOnQZW2FHP7
	+TIlbAMC7FaC7q/3ioFv4gfWj1c4bpahk5rThK0C02IfwMDWxrCzB2RftuyO6O2iStTDyynNgu2cd
	dORXy7gxC9H4BTxDY8AQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhq0-0007sn-Ve; Fri, 15 Feb 2019 18:03:49 +0000
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhpb-0007Do-9d
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pTJyMw44M0sSHFMGJccGdyQi7L1OyMt3MIHo/pGBmA=;
 b=fefV51u7wCFvldfrzhVvG3MshRp7cuKfGzzJSta7bYyaPjx7j2MgvrrqY3mv3wyJ2QV62fT5WPcp9Ibox1YtrNLCUUO+fH02v31AInh3vVDnu3PPic28oHD//lbykvL+yiqx723Rfga3k7AuO517rVUdCO81JLYyalmU7kWWlaU=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB4893.eurprd04.prod.outlook.com (20.177.49.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 18:03:17 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 18:03:17 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Topic: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Index: AQHUxVi6WWuh6I9YoEaUogbBIjLTQQ==
Date: Fri, 15 Feb 2019 18:03:16 +0000
Message-ID: <1550253761-26841-4-git-send-email-Frank.Li@nxp.com>
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0008.prod.exchangelabs.com (2603:10b6:804:2::18)
 To VI1PR04MB4910.eurprd04.prod.outlook.com (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbe1128d-0f6d-44f1-56e4-08d6936fdc3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4893; 
x-ms-traffictypediagnostic: VI1PR04MB4893:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4893;
 23:+0w/NCNzZf91Q46DKWSOZOQeJajVWUnIj+L4vvc?=
 =?iso-8859-1?Q?VPMx86eP0KxphNe4a8+NPAf6rsg1SG/YuOj8EKK7CaF2DaLwaA14ZufNmP?=
 =?iso-8859-1?Q?/rhSQZrqM4KcQpIS+O+k5vD/Tf6O+IwMcbIFVX0uFfAH79cIgdNYqJHBqp?=
 =?iso-8859-1?Q?a6GnPMMWh0AFq0q1JCUR64fIvbuOo1ZUd4Xmb/Mg2q74Ui11K08sPAH1e9?=
 =?iso-8859-1?Q?3JHgeqfgzExNwbu9o/zOwV2uac1JA/wMk58OoFCqy4udSmpvHV6pWhQjZo?=
 =?iso-8859-1?Q?NP3Jk+7rSIiJstQUmotGRjzlC6tkWar/+ikmvhgaMe2QspW74Qmk+FicVa?=
 =?iso-8859-1?Q?amtG402IPkKU/t0Nvh+kRZjeqR5m7c70KYIEvSyh009ZP/2rYHJAhWr5kW?=
 =?iso-8859-1?Q?BZTeBhL8mlWLA88xRoyVLiRaxfTqCpAk497p/6ZFsALP4xXws62H8PA2yw?=
 =?iso-8859-1?Q?oYeexORio0V3MW7bPzNeFHzvQh6OSTs6+zLEo91VnX8SDC6+u9EOQyQrCG?=
 =?iso-8859-1?Q?urR6TDLU9VwOx5VVtkoxvnF3wGUueVd3hZdPnyOxSz5+2eLwblkLowXdh2?=
 =?iso-8859-1?Q?lfhmqLpJz4qE37ilPx77+HPPC8PDi7ajMvH/juZuJXJ8RAiAIDhz0JCxCO?=
 =?iso-8859-1?Q?B+xl1v9i7HqvyCuvgXnYdKQWz1lk5jTSAtHPamKOv4WqG3vzB8vQs5eeum?=
 =?iso-8859-1?Q?TRvQg9fpAOYnqqeUeMZOxSGnDVFUUVKMsdw9N5Xsv/hCNanTiswPhv+5Tl?=
 =?iso-8859-1?Q?bVBMTyrg8yaT9+NPUEz1dCR+Rg7KK3WJgMHOAS3Is50mPH2YMu2YCbIQS2?=
 =?iso-8859-1?Q?FeL5X83761t5nO7YqHgxP4wQedD3QUPRAaXitgLsDBaaGQSTqdP5PV/o/J?=
 =?iso-8859-1?Q?/3JIs4aO3eoQkqHV+DOOK4RXtu9if2ykfk8fpJh/5rDzzkq8DQgJmzHwxW?=
 =?iso-8859-1?Q?X6GW0Rwk5ibAE13/GzpF557TlzWsASl3A23HH5ayy0el7E/fuo1UxS/wwF?=
 =?iso-8859-1?Q?/ZHlWn/AuibikthxinbE11OA+b2nzEEJbVVIfrbo388PYKEbu0D+yT5gt9?=
 =?iso-8859-1?Q?2gNvsu34f5MHDlaoUQ+WhHBa4EkW3/Nz8aKveY3vs5buCCWdk7PUMX2Spz?=
 =?iso-8859-1?Q?jkoCj3kBYVjSHvb0LewN6QF9DRR+8Lktqm+yKrdrp4ak5QduhKdUOVasbj?=
 =?iso-8859-1?Q?DDHAuSgdL3fpaGsHA9vi0fo8oA3Y0Guh5e09WYauRqmHNUCGhBv7PKoZBV?=
 =?iso-8859-1?Q?1kwmwnRlZHHRXt/LpSiiceAaY5aFuvC950QqP1IqPEgALuE/x+Om8ktq6j?=
 =?iso-8859-1?Q?+o=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB4893103DB34CA39713A2AD5388600@VI1PR04MB4893.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(36756003)(7736002)(2501003)(86362001)(110136005)(105586002)(186003)(6512007)(446003)(6116002)(66066001)(106356001)(68736007)(11346002)(316002)(476003)(305945005)(6486002)(3846002)(76176011)(4326008)(486006)(2616005)(25786009)(99286004)(7416002)(6436002)(52116002)(50226002)(97736004)(256004)(2906002)(81166006)(81156014)(2201001)(26005)(4744005)(478600001)(102836004)(8936002)(386003)(8676002)(6506007)(53936002)(71200400001)(71190400001)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4893;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qn3Ebc2P2MjuMM75QLdh5i2IaLZkJg39HGaIf8U6/oOaIENNU9duZTwyIX0HQdlHTxoEGOrmAaf9tPibNj6eK+xZGGbw1kIS8OA21BCwSi2XMuP31iyRK8jTys68I8v+I1Rwn1LQm/2B7Q9AxoUNh5F7kDQeqhvwO6hpSbSm35VHDNwKSec4jdeo5AG9KzWQ22wCEaB/78prWnqj2QTd1CjJ88CGWyck0St9Bm8szU24D8psnUqqWzq0zwTtz7MTEuw+bHe2VK77UvKDvMK9qZ01uf41+LEPx9I/OK/VzTWvn2VOII8kv5RUw7B0d1YjbS7MJySNxyaJ1RSK6NsXuJr9/vAveYobTGMa2dMQNBpB5q6cI3b2mFk72AeeK7AyGyf20xFv2MgD48Rm9e3P3+Dan5NJ22M3nb0cKvr4wBQ=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe1128d-0f6d-44f1-56e4-08d6936fdc3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:03:14.3848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4893
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_100323_566144_7343FCEC 
X-CRM114-Status: UNSURE (   7.88  )
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
Cc: Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DDR perf counter driver maintainer information

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
No change from v1 to v4

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ba068e..687be0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6163,6 +6163,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cpm.c
 
+FREESCALE IMX DDR Performance Monitor DRIVER
+M:	Frank Li <Frank.li@nxp.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/perf/fsl_imx8_ddr_perf.c
+F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+
 FREESCALE IMX LPI2C DRIVER
 M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
