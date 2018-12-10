Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC7DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD4C20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Znse2/3C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TzPnW/TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD4C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jPoUm47ywEln5puXoTHeUu3fB6hn3aRL9DFXCrmDqk8=; b=Znse2/3CvKcrSV
	e4j6QW8LNEv888C7lzlRX1mAYVoJMuBYoxbUjgc1LrHzK/oR2aoKinsKZaEOzIL/JY9mEGsQ+O7B3
	TInsv0plY6juuZ67WmP1skuojIB245EmeVmVIey7ehPYxmf60HxFXQQKhp8LPSG7i9f9bBsFFdEZ9
	nF4zslaVpmUlcAUDJrdIoMsbFGYfxs7yIMREnYD8fcbTJI017BoqmkgeJGPEu1yisNGS4w+iBpvDI
	5kmAwmgEpqU9ZmlpOUgiEEuyEphM+dcxT4ngIjM+WKBhipSk0EcRPM2Tllp5Dxdr+acIhWc1aLldE
	e650CDRKSuqsPYKAMg+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOlP-0001I1-Vt; Mon, 10 Dec 2018 16:50:35 +0000
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOlM-0001DI-6r
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfB6S8viis25hw5/MhMRPiBD5zG11+uXI558SSJ4WPw=;
 b=TzPnW/TCqG4PS/k1xoardZP4e1ndyy96fqfU7fzGj0PrbSG3v11jPzgXEcT5yjhHkuVA6LE7yUyZbt5+DKqnZnk4JnU5syoLXUjOVCmUc0bUfJ60HDxZZ/X5NUoHlntX3EoLnMhtfmgGdV7ie8Kzma0wbbKY1YeuOy8qPNI9rSM=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2750.eurprd04.prod.outlook.com (10.175.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 16:50:17 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:17 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [PATCH 0/5] soc: fsl: add device links support for devices on the
 fsl-mc bus
Thread-Topic: [PATCH 0/5] soc: fsl: add device links support for devices on
 the fsl-mc bus
Thread-Index: AQHUkKht9srZH6NoRk2FfJWJEHs4dQ==
Date: Mon, 10 Dec 2018 16:50:16 +0000
Message-ID: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0145.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2750;
 6:s5EtzLgR/ynEiIrpYTd6kv2Ze5JWEkDUxvw7VnpAgrGnKxEdELl5v+wN0+jjngOTkgUG3/t0nZpE/GsCODi4FzpoWDKAe9kH4FtjUlU4uDYyrbBmVKxo61mLfAdjCUjwiUPlwNGSNCnBpQz8sNRcmKmmfIvhyw3xbqbd3+9aBNPHXs3YR1b0KGV+Zah2aqkaRruvl52EQ09GLALk6KW20ttpvIM+zz+3m0g1eG3mAeoF2S6O/bVuSlGN1zdCBjFMNDzcZzwbqKmcxEkBtZ5ZgEZVtU8zGKp0BI0UnuGODZaWN/Q+hYmlSvwupDfY0n3r3CL5nsZMu83DaCSD7KpKF+U9wmMoo2+QIdDJjaTnrWLM7/bNdB9HmQe3lRG5rWd8dj8llw1Ln8yQwavhsOymxzjyzu10WMKhuBxt3RmoA4PzOZ9l2+BGLUT5DtJxxTxcebJB6vO3qsbpQp9TBGOWIA==;
 5:VTss370IdmPk1DiVZMQV19qdDrFY3rxXRwsuz20fcBImRfOnG0dqf9ZEoHimbiRhaxF/+IXnE3+1yd7XINXmQwMoRfXutw+2WtIX5L0DZh0sTjBP03UQ4P3jhYdS2vD4j4AQjXWScZfuVJiQYT8OJAWdu0hKS4ScCuHGigrEGWs=;
 7:Xu0tfzxC/4X2p0nz8sfuapLXxEaePUI6/evoWK2Ql5/m6yIIkl05LrdddhKqC22PY3/Drv+8tfed/kp8dFMlEikjM6+p9XbQ2+AyYiawQrr7vVOjlDBbbrXPV/lZSeun3FNLPnB9qSiHGRKpoXRcsw==
x-ms-office365-filtering-correlation-id: 60cf9629-1836-4991-4505-08d65ebf8ffe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2750; 
x-ms-traffictypediagnostic: VI1PR0402MB2750:
x-microsoft-antispam-prvs: <VI1PR0402MB2750823D0B09C0E74F769E46E0A50@VI1PR0402MB2750.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB2750; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB2750; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(186003)(2501003)(44832011)(53936002)(2616005)(71190400001)(476003)(2201001)(3846002)(6116002)(71200400001)(66066001)(486006)(305945005)(7736002)(86362001)(68736007)(36756003)(6436002)(81156014)(14444005)(316002)(110136005)(8936002)(14454004)(81166006)(478600001)(256004)(54906003)(25786009)(8676002)(6486002)(99286004)(102836004)(106356001)(26005)(105586002)(386003)(2906002)(97736004)(5660300001)(6506007)(52116002)(6512007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2750;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DQz+G2p8YcRWyWsDh0g1X5l7Pcz0gDzRWZy1qTrqdeZiJ20dfSbpjd+UGRqGGPhKeSuQb9ZeBxzK1H3fpFlWlIh/ZpERhrec4RQFiLGiiTA0K4GTt1jlZc097rXG/XbV6XSX0MLqsFbrnUja2XailujrkSF/AODrKLyLftyW+EQ4AJLTnCFjOTk1Vuo3ctgybtXR5rtsQ1ECDFWRvnuqMsPdtiblcWOeJa7yQO/oAlg5PqHhFeVNURHq94I4xW25U9y834/cxsZ46D+29qTRjphqxTYmsoINu1keG8RBMN+i8Of0p0e/VKMdXf2d6kGh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cf9629-1836-4991-4505-08d65ebf8ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:16.9646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2750
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_085032_250177_BF55B11F 
X-CRM114-Status: GOOD (  13.01  )
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
Cc: Roy Pledge <roy.pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Horia Geanta <horia.geanta@nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The fsl-mc bus discovers and exports devices dynamically allocated
by the Management Complex firmware.
This patch set adds the ability to automatically create a device link
between a consumer device on the fsl-mc bus and a supplier one.
For example, a dpni device (a network interface) requests access to a
dpio device (I/O portal) using the dpaa2_io_service_register function
which is enhanced to also add the corresponding device link between
them.

The first 3 patches set the stage for a proper handling of device
links while the following 2 are the ones that add the actual links.

The internal management of the links is not exported to the consumer
driver, but it's rather included in the functions that actually allocate
the provider device: fsl_mc_portal_allocate, fsl_mc_object_allocate and
dpaa2_io_service_register.

Ioana Ciornei (4):
  soc: fsl: dpio: keep a per dpio device MC portal
  soc: fsl: dpio: store a backpointer to the device backing the dpaa2_io
  soc: fsl: dpio: add a device_link at dpaa2_io_service_register
  bus: fsl-mc: automatically add a device_link on
    fsl_mc_[portal,object]_allocate

Roy Pledge (1):
  soc: fsl: dpio: perform DPIO Reset on Probe

 drivers/bus/fsl-mc/fsl-mc-allocator.c            | 11 +++++++++++
 drivers/bus/fsl-mc/mc-io.c                       | 13 +++++++++++++
 drivers/crypto/caam/caamalg_qi2.c                |  6 +++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  9 +++++----
 drivers/soc/fsl/dpio/dpio-cmd.h                  |  1 +
 drivers/soc/fsl/dpio/dpio-driver.c               | 18 +++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c              | 23 ++++++++++++++++++++---
 drivers/soc/fsl/dpio/dpio.c                      | 23 +++++++++++++++++++++++
 drivers/soc/fsl/dpio/dpio.h                      |  4 ++++
 include/linux/fsl/mc.h                           |  1 +
 include/soc/fsl/dpaa2-io.h                       |  9 ++++++---
 11 files changed, 96 insertions(+), 22 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
