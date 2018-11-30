Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE13C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:10:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321C420863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ito2y2or";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="njHRf7oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321C420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aie6QBA5KpNVqsHV7FdyRRbZ8ncHKV1WvEN5EmfhIqw=; b=Ito2y2orgPSHP0ht8f3f1leDDk
	YCMh3I+ivVZZbzdC7FUWOufAuoXm5YgPDAN+kesTsWAVDk2DV6KN6iqWpw5vWWaLxDnpVzcQ+Qo5l
	vtLfMJv/lAQ3N+fPNetZPB79W0gLEUJcrjnpIDNC9pCbgqHXYjO2qP9iXq8Dke6OAqarP0FoIbCyy
	Dzg1VND88NUfP3T6X7bIKMMbHndSTRCnQFUtzDzoQ+D0qD7sj9Rphhms6IAolbhmbjChxX/US1Ukd
	ZzUYBhNudfxqQ+v9n5CtWjyThQsc8QmFUawFy2atouI/uN/uh2OXhNJr2J/R5OHKglT1lQvs3cjd7
	RSjxf+7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gShca-0008MD-1H; Fri, 30 Nov 2018 12:10:12 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gShVM-0004rf-UM
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 12:02:49 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181130120231euoutp0138fceb5495bd897397bcab56b2b47067~r5T33P_Lt1402714027euoutp01U
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 12:02:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181130120231euoutp0138fceb5495bd897397bcab56b2b47067~r5T33P_Lt1402714027euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543579351;
 bh=Z4CGJ14WtfybGXs/Qu45gREy3sZEYMWP3/MaWou4ruw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=njHRf7oRpMJtz4/IqFqrjN+HAug4s/OP92SJxJ98G6tDzBZmMlX2UKJI3wq3lVkXR
 KK58vWdmL/jb0K7BGQ3KGuNuAFc5GzrD3yhrs+w41kohoUoeQ9YQk+XIE6ykVXC2NR
 Gfv9SXIe7yU5xlbaYarQfl4XqVtouEc2O5d9Uxfc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181130120230eucas1p198fed9cacd4f72890d4fe39361f6f68a~r5T3KXC-g1333813338eucas1p1F;
 Fri, 30 Nov 2018 12:02:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id D6.BE.04806.6D6210C5; Fri, 30
 Nov 2018 12:02:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181130120230eucas1p28cfa1960874470828230d288830f6974~r5T2Xa7Y10360203602eucas1p21;
 Fri, 30 Nov 2018 12:02:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181130120229eusmtrp2cc865aa031bc4cb1543e1956f68fe051~r5T2Hqwkq2249222492eusmtrp2n;
 Fri, 30 Nov 2018 12:02:29 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-d5-5c0126d66611
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.A1.04128.5D6210C5; Fri, 30
 Nov 2018 12:02:29 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181130120229eusmtip2d4668d4dd19400f0fc6a5e3ddac67421~r5T1f5TEP0089000890eusmtip2z;
 Fri, 30 Nov 2018 12:02:29 +0000 (GMT)
