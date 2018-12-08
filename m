Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9B6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:49:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCD320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCptAg5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCD320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7tuTmiEhOpUDK4qF0PkukPAmlH7B+jN2bfdZKtZyvo8=; b=uCptAg5IirNceh
	ZIZssX9HPRdM22Nlk9om3d8Pm1e9lKqvilyrjSO6nYYax/Cx1zM59s9SPj/KaQzHVzaf9mCm3HlKE
	H1ZIk2Ua0dCO/mtB2nAhcCW/+/rHW1rPNJAlV9+fI9hDfbvRiCc/2A91C10Wtp3YNjpexvk/0nAdE
	dgkAg4alaI/fy/qvDO6IJWFv+u1J8V5urqnBjOVj/9HqpPvYn8Ccw3FfNJyI7h3BqvZ29fjSdKtXn
	R9IoDY67aWdVhvlgF76iWpdEJJFsPxv9cZse5fSXc4eHnlI7lLowV9K2SgpMko+y0gq6wX5xUQG9k
	15DaWh3bm+ES0r/KYbwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVYJ3-0007q1-FA; Sat, 08 Dec 2018 08:49:49 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYJ0-0007pb-RX; Sat, 08 Dec 2018 08:49:48 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 393D016F4D3D2;
 Sat,  8 Dec 2018 16:49:25 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 8 Dec 2018
 16:49:19 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <mchehab@kernel.org>, <gregkh@linuxfoundation.org>, <heiko@sntech.de>,
 <hverkuil-cisco@xs4all.nl>
Subject: [PATCH -next] media: rockchip/vpu: remove set but not used variables
 'luma_qtable_p, chroma_qtable_p'
Date: Sat, 8 Dec 2018 16:49:14 +0800
Message-ID: <20181208084914.28268-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_004947_053987_A49529DD 
X-CRM114-Status: UNSURE (   6.20  )
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
Cc: devel@driverdev.osuosl.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:101:10: warning:
 variable 'chroma_qtable_p' set but not used [-Wunused-but-set-variable]
drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:100:10: warning:
 variable 'luma_qtable_p' set but not used [-Wunused-but-set-variable]
drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:70:10: warning:
 variable 'chroma_qtable_p' set but not used [-Wunused-but-set-variable]
drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:69:10: warning:
 variable 'luma_qtable_p' set but not used [-Wunused-but-set-variable]

It never used since introduction in
commit 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c | 5 -----
 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
index e27c108..5282236 100644
--- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
@@ -66,13 +66,8 @@ rk3288_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
 			       unsigned char *luma_qtable,
 			       unsigned char *chroma_qtable)
 {
-	__be32 *luma_qtable_p;
-	__be32 *chroma_qtable_p;
 	u32 reg, i;
 
-	luma_qtable_p = (__be32 *)luma_qtable;
-	chroma_qtable_p = (__be32 *)chroma_qtable;
-
 	for (i = 0; i < VEPU_JPEG_QUANT_TABLE_COUNT; i++) {
 		reg = get_unaligned_be32(&luma_qtable[i]);
 		vepu_write_relaxed(vpu, reg, VEPU_REG_JPEG_LUMA_QUAT(i));
diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
index 5f75e4d..dbc86d9 100644
--- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
@@ -97,13 +97,8 @@ rk3399_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
 			       unsigned char *luma_qtable,
 			       unsigned char *chroma_qtable)
 {
-	__be32 *luma_qtable_p;
-	__be32 *chroma_qtable_p;
 	u32 reg, i;
 
-	luma_qtable_p = (__be32 *)luma_qtable;
-	chroma_qtable_p = (__be32 *)chroma_qtable;
-
 	for (i = 0; i < VEPU_JPEG_QUANT_TABLE_COUNT; i++) {
 		reg = get_unaligned_be32(&luma_qtable[i]);
 		vepu_write_relaxed(vpu, reg, VEPU_REG_JPEG_LUMA_QUAT(i));
-- 
2.7.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
