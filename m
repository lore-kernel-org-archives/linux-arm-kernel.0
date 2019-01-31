Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A081FC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:18:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ED020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TReSP7Vs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RDVA4DJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ED020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GVuA0H4qlV1y/FlqpzdVYs8IXpubYfMF79MHfor9d9Y=; b=TReSP7Vs7f1l4CFDTiLrOEPxyD
	HlM0XCEgDjntXf5ZxSoN92Bh8rA7IxUuLyMbrbl42Lk0gWdeWljFaqg9AKv4VntJ2WssmtjQedlM9
	bNTyXcticiYKILCiBGSYEW31qxRXb0pQtRZlqXCapkElJblD+vT15Pp5k3NZM7566ZpXF/vNFuLrC
	ipKYyTjjog8OoBPwEKIojyJATW8nMsoCTYfqNW/Mz1JIVpUlFauLjqwj7bYKAQcbwtYq02o9lgn8o
	JwmUs8hbe/p9VQQK6cppYtB3bQoLhK/Q2RuVdqT8xKLSiLZY4+tnWFBs2axXzT0sVQJQg8/sjCb0S
	vM+5T/wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpE6n-00037V-2p; Thu, 31 Jan 2019 15:18:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpE50-0001D5-SF
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 15:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HcYxp5sUBPraDC1AbXrsM678frnEXwp5IitV7u8a0Xg=; b=RDVA4DJft9gnP59ZSNosNZ4Z3
 SFjFkAOtaW06OtK9s/NSB68u9VkIibck7C2idous/FV/q3Lmr22tv4xBgUlv6M0x7z0Wg5JYD5MRh
 1xhQOX3I42rg8odZpxjVc3kEfySh4A2SJVgcUVw9v9oJ5xngpkocuCJGKgnuY+ODswpuTd7UDA4HD
 HEzpDFBQ/w07Cly14qMoEI13MfTfygz+9GiWmzkTa1Hml/ATqGJdlZtVd+hG97DbIbAJB/TQ/Eklz
 6r3U8W2Afk14AFd9v4MN4SxUaSpHH4VZs+Z6gZVToTdALNz05u4q3+c7G7ulCdGK/MLbBEnSu3qGm
 Ehm7FwlAw==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDoy-0008F6-QZ
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:00:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D17B51684;
 Thu, 31 Jan 2019 07:00:03 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90D223F59C;
 Thu, 31 Jan 2019 07:00:01 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 20/25] irqchip/gic-v3: Handle pseudo-NMIs
Date: Thu, 31 Jan 2019 14:58:58 +0000
Message-Id: <1548946743-38979-21-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_150005_037505_C8C0DBA7 
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Jason Cooper <jason@lakedaemon.net>, Julien Thierry <julien.thierry@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Provide a higher priority to be used for pseudo-NMIs. When such an
interrupt is received, keep interrupts fully disabled at CPU level to
prevent receiving other pseudo-NMIs while handling the current one.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eb9d948..c2767fb 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -41,6 +41,8 @@
 
 #include "irq-gic-common.h"
 
+#define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
+
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 
 struct redist_region {
@@ -381,12 +383,45 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
 	return aff;
 }
 
+static void gic_deactivate_unhandled(u32 irqnr)
+{
+	if (static_branch_likely(&supports_deactivate_key)) {
+		if (irqnr < 8192)
+			gic_write_dir(irqnr);
+	} else {
+		gic_write_eoir(irqnr);
+	}
+}
+
+static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
+{
+	int err;
+
+	if (static_branch_likely(&supports_deactivate_key))
+		gic_write_eoir(irqnr);
+	/*
+	 * Leave the PSR.I bit set to prevent other NMIs to be
+	 * received while handling this one.
+	 * PSR.I will be restored when we ERET to the
+	 * interrupted context.
+	 */
+	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+	if (err)
+		gic_deactivate_unhandled(irqnr);
+}
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
 	irqnr = gic_read_iar();
 
+	if (gic_supports_nmi() &&
+	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
+		gic_handle_nmi(irqnr, regs);
+		return;
+	}
+
 	if (gic_prio_masking_enabled()) {
 		gic_pmr_mask_irqs();
 		gic_arch_enable_irqs();
@@ -403,12 +438,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		err = handle_domain_irq(gic_data.domain, irqnr, regs);
 		if (err) {
 			WARN_ONCE(true, "Unexpected interrupt received!\n");
-			if (static_branch_likely(&supports_deactivate_key)) {
-				if (irqnr < 8192)
-					gic_write_dir(irqnr);
-			} else {
-				gic_write_eoir(irqnr);
-			}
+			gic_deactivate_unhandled(irqnr);
 		}
 		return;
 	}
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
