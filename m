Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0702BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE096206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGospOVF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uboFri0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE096206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xpSAXvQIocdJBFKXuSRCSbLG9ilhBBoJ94jzyS5BMXQ=; b=iGospOVFcS7pj5Qjn8bmzMepLl
	JpWqpy4tY5fThhy4uq+pCNPrWDpXXvvCxgu9HKu4XuTi1iB/5dOr7T8gK5zOJwNE+uayoNCC4Lfy1
	JeVptnPkPzaAhezqwxybb+M/oq+6yRnLmhoDlhOCPFUgEynfK5HlyCk2wFknC7LJvphh/sBIszBLV
	J2uNpyMshb7+42TAjqtrIVn3uRSiPuSwVMAeX2QCrwa0QwMD8cwJFN8TIzdG/tkJcCqV4nvQb+J0/
	EHAMCSfKtzP0gL5YXHVoliA9T9LjqhAHNEr7IQlYdhrN7a6vPEfxQzOLyLcEaTI6rUaoS+jDbHysL
	vGbYKEtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs67-0003Kx-RY; Tue, 08 Jan 2019 14:11:15 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3k-0007fG-OV
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 14:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H+hOS5KBiMF8RR6fk7pyhSQtB6OoPqn0Ej0GCn73ySY=; b=uboFri0zAzUNsFgGDG2cHWCO0
 2628HcXi0dlOkgvdWBFwLbuM9D2bkKfYtnjE84IKXK5MjnfvTxy1ULtkk3lg/dXS5XkWmzmfXLMpR
 HDh2ozkveC+yS8VEBHMD2ZJQTND+Lro8lqSf8Vj3aWyu6bgTgYZxKY9F2qg1xyLDsPVLB/OAF9xiE
 QkemE5WbLQHI+TSyfIEDggqQzqH7kibTX4yVEXA+ym8VHGsHMPvmpBsK8AusA0OqffLIXstqX+yCO
 g2pKvhLrMZmVJmDvs9rfXlf5ITtBV302F/kW4RkW6Ry5A218Te82tJ/Xu2O9Y31xwDwL9YXscEL/y
 74r1qAfEQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3g-0000B1-So
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F0680D;
 Tue,  8 Jan 2019 06:08:44 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 742D33F70D;
 Tue,  8 Jan 2019 06:08:42 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 20/26] irqchip/gic-v3: Handle pseudo-NMIs
Date: Tue,  8 Jan 2019 14:07:38 +0000
Message-Id: <1546956464-48825-21-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090845_038695_B055E0B1 
X-CRM114-Status: GOOD (  18.21  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5374b43..4df1e94 100644
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
 
+static inline void gic_deactivate_unexpected_irq(u32 irqnr)
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
+		gic_deactivate_unexpected_irq(irqnr);
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
+			gic_deactivate_unexpected_irq(irqnr);
 		}
 		return;
 	}
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
