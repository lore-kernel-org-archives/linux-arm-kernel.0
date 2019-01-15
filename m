Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:55:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFB1208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RuoDDAzL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DisHs6iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFB1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZQO14XqWFDPH2l/3Rxl7S81ocLsKsPl3y0zS6YFQIoY=; b=RuoDDAzL7ZzoFl
	zlvDr03bZRsO/cCymxw7tJnej4AI5oSkAe75tQcXh6TwE8iZCHS8vFMxjtkRRoSAE/z2DhU+TmrdP
	Yrz0sHiwMt39v7+Dtlpb1fOAvozCizkCGeyaV3WAGaF2G1dlqwZPB4H6NJIEgm0lfwzkTtMlgMb/j
	SXcEW3mKbPB218LSiI9YCBKgxdE9V/rKMyk5shrWOCkGhRQOIqu1WibX4G4diOfGhh0bswlfoGVab
	Bos2x7PpirwPSTqWaaBlvBpT1E63QKvyQuIwkjhBjJEBVRCozSv9zIJjAik9FGQlMe4JOUazn7SOZ
	ZN69w/6jIJVPdYTCHs0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXbk-00087a-Cd; Tue, 15 Jan 2019 22:54:56 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXbf-000875-Ch
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 22:54:54 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so2013309pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ulklU9I6wCPQIDgWA7fI0PRn/xTa9ghmXaq1+/wSs5E=;
 b=DisHs6iCYOD4FFg7r3xyfD2f95GY5bmZQgTeGu9cFUOZfMXNitif23JMOJ7A3u8l1v
 waFQ2S7CAd6zDRShQPD3Xjm4+1pmy+zCQSm+joqZwrY8J5TgIY0bLP5XONcjuvjiTN1E
 lnB7VYFHqSTQ7EhdE4EorYLVYLb1LAyicZPe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ulklU9I6wCPQIDgWA7fI0PRn/xTa9ghmXaq1+/wSs5E=;
 b=ET/FNnacCA9CptGfowtImpv5Y1u9egyG0cH1Us74zYpZ0ejuBgnhUQNR47D+0c+y/X
 eitsbK1qXPuz+Ty8A8DMHWlG5tynV7riIztSsZtVlFuo2Bkag5TqBdt5tALJCmgTPKH+
 cOu6n1gcp0zyP0D5miKPZMinJlmmKhT+XHmx5GR4wM+v3tTX9ZlDGtSEBU4h+AMPyytx
 kXo1nMvZAUKi8k64Anfg3KlutBdXvNB3MqXA8cHG8NDDiE2b8bQDRiitZUzY6jhQ+dbv
 gWyqgtPHAt7hr3ZJkm+9/kM/hXSnwFsJskU7M2H1nOjdYvsYmJUp4nWKoQak8s0eikPG
 CHZA==
X-Gm-Message-State: AJcUukd7ZwZ0cOvvGZ2VBBwlG5KjkkGhvAJSWcrHvUoEdUvWNSM1tXND
 fZC/eTvcv+WQXdL00RvHp8dAEKz+9/Q+qA==
X-Google-Smtp-Source: ALg8bN5ZOYvWP6QYyV7PsFnWY9MHQsClolrSG1hCM4/I924qF7jBcbE3KI2n+K/5ecUhwnVFiKsGig==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr5933257pga.191.1547592889533; 
 Tue, 15 Jan 2019 14:54:49 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id y84sm11060863pfb.81.2019.01.15.14.54.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 14:54:48 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Andy Gross <andy.gross@linaro.org>
Subject: [PATCH v2] soc: qcom: rpmh: Avoid accessing freed memory from batch
 API
Date: Tue, 15 Jan 2019 14:54:47 -0800
Message-Id: <20190115225447.75212-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_145451_463556_443CFA0A 
X-CRM114-Status: GOOD (  17.70  )
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Matthias Kaehlcke <mka@chromium.org>,
 Evan Green <evgreen@chromium.org>, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Using the batch API from the interconnect driver sometimes leads to a
KASAN error due to an access to freed memory. This is easier to trigger
with threadirqs on the kernel commandline.

 BUG: KASAN: use-after-free in rpmh_tx_done+0x114/0x12c
 Read of size 1 at addr fffffff51414ad84 by task irq/110-apps_rs/57

 CPU: 0 PID: 57 Comm: irq/110-apps_rs Tainted: G        W         4.19.10 #72
 Call trace:
  dump_backtrace+0x0/0x2f8
  show_stack+0x20/0x2c
  __dump_stack+0x20/0x28
  dump_stack+0xcc/0x10c
  print_address_description+0x74/0x240
  kasan_report+0x250/0x26c
  __asan_report_load1_noabort+0x20/0x2c
  rpmh_tx_done+0x114/0x12c
  tcs_tx_done+0x450/0x768
  irq_forced_thread_fn+0x58/0x9c
  irq_thread+0x120/0x1dc
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18

 Allocated by task 385:
  kasan_kmalloc+0xac/0x148
  __kmalloc+0x170/0x1e4
  rpmh_write_batch+0x174/0x540
  qcom_icc_set+0x8dc/0x9ac
  icc_set+0x288/0x2e8
  a6xx_gmu_stop+0x320/0x3c0
  a6xx_pm_suspend+0x108/0x124
  adreno_suspend+0x50/0x60
  pm_generic_runtime_suspend+0x60/0x78
  __rpm_callback+0x214/0x32c
  rpm_callback+0x54/0x184
  rpm_suspend+0x3f8/0xa90
  pm_runtime_work+0xb4/0x178
  process_one_work+0x544/0xbc0
  worker_thread+0x514/0x7d0
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18

 Freed by task 385:
  __kasan_slab_free+0x12c/0x1e0
  kasan_slab_free+0x10/0x1c
  kfree+0x134/0x588
  rpmh_write_batch+0x49c/0x540
  qcom_icc_set+0x8dc/0x9ac
  icc_set+0x288/0x2e8
  a6xx_gmu_stop+0x320/0x3c0
  a6xx_pm_suspend+0x108/0x124
  adreno_suspend+0x50/0x60
 cr50_spi spi5.0: SPI transfer timed out
  pm_generic_runtime_suspend+0x60/0x78
  __rpm_callback+0x214/0x32c
  rpm_callback+0x54/0x184
  rpm_suspend+0x3f8/0xa90
  pm_runtime_work+0xb4/0x178
  process_one_work+0x544/0xbc0
  worker_thread+0x514/0x7d0
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18

 The buggy address belongs to the object at fffffff51414ac80
  which belongs to the cache kmalloc-512 of size 512
 The buggy address is located 260 bytes inside of
  512-byte region [fffffff51414ac80, fffffff51414ae80)
 The buggy address belongs to the page:
 page:ffffffbfd4505200 count:1 mapcount:0 mapping:fffffff51e00c680 index:0x0 compound_mapcount: 0
 flags: 0x4000000000008100(slab|head)
 raw: 4000000000008100 ffffffbfd4529008 ffffffbfd44f9208 fffffff51e00c680
 raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  fffffff51414ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  fffffff51414ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >fffffff51414ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  fffffff51414ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  fffffff51414ae80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

