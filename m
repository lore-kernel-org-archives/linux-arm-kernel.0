Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419BAC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13413214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qLssa/LE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="O3DhrJDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13413214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yqdjvGNMkXIdKPh2LkPh5SMXKQmgMcUpVmZiUtNOdzs=; b=qLssa/LEqXR4pi
	y0dgovRyAuKwoKEZM7YgT1g/dpe3Mzi5eFfbcFuwfCdSrP/bfpm09cjUZKSMUIIuLFnIQqE/BRZRO
	ds7IQBANn20S54spql8/zUkEcid2LFLXwZI0M/h+SFrkbzCxpLNJzKlSP+tLVvs7+ae+zLkJqyYXq
	f5VhYPxDnY4cN1C5rKlaDcAOT9xVkbowqGN4+n/6/WGG7uVhpeJSQ7832XIGOS5h3p0/s753/Utcp
	VGKZYK+ZGSB0jAvYanK1VNuARCGRvNyQFqwnqqzI3OGdQnpIAuRlOcnZACJwPm1bjxbVtavJkB8eo
	U2qtyXtlOC5Kl+BArh2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbyh-0008Rh-UB; Thu, 10 Jan 2019 15:10:39 +0000
Received: from mail-vi1eur04on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72a]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbye-0008Qn-03
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n+QMSdfdtUXdjL08xadSpzbZO2LOGtWgoZhcadHgZU=;
 b=O3DhrJDX1BGH63sS+7AlgEmt3Q8aGnH5uB5b++3MJJlleatwIIlO4XqR7CpzcvO0jvz4C4RZTlsaT/JomQUxEQU9+MOTfTfLs7MjlJggX+4hTo4kS/fFAulQJQNY2e0X/PcWjFrq7dTvN5kt8W75Md9yvwXSobbdvdD9C6ykjXk=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:28 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:28 +0000
From: Peter Rosin <peda@axentia.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqPaeuHFV8522kE2kP/gCblgMKA==
Date: Thu, 10 Jan 2019 15:10:28 +0000
Message-ID: <20190110151020.30468-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR02MB4037;
 6:G8Kcj0vO2NTx1WVVLDqFWwRoBQXMEqoaL7wAnVUeWi0CH6Qcla53HJWo1mYAmmgpWc70q4hPird5QJnFwxIcUAJi+j93DhB4wTeqql0HI1fGMmogKJ8pEOZFUZMhn1jhtPaCve00hTS5Dtlrkm3vfGEXAmg/RpmVRnzRbBhryDScPjS3KFR3+KqKeohRr3zZHcarlN5hAuakx/O+ABxAxtr2ckBIRLtr5Lknijq95xlhjYI8GMD7ZoMG6dNyTOLgad0pVkj4QXdmZHrQ7kh1d86u8wmvBzvReWGsaGl7H9ZvHkF33hF3ZlSVKQEnJL1Y93OQGDe53/badJ/NNE5WafQxPOgzZ5/H09P2p9lUfXvuMVyWaLMbfuuBn4sm3Bs/cQsH8P92VzgLE2buMFmXkEF07FTnd2Vvxusu2OXxTcZxYg9V8IeGuXQ6RZcQimx2noxCT+f5cvRNHptnvNvDrw==;
 5:Ysd7c8cDMdS+R3kCG3Dez2JyXOi6c4mGagird/155OX6HtcPHHPShVUrsBQ4VRWUkKh28qImdAhsaG/2N+jFtY8OATy3A4xjgtWnv6AuN89gMgN1l7nT+v1lsvfYeVu3uM15QUb3kvTENJJ+sMv/4t0D5FjGarpUS2fsppmP13X5irEcogVGgK51t3l6ONlG8FUpivWHElRw3vbVFg8Mng==;
 7:iFdt/lvb1fsMxvpRPx7D6+rZHztsiEHomofHHl1NCxIx/qwD3NG3kyAZ13igzQR1VjDAxJ+hnGd+hNlQBBm0xmgFqq4yhcKDAdLBPI/zb+OcRj86GFkch9S33AesXODxjmdswX/NW7jB2NWcSfADRA==
x-ms-office365-filtering-correlation-id: 8408dcce-613a-4e1e-06d5-08d6770dc101
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4037; 
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB4037B9CF5B869BB03F65B91BBC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR02MB4037; BCL:0; PCL:0; RULEID:; SRVR:AM6PR02MB4037; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(386003)(4326008)(6506007)(25786009)(26005)(256004)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(6116002)(8676002)(86362001)(54906003)(74482002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4037;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JhG07iMEH4OYnjoxlh2bhoUK2psTqxSmqyyEj6VTn5VsKM/I9bmCb6CD3kkM45kjpTJuo3lm6bjpJAX7nSwChpTDOU/+4X7d+rWvXlYH5WJ0DMNLHCzlPQQQkTlzD0bv3qMGRmr/CuyTiKo1pOdSXywGLF2/tkL5AWJsWcL6AeKf1RtW80LPfoeTjGL861ib3L79G3xLl1abQ4dlVz/v3VX3+DD5kUM3DprhQCec+NiDL2fVF7aLqEFA0PQb8u6esnV3om82/0g4cQ+qXy08Cm+b8UmXMINXpPchtVkoxnBkskLgdg2vzSyjnVzRMng2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8408dcce-613a-4e1e-06d5-08d6770dc101
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:27.0800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_071036_242599_9CB6DF28 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Peter Rosin <peda@axentia.se>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi!

I found an unfortunate issue while recoding plane handling to use
drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
which is not correct. I simply fixed it (patch 1/4), but maybe that
will cause regressions for unsuspecting users who simply assumed
that the clockwise rotation was correct? I don't know what to do
about that? Adding an option to get the old broken behavior seems
useless, wouldn't it be just as easy to just fix whatever app to
rotate the other way instead of adding an option somewhere?

I have only tested this series on sama5d3, but I did check the docs
for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
and sam9x35) supported by the driver (relevant to patch 4/4).

Cheers,
Peter

Peter Rosin (4):
  drm/atmel-hlcdc: rotate planes counterclockwise
  drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
  drm/atmel-hlcdc: fix clipping of planes
  drm/atmel-hlcdc: do not immediately disable planes, wait for next
    frame

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 179 +++++++++---------------
 1 file changed, 67 insertions(+), 112 deletions(-)

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
