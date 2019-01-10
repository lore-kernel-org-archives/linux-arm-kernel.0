Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24417C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46C62183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeZq/k/C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="K6Td3zqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46C62183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sXzvUA7VkbB8UX4lOcyJy0pE1ADKfCDjb0/pQL5t6O4=; b=BeZq/k/C/t/EP7
	zeYNkR5xwDLwwln6PVRH19xxEgFNlYxwsOpRqzabYgvoXy4ApoIID0X8GwIyJTyty8CCC5mGPUgTw
	n2jFW/ZZj0CinxgmXMcKzv+yflao5TGsX8Fe4og2fXHkqAT8U/2i40tOI6zn3O7b4KSvKm8Zce15I
	Qs8M63OVI3Qmg0KRlNMk6kP1sVZtwElZsdI+9tGV9A1PIclssmatD+0fSYy4rlzHUvtuoUjMWUa4C
	4bQuxiwNaYp4485ZdCK3szeoyaFFGEBmnJ48OHh/vH/9LojBa1CkwWtwi5tGAWCeodXM7Yxo55ec8
	4BcoNDP9ngwD/nFN+TpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbyt-0000AY-8a; Thu, 10 Jan 2019 15:10:51 +0000
Received: from mail-vi1eur04on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72a]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbyg-0008Qn-KR
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:10:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fubxctBDBF6kkbNS9MWkCLsoSWq6LbrnhCguLwzDgVc=;
 b=K6Td3zqaVkb5ckYSB7372Ie/eMSWXZRUoD1iuL8eCh/dK13VUyaCs4CPzeVTv+qv4n/typexhJHW+XMCNJq4+Or1f8VDtM8b7W+laiLaj+1wo491+L628CNldKhiTRP87rPyryJvMT8SgKNR9gL8qQaqJYdWUPIhC84cL+djqLA=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:34 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:34 +0000
From: Peter Rosin <peda@axentia.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] drm/atmel-hlcdc: rotate planes counterclockwise
Thread-Topic: [PATCH 1/4] drm/atmel-hlcdc: rotate planes counterclockwise
Thread-Index: AQHUqPaiL7m+2adSdUCQzjfoCW/2Iw==
Date: Thu, 10 Jan 2019 15:10:34 +0000
Message-ID: <20190110151020.30468-2-peda@axentia.se>
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
 6:2Xh8ocU8hq74UnJQI+/u/oXxTu1L84X2SRxf1AVaUX7Qj/hp6rsmrzxjv4/QnbPkYXf/uon8HXvnr6QqfI2+CkR33PFW42PezcuW7zu/PVDE8AOVc8BHr7iBJCuaagfSxLP6k8TxwFM7KKjtuGzm6rcd7J3mQ50mTdDdV+xs7txCe8biS2BIR4ct9fK0Rn72+W5hWOsT0vmy/GRt8eCgFH9UhmH90UR6g7fP/3WywVvSTVMvrkrhY4haZXtX/RCwjG4yCo+Vq6wETFRWGiustPBG1wPdeeKFHDbDsMqwtjDCcyrnRd62uaEAPPoBNzEuJNhid/LSvqq4oNh8KP1PfhahIl2L+bxlIpLOMrjgp9jaS7yCdMjtGq2NatoDGffd0IY7EvQpwuqbpU+UiIbW5fKNuPYdRNBKNUB1vyjH7yRiLJjjheqeizy8gWeuh/VmziQYWT1chWfAfOprQr0Hhg==;
 5:7lUZ57Srx8wPHx7f9iz/nyXEtodaSuoxsKDQhpeEQI55A+wDbWaFxCN/7Fi6RSvzMw5mMWrPxUv4Vz6ll2qyXqMEUWo7tqmbK8sZuY12y/xQ9u7E+sKEeshEeJs/G6zCykB1pTFz6cUIGbWRAdH+t2pT5lD6MSru8TMmpmI7uJWQK2R5ArklrZasPigFUBWRPb5yc6226i4B4P8heWuteQ==;
 7:1yWWUaGNYTgUaMVGqR2OIC4f81xmvQXIEhgp+qObBZerGMfdsONCq1qw7inQ0h8LTdRGarfD3BhWLMPH/UOVN4h24J8JP0bzBYCMC1LirkZIs1nYVK1OMBE6KDEpeqL/LMvfC1YFLqWNWbXHSL0Yrw==