The batch API sets the same completion for each rpmh message that's sent
and then loops through all the messages and waits for that single
completion declared on the stack to be completed before returning from
the function and freeing the message structures. Unfortunately, some
messages may still be in process and 'stuck' in the TCS. At some later
point, the tcs_tx_done() interrupt will run and try to process messages
that have already been freed at the end of rpmh_write_batch(). This will
in turn access the 'needs_free' member of the rpmh_request structure and
cause KASAN to complain. Furthermore, if there's a message that's
completed in rpmh_tx_done() and freed immediately after the complete()
call is made we'll be racing with potentially freed memory when
accessing the 'needs_free' member:

	CPU0                         CPU1
	----                         ----
	rpmh_tx_done()
	 complete(&compl)
	                             wait_for_completion(&compl)
	                             kfree(rpm_msg)
	 if (rpm_msg->needs_free)
	 <KASAN warning splat>

Let's fix this by allocating a chunk of completions for each message and
waiting for all of them to be completed before returning from the batch
API. Alternatively, we could wait for the last message in the batch, but
that may be a more complicated change because it looks like
tcs_tx_done() just iterates through the indices of the queue and
completes each message instead of tracking the last inserted message and
completing that first.

Cc: Lina Iyer <ilina@codeaurora.org>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Fixes: c8790cb6da58 ("drivers: qcom: rpmh: add support for batch RPMH request")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Incorporated needs_free check earlier
 * Simplified logic to no longer flush everything out on failure

 drivers/soc/qcom/rpmh.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index c7beb6841289..ab8f731a3426 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -80,6 +80,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
 						    msg);
 	struct completion *compl = rpm_msg->completion;
+	bool free = rpm_msg->needs_free;
 
 	rpm_msg->err = r;
 
@@ -94,7 +95,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	complete(compl);
 
 exit:
-	if (rpm_msg->needs_free)
+	if (free)
 		kfree(rpm_msg);
 }
 
@@ -348,11 +349,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 {
 	struct batch_cache_req *req;
 	struct rpmh_request *rpm_msgs;
-	DECLARE_COMPLETION_ONSTACK(compl);
+	struct completion *compls;
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	unsigned long time_left;
 	int count = 0;
-	int ret, i, j;
+	int ret, i;
+	void *ptr;
 
 	if (!cmd || !n)
 		return -EINVAL;
@@ -362,10 +364,15 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	if (!count)
 		return -EINVAL;
 
-	req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
+	ptr = kzalloc(sizeof(*req) +
+		      count * (sizeof(req->rpm_msgs[0]) + sizeof(*compls)),
 		      GFP_ATOMIC);
-	if (!req)
+	if (!ptr)
 		return -ENOMEM;
+
+	req = ptr;
+	compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
+
 	req->count = count;
 	rpm_msgs = req->rpm_msgs;
 
@@ -380,25 +387,26 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	}
 
 	for (i = 0; i < count; i++) {
-		rpm_msgs[i].completion = &compl;
+		struct completion *compl = &compls[i];
+
+		init_completion(compl);
+		rpm_msgs[i].completion = compl;
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
 		if (ret) {
 			pr_err("Error(%d) sending RPMH message addr=%#x\n",
 			       ret, rpm_msgs[i].msg.cmds[0].addr);
-			for (j = i; j < count; j++)
-				rpmh_tx_done(&rpm_msgs[j].msg, ret);
 			break;
 		}
 	}
 
 	time_left = RPMH_TIMEOUT_MS;
-	for (i = 0; i < count; i++) {
-		time_left = wait_for_completion_timeout(&compl, time_left);
+	while (i--) {
+		time_left = wait_for_completion_timeout(&compls[i], time_left);
 		if (!time_left) {
 			/*
 			 * Better hope they never finish because they'll signal
-			 * the completion on our stack and that's bad once
-			 * we've returned from the function.
+			 * the completion that we're going to free once
+			 * we've returned from this function.
 			 */
 			WARN_ON(1);
 			ret = -ETIMEDOUT;
@@ -407,7 +415,7 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	}
 
 exit:
-	kfree(req);
+	kfree(ptr);
 
 	return ret;
 }
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
