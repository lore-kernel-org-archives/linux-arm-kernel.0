Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E0FC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8322151B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aatJnENL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hpVlZ6W3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8322151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ADosmptIx7AHQAxTbyWFMoEGPs9/ExN98CDhRSaR4vc=; b=aatJnENLOZhHovXgleSFDvs2sT
	SWkiR1GMkaIq/Uf3/QZENFs717+7g1onL5gqxXPnItgp62aO8sCRheR2tlhFxL8qytKLejFlunhG9
	cOyJl66eXecdynWkq5MSEs5QUDKITn5E27+2qjVqz3Rb5tf6d3sX6zOCnoYGjHPJD/PgKLfZe10Ev
	IMOvQGenhTJcUHdkkCra2Wvj8Wsvkac8iGB5WLvgB5LRJSuw/lJ2Ab2pAqH0dWPTItoRniy8+7/tl
	MxJ6TMnEU2WiSKxYDlbneDw3AAEw2UhLbLD/l+NFeZ1koAmGooCXHoU2qYFdwJQm2b/I6DhMAw0RK
	XhkPndLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmKK-0000zp-E9; Fri, 14 Dec 2018 12:12:20 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmIr-0007ud-8u
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:10:52 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181214121039euoutp02ba0045cc5efcf98202cdf1c80aa7abe5~wMc_CxEOh0861108611euoutp02j
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 12:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181214121039euoutp02ba0045cc5efcf98202cdf1c80aa7abe5~wMc_CxEOh0861108611euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544789439;
 bh=6ARc7iWdZfumely2HxB8s/ziJnPFxA3nmaIxyF0uLk0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hpVlZ6W3xIvWn8mrOcxCEypcM2VvOXjmDn/ObyIQ/ycye3Ujf0feIsHIw/5jco7CY
 q+x+kD/ZTFeUsAHjxjPaTITHk/BPzF/XyG5MHX9P/hGSQ3Y9grmHB1arQ9gmPrbWRO
 fnk4D5LRbLdPPKiJ+46I1/ORJwaXCHiFaicXdkI0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181214121038eucas1p1d7dac6bc6d989211d7f26458f232a64d~wMc9M6dk70507605076eucas1p1p;
 Fri, 14 Dec 2018 12:10:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.9B.04441.EBD931C5; Fri, 14
 Dec 2018 12:10:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181214121037eucas1p2469a23e8e393bdca487a11260b187510~wMc8WEb0k1559015590eucas1p2g;
 Fri, 14 Dec 2018 12:10:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181214121037eusmtrp16e00c00b128e5a7ae4e1df3913b6c1ec~wMc8EJf4I2638626386eusmtrp1c;
 Fri, 14 Dec 2018 12:10:37 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-74-5c139dbecf49
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.91.04128.DBD931C5; Fri, 14
 Dec 2018 12:10:37 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181214121036eusmtip248e6713acb29150c20131270465aac16~wMc7WlgIc3233032330eusmtip2x;
 Fri, 14 Dec 2018 12:10:36 +0000 (GMT)
