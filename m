Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6474C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:10:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698C9206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nU7mJbzk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nbUtxbn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698C9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mFJ1uUqOZLRR6dOtKcqa1FJs+eLyyK5AmG+NteDxAQs=; b=nU7mJbzk+BoewZfSUP8hwps8R2
	5ZVHX4Je07efPFoe3YUxTHZeS3icFkm/3p+Ocv8xycBBZrDQn35bMJeLyumZPs0uhABXb6qTO7O4J
	CREE/tcF0qm4SFAvFJnHQp6vs82+tdIpwkKWHtxU2N8TrsQxLwh4X73l+BGrsjitQwRZIYT6y3kcB
	AJDCtYFUdPkGlxgI/oBz0764OsmohXAiE3euHoXQDFp35vuhWX2OGRGttlU5yb6DwONPudZu84vbI
	9bQJ58tUOlNtnEKizhP+HjQpMnHVkV03AGrVQz/qu38WHeMPKop2/DCC63PAmBo2OoORZ4vkRFvw7
	xOUoH9RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs5Z-0002Wc-Kw; Tue, 08 Jan 2019 14:10:41 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3h-0007fG-LD
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 14:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0THuG1JZq7kvlgqlty8reTMUysD3YUt9PRwA1TOSMmM=; b=nbUtxbn0Oz/Sxbv+hrkof/5+s
 LBtKf2r4nZsIjcqhTOSVZk3oIdFFVbCTptv5f14FTMBQ9pbzPwmcxvQ12VEhdmtGMaz+G+6+EVfcl
 pinog290T+H3MFseVetCkQFRx+olEpAef4jJvA+TLH57+/yGvYoYpL0QvvV2JAQQ7Bpu4KunNqgp+
 jT6wrGJ0pBzemra1CY9wGWeUYu4rK66sMqKl37xg7DwhAF3J+XnBdCTu8Shv119nTspIQGWm+mI++
 5gak/j64OECL6jrlUiuo6aVOobTZtW/ryYZsDRRJvEqJXvRNqArqlLt9CVO/XLNO5pno0TiiQywh1
 isKPFdBxg==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3e-0000B8-Ae
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45CDD15AD;
 Tue,  8 Jan 2019 06:08:35 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 026593F70D;
 Tue,  8 Jan 2019 06:08:32 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 16/26] irqchip/gic-v3: Factor group0 detection into
 functions
Date: Tue,  8 Jan 2019 14:07:34 +0000
Message-Id: <1546956464-48825-17-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090842_552255_85D22BA6 
X-CRM114-Status: GOOD (  16.22  )
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

The code to detect whether Linux has access to group0 interrupts can
prove useful in other parts of the driver.

Provide a separate function to do this.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 55 +++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8148a92..da547e0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -400,6 +400,39 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	}
 }
 
+static u32 gic_get_pribits(void)
+{
+	u32 pribits;
+
+	pribits = gic_read_ctlr();
+	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
+	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	pribits++;
+
+	return pribits;
+}
+
+static bool gic_has_group0(void)
+{
+	u32 val;
+
+	/*
+	 * Let's find out if Group0 is under control of EL3 or not by
+	 * setting the highest possible, non-zero priority in PMR.
+	 *
+	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
+	 * order for the CPU interface to set bit 7, and keep the
+	 * actual priority in the non-secure range. In the process, it
+	 * looses the least significant bit and the actual priority
+	 * becomes 0x80. Reading it back returns 0, indicating that
+	 * we're don't have access to Group0.
+	 */
+	gic_write_pmr(BIT(8 - gic_get_pribits()));
+	val = gic_read_pmr();
+
+	return val != 0;
+}
+
 static void __init gic_dist_init(void)
 {
 	unsigned int i;
@@ -541,7 +574,7 @@ static void gic_cpu_sys_reg_init(void)
 	u64 mpidr = cpu_logical_map(cpu);
 	u64 need_rss = MPIDR_RS(mpidr);
 	bool group0;
-	u32 val, pribits;
+	u32 pribits;
 
 	/*
 	 * Need to check that the SRE bit has actually been set. If
@@ -553,25 +586,9 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
 
-	pribits = gic_read_ctlr();
-	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
-	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
-	pribits++;
+	pribits = gic_get_pribits();
 
-	/*
-	 * Let's find out if Group0 is under control of EL3 or not by
-	 * setting the highest possible, non-zero priority in PMR.
-	 *
-	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
-	 * order for the CPU interface to set bit 7, and keep the
-	 * actual priority in the non-secure range. In the process, it
-	 * looses the least significant bit and the actual priority
-	 * becomes 0x80. Reading it back returns 0, indicating that
-	 * we're don't have access to Group0.
-	 */
-	write_gicreg(BIT(8 - pribits), ICC_PMR_EL1);
-	val = read_gicreg(ICC_PMR_EL1);
-	group0 = val != 0;
+	group0 = gic_has_group0();
 
 	/* Set priority mask register */
 	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
