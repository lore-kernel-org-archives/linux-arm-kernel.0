Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D081C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:06:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BE821479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ix/ZTLQd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FHTkfCTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BE821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hmtCUlHtvK5FlT4zsP/pH4LEXz0HD9Wmyv6e8X4+cXc=; b=Ix/ZTLQdNxNY1g
	6BEJWW69dodTVu4jiO4PAHaPS49DRDmD3Btu8F+MPrVGmuEO/HeVjapVLyRfXc5qnxPkAJGwPMH24
	U0XEDj8ZxYcjaCNNchtiUE8A+0/o9ojmzd9CRROUu3YL6MgTkzlwQ8v732631sCTf0muwwGyaoyhJ
	szkkV/ZsmDYFBlqokVlVxgDZqbAIvMxx4LLIwqcpLY7lor1hLO8A47+sYeUTrC1JT4uBfO2oqVBDl
	8sQll6evqHoYtd9zCNCP5C6pqRq18wX/2OQ7QPqND/VV/bOf8nJd0YhL69fSsMz+XzJEtTiaCL993
	Xd5lLoNh03/ueRrghEGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8Jm-0006X4-0J; Thu, 03 Jan 2019 19:06:10 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8Ji-0006Wd-2x
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:06:07 +0000
Received: by mail-pf1-x441.google.com with SMTP id b85so17099153pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ewomomMsXpO5qGfU4Cug+z/PUAqOj7a9mC8x323VzVI=;
 b=FHTkfCTS5eSl7qGDWDaZMA9cBl/BCz+Yccc3LARiyr/uKROkxhn5GCIaLsjgSczfUk
 cToOUdbIDFzaH7aMr1HZOBAAeFYPMmN59pbFdTEss/CTQ6zCMEKVnZbeUJseNxpY4jQl
 4KWtjXXlyVvppCyuBb5GLTcNiabJGTPsbDNIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ewomomMsXpO5qGfU4Cug+z/PUAqOj7a9mC8x323VzVI=;
 b=bGfE/4fgPDpfkt6kQJuC5cUhKlnnnp9d1mCIiQggZw8HnFbORhdU//F/7k7u1b+D3C
 1U27aYY1Ls7HBVISqqqWIGWmMBajd95FfvsoehSfGDlRylRvx8wlF61IgsGC+wIYhLfH
 n1e2WrmqA1/LlqoRR3mlM1uLtj+Q5BthHIRmyEu7WjSqi6oiWGb7cA8RSUEDrwdjxprl
 SGwubHrybedCuLHzqqNBa3qfTMdlGcd8qxLvUDPGBmq9Chl8t+rg99f7y3zJ5y5RjDFc
 2VkdtY4IeELMcFNJWFPUlo882rX2hgK4a93F7cCfCC1C4GuQbrDcyyTV82gqO2L6wvmo
 7DWg==
X-Gm-Message-State: AJcUukdL1Ue2TKcVzfC48nEmUyOhzyIx5lX3gLra7O1jlt0PTy2qLZXl
 sz6FLGBabbv1hxB1Kg/kWdoZfw==
X-Google-Smtp-Source: ALg8bN6M/Cz7Y9fVHD++AD118PWidXjlIaJaqP1W8lbxvQougbc1V1cIVzAN+kV+bKRmztCMh21EqQ==
X-Received: by 2002:a63:9d05:: with SMTP id i5mr16702212pgd.98.1546542363794; 
 Thu, 03 Jan 2019 11:06:03 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id z127sm87830202pfb.80.2019.01.03.11.06.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 11:06:03 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Rob Clark <robdclark@gmail.com>
Subject: [PATCH] drm/msm/dpu: Convert to a chained irq chip
Date: Thu,  3 Jan 2019 11:06:02 -0800
Message-Id: <20190103190602.92612-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_110606_154676_37B38548 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jayant Shekhar <jshekhar@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Sean Paul <seanpaul@chromium.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Devices that make up DPU, i.e. graphics card, request their interrupts
from this "virtual" interrupt chip. The interrupt chip builds upon a GIC
SPI interrupt that raises high when any of the interrupts in the DPU's
irq status register are triggered. From the kernel's perspective this is
a chained irq chip, so requesting a flow handler for the GIC SPI and
then calling generic IRQ handling code from that irq handler is not
completely proper. It's better to convert this to a chained irq so that
the GIC SPI irq doesn't appear in /proc/interrupts, can't have CPU
affinity changed, and won't be accounted for with irq stats. Doing this
also silences a recursive lockdep warning because we can specify a
different lock class for the chained interrupts, silencing a warning
that is easy to see with 'threadirqs' on the kernel commandline.

 WARNING: inconsistent lock state
 4.19.10 #76 Tainted: G        W
 --------------------------------
 inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
 irq/40-dpu_mdss/203 [HC0[0]:SC0[2]:HE1:SE0] takes:
 0000000053ea9021 (&irq_desc_lock_class){?.-.}, at: handle_level_irq+0x34/0x26c
 {IN-HARDIRQ-W} state was registered at:
   lock_acquire+0x244/0x360
   _raw_spin_lock+0x64/0xa0
   handle_fasteoi_irq+0x54/0x2ec
   generic_handle_irq+0x44/0x5c
   __handle_domain_irq+0x9c/0x11c
   gic_handle_irq+0x208/0x260
   el1_irq+0xb4/0x130
   arch_cpu_idle+0x178/0x3cc
   default_idle_call+0x3c/0x54
   do_idle+0x1a8/0x3dc
   cpu_startup_entry+0x24/0x28
   rest_init+0x240/0x270
   start_kernel+0x5a8/0x6bc
 irq event stamp: 18
 hardirqs last  enabled at (17): [<ffffff9042385e80>] _raw_spin_unlock_irq+0x40/0xc0
 hardirqs last disabled at (16): [<ffffff904237a1f4>] __schedule+0x20c/0x1bbc
 softirqs last  enabled at (0): [<ffffff9040f318d0>] copy_process+0xb50/0x3964
 softirqs last disabled at (18): [<ffffff9041036364>] local_bh_disable+0x8/0x20

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&irq_desc_lock_class);
   <Interrupt>
     lock(&irq_desc_lock_class);

  *** DEADLOCK ***

 no locks held by irq/40-dpu_mdss/203.

 stack backtrace:
 CPU: 0 PID: 203 Comm: irq/40-dpu_mdss Tainted: G        W         4.19.10 #76
 Call trace:
  dump_backtrace+0x0/0x2f8
  show_stack+0x20/0x2c
  __dump_stack+0x20/0x28
  dump_stack+0xcc/0x10c
  mark_lock+0xbe0/0xe24
  __lock_acquire+0x4cc/0x2708
  lock_acquire+0x244/0x360
  _raw_spin_lock+0x64/0xa0
  handle_level_irq+0x34/0x26c
  generic_handle_irq+0x44/0x5c
  dpu_mdss_irq+0x64/0xec
  irq_forced_thread_fn+0x58/0x9c
  irq_thread+0x120/0x1dc
  kthread+0x248/0x260
  ret_from_fork+0x10/0x18
 ------------[ cut here ]------------
 irq 169 handler irq_default_primary_handler+0x0/0x18 enabled interrupts

