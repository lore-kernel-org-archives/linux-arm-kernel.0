Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B4C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:21:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148912084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nf5zU7yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148912084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hx4Vu+rilyW/kjKFdS+eHVTCGUNKF0EBdvU5yEbtkd0=; b=nf5zU7yblOpaY4
	w9FbCxKfO37ewPFY/JIaiNSe6eY8U1av1JCB7piYQ42LysWTzyR3bkPZ1z2eK5GvEO9PRzZdwZiOV
	VODmZE9p1AU7muUMr50kKWIMZ6iwXukCq5ezAth1kc0SZOeCIXl42xFgy8qV4oTjSx5FpLa3sgzYk
	vxVrAX62HiGg6YGQZJnNp5bJbR1Sd5AlqkUxrR+kSlOhjgew8IC8LJfy9rzU2Tcv9IhaY7QLocWwu
	PUrrUX4WkGbqTFycGp5qoAw8h/hBnj5Z1Mn8BklayVMKLYtkZQ+Jb6QHuHzNsZRdhiTD3llDroIlU
	RQ6hiMtLSFlCv6oeE0HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUq6-0001LK-Qv; Mon, 21 Jan 2019 08:21:50 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUq2-0001II-64
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:21:48 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1B6E5AD334B1C99E46CE;
 Mon, 21 Jan 2019 16:21:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Jan 2019 16:21:31 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: Yannick Fertre <yannick.fertre@st.com>, Philippe Cornu
 <philippe.cornu@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Vincent Abriou <vincent.abriou@st.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH -next] drm/stm: ltdc: remove set but not used variable 'src_h'
Date: Mon, 21 Jan 2019 08:27:21 +0000
Message-ID: <1548059241-148022-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538131180-34108-1-git-send-email-yuehaibing@huawei.com>
References: <1538131180-34108-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_002146_491297_2FDFB350 
X-CRM114-Status: UNSURE (   9.47  )
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
Cc: YueHaibing <yuehaibing@huawei.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/stm/ltdc.c: In function 'ltdc_plane_atomic_check':
drivers/gpu/drm/stm/ltdc.c:694:13: warning:
 variable 'src_y' set but not used [-Wunused-but-set-variable]
  u32 src_x, src_y, src_w, src_h;
             ^
             ^
drivers/gpu/drm/stm/ltdc.c:694:6: warning:
 variable 'src_x' set but not used [-Wunused-but-set-variable]
  u32 src_x, src_y, src_w, src_h;
      ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/stm/ltdc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661..a91e041 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -691,7 +691,7 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
 				   struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	u32 src_x, src_y, src_w, src_h;
+	u32 src_w, src_h;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -699,8 +699,6 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
 		return 0;
 
 	/* convert src_ from 16:16 format */
-	src_x = state->src_x >> 16;
-	src_y = state->src_y >> 16;
 	src_w = state->src_w >> 16;
 	src_h = state->src_h >> 16;
 






_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
