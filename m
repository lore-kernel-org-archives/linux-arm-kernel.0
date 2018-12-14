Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF38C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3991821104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l+irmGnr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B6Ibf4Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ldOmiLcKs7rlvezWczbOpuWHqwWOwYyo/1WipDe5/nQ=; b=l+irmGnrRZ0QWhWqm+RWJboYjX
	HcZ7PXEUlUu60wazH9AH09mIEGzCfd5kitnGaAqgVvDv601loenwBdKR1VC6iloJQXLKo+bDQGMFY
	U0aQsWbwkv14+1AHgyyMdwelo7Hiz7Aev1d2qUfI29chiMJsGITZOCe+rYdqSQIt6n74dHq/svwnB
	0OGwfIKLWWL2C9cBbKoYqQKYJX+YrLK4z8w0M8AB+/mfzdUWz8gzSRV1UnZ/UqhlXL+v3hkDowSH/
	f7KGdC+rQs+rm7apWU5+rSN3gpGTU8P3Cju/NQvke4DEE3AMobsYunulijaKtT0JA1sYyIFO82sZF
	PutMdnhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmJc-0000F1-VB; Fri, 14 Dec 2018 12:11:36 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmIp-0007u2-Tc
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:10:51 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181214121036euoutp011d3cc9416fbdbcf5b9b2844e7d4ddcdd~wMc60B7Rl2571625716euoutp01D
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 12:10:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181214121036euoutp011d3cc9416fbdbcf5b9b2844e7d4ddcdd~wMc60B7Rl2571625716euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544789436;
 bh=a2N5VOvZWHZAlGz6ubg4AiofWLoy1epYm7MVF33mNnc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B6Ibf4XoBqa9N6kvaObeMB6tTh9CrU/1clMbQlYn9m8oCqd6lVUzs6EczhUQYiEEY
 uZFkqYWNTosHXtfACrqJYY2qu09iZkZJTtp2PkPFbJns7zuAy9tiwMXZ0dHoNM0nt4
 f1Xf4YWv7iUwUIinqob8Np4ihrjMDpDCfMYIWczg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181214121035eucas1p12bed885eb8619e309d4d09646695c2f4~wMc58FU0C0507605076eucas1p1l;
 Fri, 14 Dec 2018 12:10:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.9B.04441.ABD931C5; Fri, 14
 Dec 2018 12:10:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181214121034eucas1p14b05676ff59998f760296f9ed33ba3dc~wMc5MZ4xG1069910699eucas1p1a;
 Fri, 14 Dec 2018 12:10:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181214121034eusmtrp2b56d5ccdbe535cf6fdf8cf308a3a6398~wMc48qAux1165211652eusmtrp2g;
 Fri, 14 Dec 2018 12:10:34 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-6a-5c139dba57aa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.CC.04284.9BD931C5; Fri, 14
 Dec 2018 12:10:33 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181214121033eusmtip26d55cb18db455cf2423aa6794cd8d31d~wMc4M1_U03233032330eusmtip2v;
 Fri, 14 Dec 2018 12:10:33 +0000 (GMT)