From: Christoph Manszewski <c.manszewski@samsung.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] drm/exynos: plane: Add range property to exynos plane
Date: Fri, 14 Dec 2018 13:10:20 +0100
Message-Id: <1544789421-5265-6-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3YuOxsuj5vkh4bBouyipqTwQRFFSgcjqD+SKMNmnpzozHam
 5aUSw2yWaRuRXbRCLZmmOZfFJDO1pnkrs6WrqWCB1/I2oejmdpT++73P+7w87/vxUZj0FeFN
 xSdpWHWSIlFOivH61z96AhqLZVFBg39lyFbdTaD87nYBqi2qIZCloRygPsd3EumGCnE0OvgO
 RwUjExjq6XksRF3Zk0JkHLES6L35DomKehoF6FGrXYjuzzzB0fDYC4Ds+laAivRj5E4pU1KV
 wRgNWpJ5ujBMMCXtB5ihyxYBU1d2nrGYbULmqskAmDmj737RYfH2WDYxPpVVb9lxTKzsyikn
 k6vczkw3m/EsUC/OAyIK0iHwUrYVzwNiSkpXAPgrd4Lgi3kAB0r1JF/MAZj1YgFbHtFa8gV8
 4yGAtRNd/0e0vTdJp4ukQ+En+6yLPem18Pc1A3CaMNpMwG8jPwXOhoyOgNX2v8DJOL0ODna+
 xJ0soffAaWMO4ON84UC31hUtohn4wFy2pFuF8JZjA89hsK/utpBnGRy3mJZ4NezQX3FdB+kL
 ANrmrQRfFAL4sjIP513boLF/fHEjanG9jbDGvIWXd8HPudMuGdIrYf+Uh1PGFlFXfwPjZQm8
 dFHKu9fDCZOJXI4dnXMsrclAc7tNyD/QbQC/1tqIQrDm1v+wewAYgBebwqniWC44iT0dyClU
 XEpSXODxkyojWPxcHX8ss8+AozemGdAUkLtJlDpplJRQpHJpqmYAKUzuKYnMkUVJJbGKtHRW
 fTJanZLIcs3Ah8LlXpKMFcNHpHScQsMmsGwyq17uCiiRdxbQhUVPnUtv6Wy7bi17W2GvDPJf
 2RqU6NMU/tgRG67UWnJDT2mysi+ciNyd8PvsbDrTibtrWjra7sobvhQf9belN0U0xU+alAXK
 EU+fuY37D4a5P9/L+QWo8reGlHtkRoR8bBvOjhktQW9EvqUVboc+zKhRuxzT7du8qu2XX6ay
 Wo5zSkXwJkzNKf4BozHju1gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7p75wrHGGw4IWJxa905VovecyeZ
 LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
 Ysb5fUwWa4/cZbdY+HEri8WDl/sZLe5OPsJoMWPySzYHIY95a6o9Nq3qZPPY/u0Bq8e8k4Ee
 97uPM3lsXlLvcXzXLXaPvi2rGD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
 NDaPtTIyVdK3s0lJzcksSy3St0vQyzjbupStYA1PxYdDu1gaGLdxdTFyckgImEh0Hu9lArGF
 BJYySnw4ywgRl5GYd7aPDcIWlvhzrYsNouYTo0Tzd3YQm03AVOL23U9gcREBZYm/E1cB9XJx
 MAscY5WY+H4VWJGwgJfEurv/wYayCKhK3DtzkAXE5hVwl/iwqRVqmZzEzXOdzCA2p4CHxLJd
 SxghlrlLvJr5hXECI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgTG07djPLTsYu94F
 H2IU4GBU4uE9MEUoRog1say4MvcQowQHs5IIb1ircIwQb0piZVVqUX58UWlOavEhRlOgoyYy
 S4km5wPjO68k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA+M8/YpV
 OoHX5aztqv2OMux5sl20t/jetbScY9sK3t/8s+68xtFPzxeyv7/3sNf5T0aT9t+VK9vvr/fK
 7tzH//mOsKbVW4XCTT0Zns4ZjzbfSl/E9I2v4lX1vtzTVXe9jTrKuLev/RtkK+2yyShiRm3K
 dNN9k72v7g3hfFP59ey1y+8fLerduIlBiaU4I9FQi7moOBEAzvQinrcCAAA=
X-CMS-MailID: 20181214121037eucas1p2469a23e8e393bdca487a11260b187510
X-Msg-Generator: CA
X-RootMTR: 20181214121037eucas1p2469a23e8e393bdca487a11260b187510
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121037eucas1p2469a23e8e393bdca487a11260b187510
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181214121037eucas1p2469a23e8e393bdca487a11260b187510@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_041049_441519_4994D443 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 David Airlie <airlied@linux.ie>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Create range property within exynos_drm_plane_init and set to default value
in exynos_drm_plane_reset.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index cf352d980eee..a6ab0e7277f0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -140,6 +140,7 @@ static void exynos_drm_plane_reset(struct drm_plane *plane)
 	if (exynos_state) {
 		__drm_atomic_helper_plane_reset(plane, &exynos_state->base);
 		plane->state->zpos = exynos_plane->config->zpos;
+		plane->state->color_range = exynos_plane->config->range;
 	}
 }
 
@@ -301,6 +302,10 @@ int exynos_plane_init(struct drm_device *dev,
 	unsigned int supported_modes = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 				       BIT(DRM_MODE_BLEND_PREMULTI) |
 				       BIT(DRM_MODE_BLEND_COVERAGE);
+
+	u32 supported_ranges = BIT(DRM_COLOR_LIMITED_RANGE) |
+			       BIT(DRM_COLOR_FULL_RANGE);
+
 	struct drm_plane *plane = &exynos_plane->base;
 
 	err = drm_universal_plane_init(dev, plane,
@@ -328,5 +333,9 @@ int exynos_plane_init(struct drm_device *dev,
 	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_WIN_BLEND)
 		drm_plane_create_alpha_property(plane);
 
+	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_RANGE)
+		drm_plane_create_range_property(plane, supported_ranges,
+						config->range);
+
 	return 0;
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
