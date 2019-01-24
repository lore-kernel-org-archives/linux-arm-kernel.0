Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE7C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:56:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5760A21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kXrhmW9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5760A21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=65iO+CKwqdFbx8xTrXezKl+1tPzB/zVN8mxM+oHdZlQ=; b=kXrhmW9rbVa3Fe
	qwIFii6lq1i8uap+cfprrnCKTuYlGqYJmSThi7SS/OOIpCQ3NgPFEiAtDJbM05gSS8HvF24eTdRH4
	I3c7ZCX1vdm0Nz9e3Gg5Gn4QTbOLPHyzJims/3SL/0spUJebwFFcBUrR0Z/g8lYTn5hUko/Gp7Gka
	n8djupfbIel0KqT6+KtKwRTSjYPb9eshn1hAE1jBoKXs+QrokioWIjvZzWABsgjJHHLvpjtTKkK1K
	a0vl5HdgEGTNHh8Mx7lIyYZvSR+wLfQHLWu50EFbzwHd3xikUPKMPN3hhUOZsFu/cvlXWEuDeVBK1
	JnbSBFvaLpm/7/PNph5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbkN-0003wD-6e; Thu, 24 Jan 2019 09:56:31 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbkJ-0003uc-P5
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:56:29 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5639F2084E; Thu, 24 Jan 2019 10:56:26 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 01A7320798;
 Thu, 24 Jan 2019 10:56:15 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "media: cedrus: Allow using the current dst buffer as
 reference"
Date: Thu, 24 Jan 2019 10:55:42 +0100
Message-Id: <20190124095542.22321-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_015628_086631_BA1EFF4A 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit cf20ae1535eb690a87c29b9cc7af51881384e967.

The vb2_find_timestamp helper was modified to allow finding buffers
regardless of their current state in the queue. This means that we
no longer have to take particular care of references to the current
capture buffer.
---
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c   | 13 -------------
 drivers/staging/media/sunxi/cedrus/cedrus_dec.h   |  2 --
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c | 10 ++++------
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index 2c295286766c..443fb037e1cf 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -22,19 +22,6 @@
 #include "cedrus_dec.h"
 #include "cedrus_hw.h"
 
-int cedrus_reference_index_find(struct vb2_queue *queue,
-				struct vb2_buffer *vb2_buf, u64 timestamp)
-{
-	/*
-	 * Allow using the current capture buffer as reference, which can occur
-	 * for field-coded pictures.
-	 */
-	if (vb2_buf->timestamp == timestamp)
-		return vb2_buf->index;
-	else
-		return vb2_find_timestamp(queue, timestamp, 0);
-}
-
 void cedrus_device_run(void *priv)
 {
 	struct cedrus_ctx *ctx = priv;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
index 8d0fc248220f..d1ae7903677b 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
@@ -16,8 +16,6 @@
 #ifndef _CEDRUS_DEC_H_
 #define _CEDRUS_DEC_H_
 
-int cedrus_reference_index_find(struct vb2_queue *queue,
-				struct vb2_buffer *vb2_buf, u64 timestamp);
 void cedrus_device_run(void *priv);
 
 #endif
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index 81c66a8aa1ac..cb45fda9aaeb 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -10,7 +10,6 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "cedrus.h"
-#include "cedrus_dec.h"
 #include "cedrus_hw.h"
 #include "cedrus_regs.h"
 
@@ -160,8 +159,8 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
 
 	/* Forward and backward prediction reference buffers. */
-	forward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
-						  slice_params->forward_ref_ts);
+	forward_idx = vb2_find_timestamp(cap_q,
+					 slice_params->forward_ref_ts, 0);
 
 	fwd_luma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 0);
 	fwd_chroma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 1);
@@ -169,9 +168,8 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
 	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
 
-	backward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
-						   slice_params->backward_ref_ts);
-
+	backward_idx = vb2_find_timestamp(cap_q,
+					  slice_params->backward_ref_ts, 0);
 	bwd_luma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 0);
 	bwd_chroma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 1);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