From: Christoph Manszewski <c.manszewski@samsung.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/6] drm: color_mgmt: Split create_color_properties function
Date: Fri, 14 Dec 2018 13:10:17 +0100
Message-Id: <1544789421-5265-3-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUhUURTG585b5jk18XxKXrJ1KqXFLSouGGEQ9IKwhOiPMmomH6PkjPKe
 WwWVmpJbuSANuUaLMeU2jloTlJk0DdVIGmaKS0ySa1am4JI1zzfSf79zv+8753C4FMa8ItZQ
 MYYEjjdoYtWkEm96PesIsJZ5RQb/6N+FemocBMpz2OWo3lhLINuz+wB9nJ4kUeFAPo6G+z/g
 6KZzDEPt7XUK9D5tXIHMzi4CdVpLSWRsfy5H1W19CnTnZyOOBkdeANRX1AaQsWiEDGPY8seX
 WLMpi2SbZwYJttwewQ7k2ORsw70rrM3ao2BvWEyAnTKvP+ZxUrkviouNSeL4oP1nldF3s8fJ
 +JbglJpi7VVg888GHhSkd8P+5g4iGygphn4I4GJ6CykKDP0bwAqnShKmXEJOhWI5YZ5ZwCSh
 CsDuxUx34UoMOkuX4iS9B/b2/Vpib3oz/FNgAqIJo60E/O6ck4uCF30E9rZN4iLj9FaYlWsi
 RFbRh2BLux1I49bDz44sTGQPmoUPrPeWGkG6SwFvttSRkukgLMgbxiX2gqM2i3vXtfDv0wq5
 FEgHsOd3FyEV+QC+fJTtToRCc/eoy0W59tsGa61BIkL6AOzojJVwFeye8BTNmAsLm25h0rMK
 Xs9kpB5+cMxiIZenDk9Nu9dn4afxKiAdqATAcluGIh9suP1/ViUAJuDDJQp6HSeEGLjkQEGj
 FxINusBzcXozcH2tt4u2X0/AdIe2FdAUUK9URRcykQyhSRIu6FsBpDC1t+pEhlcko4rSXLjI
 8XFn+MRYTmgFvhSu9lFdkg2eYmidJoE7z3HxHL+syimPNVdB1UR9WvJ8WFLZ4R2Rfnzl6U3a
 3lcNq/11z8JTvviFRr3PW7Futy4e2a95D7ENjLZngH/xwBK4zfk14HuMv654aPXGeX1GcrNx
 7ugbe+5MJvntJLalcyF5p2z+5eW0y6klRPW74+myhlSZ797cE3xQSIzBM6JoVu2QN+b71J57
 E67GhWhNyHaMFzT/ANYiCP5WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7o75wrHGHRstrS4te4cq0XvuZNM
 FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
 MeP8PiaLtUfuslss/LiVxeLBy/2MFncnH2G0mDH5JZuDkMe8NdUem1Z1snls//aA1WPeyUCP
 +93HmTw2L6n3OL7rFrtH35ZVjB6fN8kFcEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZ
 GpvHWhmZKunb2aSk5mSWpRbp2yXoZSzuesNWcMCgYt3UpAbG4+pdjJwcEgImEpu+/WEGsYUE
 ljJKLF1fCBGXkZh3to8NwhaW+HOtC8jmAqr5xCjRvuI6WIJNwFTi9t1PYLaIgLLE34mrGEGK
 mAWOsUpMfL+KHSQhLOAjcfvIexYQm0VAVaKzZxUriM0r4C5x4PxJRogNchI3z3WCXcEp4CGx
 bNcSRoiL3CVezfzCOIGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAGNp27OfmHYyX
 NgYfYhTgYFTi4T0wRShGiDWxrLgy9xCjBAezkghvWKtwjBBvSmJlVWpRfnxRaU5q8SFGU6Cj
 JjJLiSbnA+M7ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDY//3
 3R2z/4ZynVm7cUoBg/gOASfPV8e5HuhnrIhNcXSQ83OsvHRsUWx15HyDaLPLzzvt3JY8ufzH
 7mz9/I5rp7pDGn7qXW//zcbJkKpiYbJmduAePY05zSx6mvt2VDa8f7In7l7QPQ+OUy7n0057
 /xT/G3v3lXqY1bKv87iSYtlutK+6Pef5HSWW4oxEQy3mouJEAM3Wb2W3AgAA
X-CMS-MailID: 20181214121034eucas1p14b05676ff59998f760296f9ed33ba3dc
X-Msg-Generator: CA
X-RootMTR: 20181214121034eucas1p14b05676ff59998f760296f9ed33ba3dc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121034eucas1p14b05676ff59998f760296f9ed33ba3dc
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181214121034eucas1p14b05676ff59998f760296f9ed33ba3dc@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_041048_392805_676FF62B 
X-CRM114-Status: GOOD (  15.50  )
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

Split drm_plane_create_color_properties into two separate functions.
This allows to create range and encoding property independently.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/drm_color_mgmt.c | 93 +++++++++++++++++++++++++++++++---------
 include/drm/drm_color_mgmt.h     |  8 ++++
 2 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index 581cc3788223..416cc9c8560b 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -396,29 +396,24 @@ const char *drm_get_color_range_name(enum drm_color_range range)
 }
 
 /**
- * drm_plane_create_color_properties - color encoding related plane properties
+ * drm_plane_create_encoding_property - color encoding related plane property
  * @plane: plane object
  * @supported_encodings: bitfield indicating supported color encodings
- * @supported_ranges: bitfileld indicating supported color ranges
  * @default_encoding: default color encoding
- * @default_range: default color range
  *
- * Create and attach plane specific COLOR_ENCODING and COLOR_RANGE
- * properties to @plane. The supported encodings and ranges should
- * be provided in supported_encodings and supported_ranges bitmasks.
- * Each bit set in the bitmask indicates that its number as enum
- * value is supported.
+ * Create and attach plane specific COLOR_ENCODING property to @plane.
+ * The supported encodings be provided in supported_encodings bitmask.
+ * Each bit set in the bitmask indicates that its number as enum value
+ * is supported.
  */