x-ms-office365-filtering-correlation-id: 14efde95-ab2a-4925-919d-08d6770dc4be
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4037; 
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB403797CE117F3881FD6AFF41BC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR02MB4037; BCL:0; PCL:0; RULEID:; SRVR:AM6PR02MB4037; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(386003)(4326008)(6506007)(446003)(25786009)(26005)(256004)(11346002)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(575784001)(6116002)(8676002)(86362001)(54906003)(74482002)(76176011)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4037;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qJ2Q/8/QthtF9E8duURiypdCxu2wV0p/Fb987Ipu4/e/oEjJUalwSgU9NdlfkAch63rK178NC/pp1bgLDzXKThhsGKBDeuE4m5f6k6UU0t0STfHSG5TmD0MigDxqSrx8jUGkotxC6KpoGiqATlkuAzRECsSFzEj7utPnxulMrbkxqIb/RhE+Z9O61h6Wf3c11xdIG4TZZmviqDACSFMZiZxVPBegiTESP+UDs2r/fFYAbzzZC4EIIxp8iPuYbC3ZCw8vShHRbbFXCcuUeKOpmcdYh3IU9zg+VUoMCHhQYHFCKUun5/jXy+cfdZZOHfVz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 14efde95-ab2a-4925-919d-08d6770dc4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:33.3554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_071038_666817_E04E60AE 
X-CRM114-Status: GOOD (  10.62  )
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

Ouch, the driver rotates planes clockwise, which is simply not correct.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 47e0992f3908..ea8fc0deb814 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -691,13 +691,14 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
 
 		switch (state->base.rotation & DRM_MODE_ROTATE_MASK) {
 		case DRM_MODE_ROTATE_90:
-			offset = ((y_offset + state->src_y + patched_src_w - 1) /
-				  ydiv) * fb->pitches[i];
-			offset += ((x_offset + state->src_x) / xdiv) *
-				  state->bpp[i];
-			state->xstride[i] = ((patched_src_w - 1) / ydiv) *
-					  fb->pitches[i];
-			state->pstride[i] = -fb->pitches[i] - state->bpp[i];
+			offset = ((y_offset + state->src_y) / ydiv) *
+				 fb->pitches[i];
+			offset += ((x_offset + state->src_x + patched_src_h - 1) /
+				   xdiv) * state->bpp[i];
+			state->xstride[i] = -(((patched_src_w - 1) / ydiv) *
+					    fb->pitches[i]) -
+					  (2 * state->bpp[i]);
+			state->pstride[i] = fb->pitches[i] - state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_180:
 			offset = ((y_offset + state->src_y + patched_src_h - 1) /
@@ -709,14 +710,13 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
 			state->pstride[i] = -2 * state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_270:
-			offset = ((y_offset + state->src_y) / ydiv) *
-				 fb->pitches[i];
-			offset += ((x_offset + state->src_x + patched_src_h - 1) /
-				   xdiv) * state->bpp[i];
-			state->xstride[i] = -(((patched_src_w - 1) / ydiv) *
-					    fb->pitches[i]) -
-					  (2 * state->bpp[i]);
-			state->pstride[i] = fb->pitches[i] - state->bpp[i];
+			offset = ((y_offset + state->src_y + patched_src_w - 1) /
+				  ydiv) * fb->pitches[i];
+			offset += ((x_offset + state->src_x) / xdiv) *
+				  state->bpp[i];
+			state->xstride[i] = ((patched_src_w - 1) / ydiv) *
+					  fb->pitches[i];
+			state->pstride[i] = -fb->pitches[i] - state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_0:
 		default:
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
