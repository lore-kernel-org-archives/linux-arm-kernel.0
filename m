Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A894BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:32:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB05206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 18:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gilhb8Fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB05206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JRpF2GLm2bk1jfIACpE/1ekG7RckOeHgZL21ajtOx/E=; b=gilhb8Fv3UBUDs
	lkSoa+uOiolrksiKHwOcGXqZVDQpJg6hDy5O8kcaV7LKsW+c+qFSAJJpb+VJInbRUFDTdnW+n3hF4
	gcHE36P4g/MCrzEhEJHnDrcoEV88CCkc0CkDo324goe1cSy9rIPsaccqG7qN+PjqcDJvcxvL3HRoo
	ZSB4goGs6N/WCxenwid2f++QlXL2l5TYjdaLVvFkyvfb9FjQDob8h++j0iq1V1V/YqmyJmsCztViC
	xeAcX/GZaOKDjLHUGbqI+TkJwl8v8LCRV8fnewvOvQvW/0Po6mWktelEmnoGSRhz4NjTA5/UXaU17
	APW1w325kF5BHN3TiLwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfqk4-0004T2-P6; Sat, 05 Jan 2019 18:32:16 +0000
Received: from kozue.soulik.info ([2001:19f0:7000:8404:5054:ff:fe75:428f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfqjs-0004E9-8u; Sat, 05 Jan 2019 18:32:11 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
 by kozue.soulik.info (Postfix) with ESMTPA id 38166101784;
 Sun,  6 Jan 2019 03:32:42 +0900 (JST)
From: Randy Li <ayaka@soulik.info>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 2/4] staging: video: rockchip: fixup for upstream
Date: Sun,  6 Jan 2019 02:31:48 +0800
Message-Id: <20190105183150.20266-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105183150.20266-1-ayaka@soulik.info>
References: <20190105183150.20266-1-ayaka@soulik.info>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_103204_997452_E0A93929 
X-CRM114-Status: GOOD (  10.00  )
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
Cc: hverkuil@xs4all.nl, nicolas.dufresne@collabora.com, heiko@sntech.de,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 paul.kocialkowski@bootlin.com, myy@miouyouyou.fr, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixing those deprecated function from vendor kernel.
Removing those features don't exist in upstream kernel.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/staging/rockchip-mpp/mpp_dev_common.c | 12 ++++++------
 drivers/staging/rockchip-mpp/mpp_dev_common.h |  2 +-
 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c |  7 +++----
 drivers/staging/rockchip-mpp/mpp_dev_vdpu1.c  |  5 ++---
 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  |  5 ++---
 drivers/staging/rockchip-mpp/mpp_dev_vepu1.c  |  5 ++---
 drivers/staging/rockchip-mpp/mpp_dev_vepu2.c  |  5 ++---
 7 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.c b/drivers/staging/rockchip-mpp/mpp_dev_common.c
index 159aa5d244ce..9a257c254d4d 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_common.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_common.c
@@ -937,18 +937,18 @@ EXPORT_SYMBOL(mpp_dev_read);
 void mpp_debug_time_record(struct mpp_task *task)
 {
 	if (unlikely(debug & DEBUG_TIMING) && task)
-		do_gettimeofday(&task->start);
+		getboottime64(&task->start);
 }
 EXPORT_SYMBOL(mpp_debug_time_record);
 
 void mpp_debug_time_diff(struct mpp_task *task)
 {
-	struct timeval end;
+	struct timespec64 end;
 
-	do_gettimeofday(&end);
-	mpp_debug(DEBUG_TIMING, "time: %ld us\n",
-		  (end.tv_sec  - task->start.tv_sec)  * 1000000 +
-		  (end.tv_usec - task->start.tv_usec));
+	getboottime64(&end);
+	mpp_debug(DEBUG_TIMING, "time: %lld ms\n",
+		  (end.tv_sec  - task->start.tv_sec)  * 1000 +
+		  (end.tv_nsec - task->start.tv_nsec) / 1000000);
 }
 EXPORT_SYMBOL(mpp_debug_time_diff);
 
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.h b/drivers/staging/rockchip-mpp/mpp_dev_common.h
index 8a7dc7444dc3..76d53ec2c452 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_common.h
+++ b/drivers/staging/rockchip-mpp/mpp_dev_common.h
@@ -124,7 +124,7 @@ struct mpp_task {
 	struct work_struct work;
 
 	/* record context running start time */
-	struct timeval start;
+	struct timespec64 start;
 };
 
 /*
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
index a3da27cfc10e..44d76eba901f 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
@@ -19,10 +19,10 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/of_platform.h>
-#include <linux/rockchip/rockchip_sip.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <soc/rockchip/pm_domains.h>
+#include <soc/rockchip/rockchip_sip.h>
 
 #include "mpp_debug.h"
 #include "mpp_dev_common.h"
@@ -230,8 +230,7 @@ static int fill_scaling_list_pps(struct rkvdec_task *task, int fd, int offset,
 		return -ENOENT;
 	}
 
-	ret = dma_buf_begin_cpu_access(dmabuf, 0, dmabuf->size,
-				       DMA_FROM_DEVICE);
+	ret = dma_buf_begin_cpu_access(dmabuf, DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(dev, "can't access the pps buffer\n");
 		goto done;
@@ -277,7 +276,7 @@ static int fill_scaling_list_pps(struct rkvdec_task *task, int fd, int offset,
 
 done:
 	dma_buf_vunmap(dmabuf, vaddr);
-	dma_buf_end_cpu_access(dmabuf, 0, dmabuf->size, DMA_FROM_DEVICE);
+	dma_buf_end_cpu_access(dmabuf, DMA_FROM_DEVICE);
 	dma_buf_put(dmabuf);
 
 	return ret;
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_vdpu1.c b/drivers/staging/rockchip-mpp/mpp_dev_vdpu1.c
index 4371a1a6080b..63ffd79bfe83 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_vdpu1.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_vdpu1.c
@@ -460,9 +460,8 @@ static int rockchip_mpp_rkvdpu_assign_reset(struct rockchip_rkvdpu_dev *dec_dev)
 {
 	struct rockchip_mpp_dev *mpp_dev = &dec_dev->mpp_dev;
 
-	/* TODO: use devm_reset_control_get_share() instead */
-	dec_dev->rst_a = devm_reset_control_get(mpp_dev->dev, "video_a");
-	dec_dev->rst_h = devm_reset_control_get(mpp_dev->dev, "video_h");
+	dec_dev->rst_a = devm_reset_control_get_shared(mpp_dev->dev, "video_a");
+	dec_dev->rst_h = devm_reset_control_get_shared(mpp_dev->dev, "video_h");
 
 	if (IS_ERR_OR_NULL(dec_dev->rst_a)) {
 		mpp_err("No aclk reset resource define\n");
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
index b131790f72a3..5789c8940543 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
@@ -428,9 +428,8 @@ static int rockchip_mpp_rkvdpu_assign_reset(struct rockchip_rkvdpu_dev *dec_dev)
 {
 	struct rockchip_mpp_dev *mpp_dev = &dec_dev->mpp_dev;
 
-	/* TODO: use devm_reset_control_get_share() instead */
-	dec_dev->rst_a = devm_reset_control_get(mpp_dev->dev, "video_a");
-	dec_dev->rst_h = devm_reset_control_get(mpp_dev->dev, "video_h");
+	dec_dev->rst_a = devm_reset_control_get_shared(mpp_dev->dev, "video_a");
+	dec_dev->rst_h = devm_reset_control_get_shared(mpp_dev->dev, "video_h");
 
 	if (IS_ERR_OR_NULL(dec_dev->rst_a)) {
 		mpp_err("No aclk reset resource define\n");
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_vepu1.c b/drivers/staging/rockchip-mpp/mpp_dev_vepu1.c
index 64619092c792..ebe8174e931e 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_vepu1.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_vepu1.c
@@ -330,9 +330,8 @@ static int rockchip_mpp_rkvepu_assign_reset(struct rockchip_rkvepu_dev *enc_dev)
 {
 	struct rockchip_mpp_dev *mpp_dev = &enc_dev->mpp_dev;
 
-	/* TODO: use devm_reset_control_get_share() instead */
-	enc_dev->rst_a = devm_reset_control_get(mpp_dev->dev, "video_a");
-	enc_dev->rst_h = devm_reset_control_get(mpp_dev->dev, "video_h");
+	enc_dev->rst_a = devm_reset_control_get_shared(mpp_dev->dev, "video_a");
+	enc_dev->rst_h = devm_reset_control_get_shared(mpp_dev->dev, "video_h");
 
 	if (IS_ERR_OR_NULL(enc_dev->rst_a)) {
 		mpp_err("No aclk reset resource define\n");
diff --git a/drivers/staging/rockchip-mpp/mpp_dev_vepu2.c b/drivers/staging/rockchip-mpp/mpp_dev_vepu2.c
index 48ec401145d5..889aaccf25c5 100644
--- a/drivers/staging/rockchip-mpp/mpp_dev_vepu2.c
+++ b/drivers/staging/rockchip-mpp/mpp_dev_vepu2.c
@@ -327,9 +327,8 @@ static int rockchip_mpp_rkvepu_assign_reset(struct rockchip_rkvepu_dev *enc_dev)
 {
 	struct rockchip_mpp_dev *mpp_dev = &enc_dev->mpp_dev;
 
-	/* TODO: use devm_reset_control_get_share() instead */
-	enc_dev->rst_a = devm_reset_control_get(mpp_dev->dev, "video_a");
-	enc_dev->rst_h = devm_reset_control_get(mpp_dev->dev, "video_h");
+	enc_dev->rst_a = devm_reset_control_get_shared(mpp_dev->dev, "video_a");
+	enc_dev->rst_h = devm_reset_control_get_shared(mpp_dev->dev, "video_h");
 
 	if (IS_ERR_OR_NULL(enc_dev->rst_a)) {
 		mpp_err("No aclk reset resource define\n");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