Cc: Sean Paul <seanpaul@chromium.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Jayant Shekhar <jshekhar@codeaurora.org>
Cc: Rajesh Yadav <ryadav@codeaurora.org>
Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 36 ++++++++++++++----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index cb307a2abf06..7316b4ab1b85 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -23,11 +23,14 @@ struct dpu_mdss {
 	struct dpu_irq_controller irq_controller;
 };
 
-static irqreturn_t dpu_mdss_irq(int irq, void *arg)
+static void dpu_mdss_irq(struct irq_desc *desc)
 {
-	struct dpu_mdss *dpu_mdss = arg;
+	struct dpu_mdss *dpu_mdss = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	u32 interrupts;
 
+	chained_irq_enter(chip, desc);
+
 	interrupts = readl_relaxed(dpu_mdss->mmio + HW_INTR_STATUS);
 
 	while (interrupts) {
@@ -39,20 +42,20 @@ static irqreturn_t dpu_mdss_irq(int irq, void *arg)
 					   hwirq);
 		if (mapping == 0) {
 			DRM_ERROR("couldn't find irq mapping for %lu\n", hwirq);
-			return IRQ_NONE;
+			break;
 		}
 
 		rc = generic_handle_irq(mapping);
 		if (rc < 0) {
 			DRM_ERROR("handle irq fail: irq=%lu mapping=%u rc=%d\n",
 				  hwirq, mapping, rc);
-			return IRQ_NONE;
+			break;
 		}
 
 		interrupts &= ~(1 << hwirq);
 	}
 
-	return IRQ_HANDLED;
+	chained_irq_exit(chip, desc);
 }
 
 static void dpu_mdss_irq_mask(struct irq_data *irqd)
@@ -83,16 +86,16 @@ static struct irq_chip dpu_mdss_irq_chip = {
 	.irq_unmask = dpu_mdss_irq_unmask,
 };
 
+static struct lock_class_key dpu_mdss_lock_key, dpu_mdss_request_key;
+
 static int dpu_mdss_irqdomain_map(struct irq_domain *domain,
 		unsigned int irq, irq_hw_number_t hwirq)
 {
 	struct dpu_mdss *dpu_mdss = domain->host_data;
-	int ret;
 
+	irq_set_lockdep_class(irq, &dpu_mdss_lock_key, &dpu_mdss_request_key);
 	irq_set_chip_and_handler(irq, &dpu_mdss_irq_chip, handle_level_irq);
-	ret = irq_set_chip_data(irq, dpu_mdss);
-
-	return ret;
+	return irq_set_chip_data(irq, dpu_mdss);
 }
 
 static const struct irq_domain_ops dpu_mdss_irqdomain_ops = {
@@ -159,11 +162,13 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
+	int irq;
 
 	pm_runtime_suspend(dev->dev);
 	pm_runtime_disable(dev->dev);
 	_dpu_mdss_irq_domain_fini(dpu_mdss);
-	free_irq(platform_get_irq(pdev, 0), dpu_mdss);
+	irq = platform_get_irq(pdev, 0);
+	irq_set_chained_handler_and_data(irq, NULL, NULL);
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
 	devm_kfree(&pdev->dev, mp->clk_config);
 
@@ -187,6 +192,7 @@ int dpu_mdss_init(struct drm_device *dev)
 	struct dpu_mdss *dpu_mdss;
 	struct dss_module_power *mp;
 	int ret = 0;
+	int irq;
 
 	dpu_mdss = devm_kzalloc(dev->dev, sizeof(*dpu_mdss), GFP_KERNEL);
 	if (!dpu_mdss)
@@ -219,12 +225,12 @@ int dpu_mdss_init(struct drm_device *dev)
 	if (ret)
 		goto irq_domain_error;
 
-	ret = request_irq(platform_get_irq(pdev, 0),
-			dpu_mdss_irq, 0, "dpu_mdss_isr", dpu_mdss);
-	if (ret) {
-		DPU_ERROR("failed to init irq: %d\n", ret);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
 		goto irq_error;
-	}
+
+	irq_set_chained_handler_and_data(irq, dpu_mdss_irq,
+					 dpu_mdss);
 
 	pm_runtime_enable(dev->dev);
 
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
