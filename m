Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DCCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:55:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FAC020892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M2o1UjzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAC020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TiyhLFW/vAPAwwgiiU+UFsSFGCm/i3TL7VVPdl5qC3A=; b=M2o1UjzXEC0TmY
	9jTVN+LzZ+f9pQnk6HyCXvA20GGy14EVNsDzlL82DArTGrOrJDgkO0zGmYiThMDg/F/43ERH4cIbd
	VH7so1CebOMcIGFv/l+BqeJVKyJbggJ5aTNk+HFbhKZiMxQn1IhvILJvsGg+bCwormBFKdCCr73a1
	aUfKlF4k4gUk3vQ1FPXPy4t+A8V9wwGXv4864IKbt45rVFdQWtV1+vatZkLVuEQQX1uRClBD4NBbo
	yKQu61ROkwxcZsxWoucFJHCRENrVFZJ+wKFBuiZAzfT2HJpaPP7E8B1dZ/38U/p8vYYeKDG7BSNqt
	eg8RKnPkZ9eemoIb4nQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUh0S-00032w-Qb; Wed, 05 Dec 2018 23:55:04 +0000
Received: from 201.86.173.17.dynamic.adsl.gvt.net.br ([201.86.173.17]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUh0P-0002jZ-41; Wed, 05 Dec 2018 23:55:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.91)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1gUh0L-0002JL-KH; Wed, 05 Dec 2018 18:54:57 -0500
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: 
Subject: [PATCH] media: rockchip vpu: remove some unused vars
Date: Wed,  5 Dec 2018 18:54:54 -0500
Message-Id: <be7a207dc092e2d1b80cfdd2e5971e4641cb30c9.1544054086.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As complained by gcc:

	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c: In function 'rk3288_vpu_jpeg_enc_set_qtable':
	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:70:10: warning: variable 'chroma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *chroma_qtable_p;
	          ^~~~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c:69:10: warning: variable 'luma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *luma_qtable_p;
	          ^~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c: In function 'rk3399_vpu_jpeg_enc_set_qtable':
	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:101:10: warning: variable 'chroma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *chroma_qtable_p;
	          ^~~~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c:100:10: warning: variable 'luma_qtable_p' set but not used [-Wunused-but-set-variable]
	  __be32 *luma_qtable_p;
	          ^~~~~~~~~~~~~
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c: In function 'rockchip_vpu_queue_setup':
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c:522:33: warning: variable 'vpu_fmt' set but not used [-Wunused-but-set-variable]
	  const struct rockchip_vpu_fmt *vpu_fmt;
	                                 ^~~~~~~
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c: In function 'rockchip_vpu_buf_prepare':
	drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c:560:33: warning: variable 'vpu_fmt' set but not used [-Wunused-but-set-variable]
	  const struct rockchip_vpu_fmt *vpu_fmt;
	                                 ^~~~~~~

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
index e27c10855de5..5282236d1bb1 100644
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
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