From: Christoph Manszewski <c.manszewski@samsung.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/exynos: mixer: Use colorimetry helper function
Date: Fri, 30 Nov 2018 13:02:12 +0100
Message-Id: <1543579332-16609-3-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543579332-16609-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87rX1BhjDKa8UrHoPXeSyeL47qWM
 Fle+vmezmHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLBZ+3Mpi
 8eDlfkaLu5OPMFrMmPySzYHfY96aao9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hsc33WL3aNv
 yypGj8+b5AI4o7hsUlJzMstSi/TtErgyXs45ylzwjb3iQttt5gbGh2xdjJwcEgImEu9nf2Hu
 YuTiEBJYwSix4/5dNgjnC6PEzpd3WCGcz4wSZ1sfsMK0vPmzHaplOaPE95NH2eFabt1cwQxS
 xSZgKnH77iewJSICyhJ/J65iBCliFljDItF4exvYKGEBd4mrV1aBNbAIqEp8n98PFOfg4BXw
 kOg8ag+xTU7i5rlOsBJOAU+JS9vfgG2WEDjGLvH26W6oL1wkpt68xQhhC0u8Or6FHcKWkfi/
 cz4TREMz0HVfrrFCOBMYJQ6u7mKBqLKW2HTjFRPIZmYBTYn1u/Qhwo4SnTtfsoOEJQT4JG68
 FQQJMwOZk7ZNZ4YI80p0tAlBVKtJvN6yhQ1m7YvPX6HO8ZD4ce0wNEznMEpc63vKPoFRfhbC
 sgWMjKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU9Ppf8e/7mDc9yfpEKMAB6MSD6/D
 r//RQqyJZcWVuYcYJTiYlUR4z7UxxAjxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5Y
 kpqdmlqQWgSTZeLglGpglFFaVXrik0qLb3mWUMcHp8MM13Y3rz61nGvSzZeWm450TDWYrSGa
 XbzX7JKNnlwH2yGRiSFyEpse/Z2g/5Sp5clVj/iaNUHNH561GEUI/fuz99TDfa8cffc7vp1o
 e6M2xvu9GusloU4d9sWt/97OWx++7h3v/7WuGdNypNwOvN7eE3rrz/zWZ0osxRmJhlrMRcWJ
 AOF3F5ZJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7pX1RhjDK5t07boPXeSyeL47qWM
 Fle+vmezmHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLBZ+3Mpi
 8eDlfkaLu5OPMFrMmPySzYHfY96aao9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hsc33WL3aNv
 yypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
 i/TtEvQyXs45ylzwjb3iQttt5gbGh2xdjJwcEgImEm/+bGfuYuTiEBJYyijx6cNbZoiEjMS8
 s31QRcISf651sUEUfWKUeHL9KBNIgk3AVOL23U9gRSICyhJ/J65iBCliFtjBIvHt8x4WkISw
 gLvE1SurwKayCKhKfJ/fz9rFyMHBK+Ah0XnUHmKBnMTNc51gJZwCnhKXtr8Bs4WASo4eXcEy
 gZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMA42Xbs55YdjF3vgg8xCnAwKvHwOvz6
 Hy3EmlhWXJl7iFGCg1lJhPdcG0OMEG9KYmVValF+fFFpTmrxIUZToJsmMkuJJucDYzivJN7Q
 1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAOjzsX5sZKdkklmd5MOP9Q3
 nMkyXyY7/OHES+yWD/cFmxrtePdrSszfaB7Zld7zTupXnNa5x7LlzLNin4rLlTe3O25ifbMn
 b02B7w/+30sMjrY+s7mnJ33WNObX68iLAXGan3Omv9Vz4Lqi9qNJ+8XRe1uiiwL3fPvXtN5Z
 fRPvPomS9soL+mUrlViKMxINtZiLihMB0fFxq6kCAAA=
X-CMS-MailID: 20181130120230eucas1p28cfa1960874470828230d288830f6974
X-Msg-Generator: CA
X-RootMTR: 20181130120230eucas1p28cfa1960874470828230d288830f6974
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130120230eucas1p28cfa1960874470828230d288830f6974
References: <1543579332-16609-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181130120230eucas1p28cfa1960874470828230d288830f6974@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_040245_174858_37B6E433 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use drm_default_colorimetry helper function to determine the default
colorspace type (ITU-R BT.601 or ITU-R BT.709).

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 2a25822bd6a1..895c6268025d 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -384,9 +384,10 @@ static void mixer_cfg_scan(struct mixer_context *ctx, int width, int height)
 static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, struct drm_display_mode *mode)
 {
 	enum hdmi_quantization_range range = drm_default_rgb_quant_range(mode);
+	enum hdmi_colorimetry format = drm_default_colorimetry(mode);
 	u32 val;
 
-	if (mode->vdisplay < 720) {
+	if (format == HDMI_COLORIMETRY_ITU_601) {
 		val = MXR_CFG_RGB601;
 	} else {
 		val = MXR_CFG_RGB709;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