-int drm_plane_create_color_properties(struct drm_plane *plane,
-				      u32 supported_encodings,
-				      u32 supported_ranges,
-				      enum drm_color_encoding default_encoding,
-				      enum drm_color_range default_range)
+
+int drm_plane_create_encoding_property(struct drm_plane *plane,
+				       u32 supported_encodings,
+				       enum drm_color_encoding default_encoding)
 {
 	struct drm_device *dev = plane->dev;
 	struct drm_property *prop;
-	struct drm_prop_enum_list enum_list[max_t(int, DRM_COLOR_ENCODING_MAX,
-						       DRM_COLOR_RANGE_MAX)];
+	struct drm_prop_enum_list enum_list[DRM_COLOR_ENCODING_MAX];
 	int i, len;
 
 	if (WARN_ON(supported_encodings == 0 ||
@@ -426,11 +421,6 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 		    (supported_encodings & BIT(default_encoding)) == 0))
 		return -EINVAL;
 
-	if (WARN_ON(supported_ranges == 0 ||
-		    (supported_ranges & -BIT(DRM_COLOR_RANGE_MAX)) != 0 ||
-		    (supported_ranges & BIT(default_range)) == 0))
-		return -EINVAL;
-
 	len = 0;
 	for (i = 0; i < DRM_COLOR_ENCODING_MAX; i++) {
 		if ((supported_encodings & BIT(i)) == 0)
@@ -450,6 +440,36 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 	if (plane->state)
 		plane->state->color_encoding = default_encoding;
 
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_create_encoding_property);
+
+/**
+ * drm_plane_create_range_property - color range related plane property
+ * @plane: plane object
+ * @supported_ranges: bitfileld indicating supported color ranges
+ * @default_range: default color range
+ *
+ * Create and attach plane specific COLOR_RANGE property to @plane.
+ * The supported ranges should be provided in supported_ranges bitmask.
+ * Each bit set in the bitmask indicates that its number as enum value
+ * is supported.
+ */
+
+int drm_plane_create_range_property(struct drm_plane *plane,
+				    u32 supported_ranges,
+				    enum drm_color_range default_range)
+{
+	struct drm_device *dev = plane->dev;
+	struct drm_property *prop;
+	struct drm_prop_enum_list enum_list[DRM_COLOR_RANGE_MAX];
+	int i, len;
+
+	if (WARN_ON(supported_ranges == 0 ||
+		    (supported_ranges & -BIT(DRM_COLOR_RANGE_MAX)) != 0 ||
+		    (supported_ranges & BIT(default_range)) == 0))
+		return -EINVAL;
+
 	len = 0;
 	for (i = 0; i < DRM_COLOR_RANGE_MAX; i++) {
 		if ((supported_ranges & BIT(i)) == 0)
@@ -471,4 +491,37 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 
 	return 0;
 }
+EXPORT_SYMBOL(drm_plane_create_range_property);
+
+/**
+ * drm_plane_create_color_properties - color encoding related plane properties
+ * @plane: plane object
+ * @supported_encodings: bitfield indicating supported color encodings
+ * @supported_ranges: bitfileld indicating supported color ranges
+ * @default_encoding: default color encoding
+ * @default_range: default color range
+ *
+ * Create and attach plane specific COLOR_ENCODING and COLOR_RANGE
+ * properties to @plane. The supported encodings and ranges should
+ * be provided in supported_encodings and supported_ranges bitmasks.
+ * Each bit set in the bitmask indicates that its number as enum
+ * value is supported.
+ */
+
+int drm_plane_create_color_properties(struct drm_plane *plane,
+				      u32 supported_encodings,
+				      u32 supported_ranges,
+				      enum drm_color_encoding default_encoding,
+				      enum drm_color_range default_range)
+{
+	int ret;
+
+	ret = drm_plane_create_encoding_property(plane, supported_encodings,
+						 default_encoding);
+	if (ret)
+		return ret;
+
+	return drm_plane_create_range_property(plane, supported_ranges,
+					       default_range);
+}
 EXPORT_SYMBOL(drm_plane_create_color_properties);
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 52f6d5221a0d..fca8d3fabcd9 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -66,6 +66,14 @@ enum drm_color_range {
 	DRM_COLOR_FULL_RANGE = DRM_COLOR_YCBCR_FULL_RANGE,
 };
 
+int drm_plane_create_encoding_property(struct drm_plane *plane,
+				       u32 supported_encodings,
+				       enum drm_color_encoding default_encoding);
+
+int drm_plane_create_range_property(struct drm_plane *plane,
+				    u32 supported_ranges,
+				    enum drm_color_range default_range);
+
 int drm_plane_create_color_properties(struct drm_plane *plane,
 				      u32 supported_encodings,
 				      u32 supported_ranges,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
