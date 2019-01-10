Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234B9C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D76217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HZzk1UJK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="MgqBMrFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D76217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xAlX3pOIdxE6S1dUiib7m0/wMqQY+zAjoPVVIQILuds=; b=HZzk1UJKrfeUyr
	CZa7SDPAiiBPFS9NY7eoJpH78trowczdyd5yVNAfqbM9aVVgoyU2Ghf+8yj9LCu+KSRIs3K1t7lQ4
	WRaRdpBQn25KQ6FGqeY/YuwYS5A77LogjFKFKKCwX9+bVv3pWufp/Pd1jz7BeS/+Sy1++bwL4qMJ2
	4DZi6pb/tEoQkpHzLggwYUaHkNbKBS0NTGlRl62iy4m97JgfoRmYIVWQSlGaZP028HM2HpMkxab0C
	4wt4hNMbBYz9weNYeb9f4JS5JNO70Ta4kFD+/i9arozEFlw3sJdgDSdagkjsgmTErcRcV+is8nKbS
	IpWW0Lfq9stP83dBAM0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbzr-00018h-R9; Thu, 10 Jan 2019 15:11:51 +0000
Received: from mail-he1eur04on071d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::71d]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbz2-00006E-9O
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfejE45XFsxyeIfyxe8zRHW01ZzjfRWcAHquFt+YA9c=;
 b=MgqBMrFR4naTxUAztDmCmDdzKMWtGJnD+MudZlHOAZkc+Zytc15CF8uv8qA89FUPKZQgXry//AHF+tB5jARZu9H8o/+LXK1ocgNmJV9OEMVkBKccksR2tUPNoPy+AdGJgAAAnYxqIjuOmyd7ohQzMepQQ3266TCXymP2TmdzYAc=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:49 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:49 +0000
From: Peter Rosin <peda@axentia.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes, wait
 for next frame
Thread-Topic: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes, 
 wait for next frame
Thread-Index: AQHUqParKHXTvsIK8EaTrDTiqxp7vA==
Date: Thu, 10 Jan 2019 15:10:48 +0000
Message-ID: <20190110151020.30468-5-peda@axentia.se>
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
 6:l5rhVY1b7Vw+8qRryBKOAWCM+qSOqEKtoIViAXkUnIHinZT0ZFWR6q3OcI+/+RRdoPBJpakmte+wm3juySvuuuFb5k0xp4DMC7lOwcH56NoSQGdAJL9gK16QpGoJ6L36+YtquhRFltf9iCTH74RNLdnxALH9YwNb6kzLIBBtvie1i8pzHju3y1Erkufq3l+d1hoFtf7Nh7uOrRnkJ2RUE1wQFZVYlSdWpW0l5fFdmkT1YT7oocc4Iu5gn3hTt9mW4M12BrGiEXDwVCh9ZRwU9ss5bA5BOTjQB/ac3rFfWrQynVc0dIO9eX9fReSq2UcRf1vI1VWcWsOa0Atu5E//wGP2paKB11JvMfSwd0CTAJpEcKV/f0gGjqv+5QaKg5ga1Rt20Iuuj5w0x2Fh6LyBgoacBceWqLbzyDjOFtpsphJAL5OAuB3iuc5buaE9MHqylEQ5aR6J8xg8Z4yFOyWrZw==;
 5:SzL99niKpz8qePpr8b2aFnzNFY7nkbG+X7BOgZ2JkG+oZW+zuZLFA9yOFtIuaOfiGLMXcnHeQUYKOLlybd42GQYIu7WuVS25WuPvthtxRxhRY+sx4j/3B+2I+0DkQIq9XM63PWQ0nJaHQdoIOln2Bo0KZxz1o0TqN8Bl+ym3fVAgktck0PI6Sy9fEJHvoVAQrD+CY5l+OGHJ1C1udDfhqw==;
 7:F1y0og5CbUNdVrxCikeqjbuEU/+yytYXU/z/LdeBew+TKUbSZV89YaiGa+oN4CKVU4fDh6V3aOFywJ5cG8FQz6V5mpBwsst+9TCe7a1Wzj9ualQpyux/hqhdXao6cawYcgzZJxtcmosG/fz0ogRmTQ==
x-ms-office365-filtering-correlation-id: 529e6263-5f82-4f7b-2903-08d6770dcd8e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4037; 
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB403701D52805462BB9362B09BC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR02MB4037; BCL:0; PCL:0; RULEID:; SRVR:AM6PR02MB4037; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(14444005)(386003)(4326008)(6506007)(446003)(25786009)(26005)(256004)(11346002)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(6116002)(8676002)(86362001)(54906003)(74482002)(76176011)(52116002)(14773001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4037;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2u7gdM1Ky+CIK2saE/pt0xt2IA/NLsZKeqmXJBtdIeIwRV+FoFw0H3enSJrl8cVyyqZ1AtsZ34j08PjfWdQB24V5A97kzUmO3KeAG1M1QemRrqgcQ4n532q2D3JTKFtJfwRKxMIkn78u5QMnxPqld/EgFmFdl94xRakkmcxlvE7F5qsBfHIcn9q6Xii7nVlmwBMkhK/88zSlTrbmr34vYqo32KsoE4NILVlQFqMoCI7p/b7VIYN5j9+31uyBfRZHwI1btJ44D2TycheXa0Y27w2m/jcOnvP73UkgdDQV65YCciZxvR1NNRE3blcMk8Yh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 529e6263-5f82-4f7b-2903-08d6770dcd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:48.1386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_071101_522124_04759794 
X-CRM114-Status: GOOD (  11.52  )
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

The A2Q and UPDATE bits have no effect in the channel disable registers.
However, since they are present, assume that the intention is to disable
planes, not immediately as indicated by the RST bit, but on the next
frame shift since that is what A2Q and UPDATE means in the channel enable
registers.

Disabling the plane on the next frame shift is done with the EN bit,
so use that.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 05519e8c6586..f2f570642f84 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -728,9 +728,7 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
 
 	/* Disable the layer */
 	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
-				    ATMEL_HLCDC_LAYER_RST |
-				    ATMEL_HLCDC_LAYER_A2Q |
-				    ATMEL_HLCDC_LAYER_UPDATE);
+				    ATMEL_HLCDC_LAYER_EN);
 
 	/* Clear all pending interrupts */
 	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
