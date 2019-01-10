Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D941E214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TJH+FrhV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dEVabNWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D941E214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/AUd6eqoQuWFNFjV0XwgujvRysME+X6pXtWu79y0QM=; b=TJH+FrhVHQUfds
	2oF0RSmg6gHlvR7FBJF6jzXXNp6b1x0h+GPLkxA+hJuuN7TP9lovv388i+LM+KE1ibjm2PGxIOUIE
	yK1w4jDBPPK15fgefV42m3WMY2ISYdJWiYsh2QoqnzcfNzy9mlOKCCmMbkl1/9bOdMLttoYrgd0a7
	y0ZEml4leQo1ixw8HCgq0uGpo+vUnsrclCHm5wSIo5B4HtUtg/fOxEv+Ty6PHzghJYeNhn13gvFsB
	+omoQQiJIVOKFU7iPiUBwKSjMpxswp9gOwia8FqFEXRRQEy6alzW6Ctd3AeE2eYV+zPe5P6CYNBP4
	Hb1Wn/XoRJzc5DeHgJaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbzA-0000SF-5k; Thu, 10 Jan 2019 15:11:08 +0000
Received: from mail-vi1eur04on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72a]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbyi-0008Qn-M2
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3NQshP9lIPHHAPMrelZKkEChYzI3ptRTj3F2NAeNDc=;
 b=dEVabNWPaZHqKvwOwFtLweor2XQTsUGV1p0c7nm4VQiOjdCZXRt3xN6QesFY/VO6xCAAeUXCNE/0Pjh8UTygUEr5dq0/l5HnzQDmYi/AeeBeTFQMELnNqonCIcoiAEae8MDxhUOpkJrX7DHb+6N2G67Thf6cvWxeCk8b6le5q+o=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:39 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:39 +0000
From: Peter Rosin <peda@axentia.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a plane
 is rotated
Thread-Topic: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Index: AQHUqPal2z9iTYzgb0+a4YlOuMR4jQ==
Date: Thu, 10 Jan 2019 15:10:39 +0000
Message-ID: <20190110151020.30468-3-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
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
 6:arwSSsVJDO4D30SFKsbe2Y9ZC4sW5T5+T4JgSsKt+v0Abo+baQ4T3oP57UWSPaXlJ8/rfiieUdDMGrrZRMJSATMck94+/VMa/dSXBa89o8jVc70Q68Hvj6RQLnk5mWbsVmt/VOhivaq9PX5jBLmW0ItPDWQ2MZPNWgDp4kP0kNvkFCvEoAPcbrunE6Fia39CMC33ZHzQ3CNyvIWJ530JpW/Tqk3w3aJFV5LO5q8NrXUrKPm32U45T0JDsfktYWTc8qN30KST9m77VL92boxBuV5CO7jU6rTrp1mBSAQcBD/6a0zXkUlBQ0j+vmmqe8Gyeo3ZgAEzTfUQQgwUgktq+yNzl1q9pxTFPRmPtt+B8+Cx8EBmsKl7hJ2M9gaOsXSyzfoxIXPNtBa48elWU2bgg5Pmd5QUWVrx/yTaA1HogLsKkjbZpkuSeuHjgXssvAweXx9m9baCm/HYKdKPK7015A==;
 5:yB9RRPl/+WJ8VpUNMdf8DwLWMA41wC/hdpK6N9WNayTJtH5N89D+0Twm7NMBkFn3zfqN1KAZ72HkdfNb/vDJZqGsaiFzoLOdFHn6p0euQCajMfOB9nn0MVOOb5AHaL73h6DKBCpCH4Pc5BcApVYM9uUpUat/FkuvuDoniSiaacZy/Q/bsRrAFs+4Bx0vf2TfqNtKZCxvebv7LbK26EDvLA==;
 7:lQG8cfzOIuoXgTpEzF7iOGVttWsQZfzNHMGLJxpH/PVCxIzsQsDwaufhlk8Q6Sfy5NJggeE335auAy+DUGLAMDyfomULWOIOHe6ZduBvPpQ8ND7cu4J7YwzbOr4kogYSRC/YE+PcKeWJ1V04lCqb2A==
x-ms-office365-filtering-correlation-id: f6ad3eb1-575e-400b-208d-08d6770dc7ae
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4037; 
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB403782F5A08A417100BC50FFBC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR02MB4037; BCL:0; PCL:0; RULEID:; SRVR:AM6PR02MB4037; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(386003)(4326008)(6506007)(446003)(25786009)(26005)(256004)(11346002)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(4744005)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(575784001)(6116002)(8676002)(86362001)(54906003)(74482002)(76176011)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4037;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e6MbwdfETt/ygnp79dhOdG7HmbTYYF5zr4ejqJbHC/0d+7JQM7H9jeh+3vGqMXCUzF2n41HRmjyjw8rt1rO+3NSJw9szKG1yfch3IztRFz6w5cDKKnIVr0/JfmKlDepvlaWUGZSdtwqxtkkbVvwm8r4lMAc47hZvKQmhAJYX8LEhdoixvc75A1BhqGQDdkQS8ba6+lWUn04aXR7DG9vKsDHZCWVwYDq4i7FGFRLtct9/Tnss9PwvjHpCovjVsDdvLkEMSJVhO+ot1v7m5gUDHZbx5veeiKt8jyC10hdZaN8BNiYiRb9HW9ipSINs8KjD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ad3eb1-575e-400b-208d-08d6770dc7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:38.2808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_071040_968232_25ED95E0 
X-CRM114-Status: GOOD (  10.26  )
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

The destination crtc rectangle is independent of source plane rotation.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index ea8fc0deb814..d6f93f029020 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -642,9 +642,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
 	 * Swap width and size in case of 90 or 270 degrees rotation
 	 */
 	if (drm_rotation_90_or_270(state->base.rotation)) {
-		tmp = state->crtc_w;
-		state->crtc_w = state->crtc_h;
-		state->crtc_h = tmp;
 		tmp = state->src_w;
 		state->src_w = state->src_h;
 		state->src_h = tmp;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
