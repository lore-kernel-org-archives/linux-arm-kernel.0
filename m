Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:11:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA4B20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="npsRGTcC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N4CL8c0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA4B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Sn7aw5IKLaDRrX8e5BmyAmjG55O4WWs76+vD0Cv9Bmg=; b=npsRGTcCuTN8AnqqgNRzDKr4da
	e03G6dJx2Qf6jVo4chLe5E/mLN7kG1E43Rg7AX/cAjIZ6KTm4B0Ykf/PsEW75fxHkn9CTXCdIIw8w
	w2Z7kFJmyfpqBzXd+oPkjE+kxGYQnLyVEQnNQe8L2XQtic8vCmPEbAhXtt5AAbfk77iG4mnlT3Q3W
	h5xs2jhsBvlviMmBqeY0HHiVYUj84R0S+mJFsR6noGPkpIHyri9QsyWj+b+MKIhXu131V7gADyBNx
	2mYgSTDUcVe+Z1zdTmq3mrIpxIznVVLPn4Gn3n88gAF4SJ108G0niaFce7Fpwu8ocSdr8nvb4J4FB
	/YMTK4PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggt2N-000078-VB; Tue, 08 Jan 2019 15:11:27 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggt1o-0007ru-53
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 15:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+5UUK7YANK9oxtubve1frYu4+lRYO0+2kQNs2J0jJYQ=; b=N4CL8c0bEfPKubNL73mXWEuDQ
 XyzusKW39f0aeKMgAGwfdBLTrvrUhra6V7N4XASkFfma2Sl7K0lDYA89X5AD5biUqyu1QBY6sPUzP
 yHGckcbU88kjRw8+GebAWBfSz51knw831Sw4cLK8e4lWqiMVCxaA5Gg/onza56/WWFkBj1OXjXaLO
 tl9FS2YqMO+JE/kG7Mg+0J7hkkAKDk6zW2AwSfX7V5dJA06GVfzanajnO52Q34+D3x3dWCcS8lbIU
 w+havJuQjlRVTTNVUXpnm0DSe9u9rWiIDi2lV3wxBUiZMYQD+VbcDid3DrlbpqVVqwHAhu7v24Bog
 TxbagNevA==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3m-0000D1-GO
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8CA71650;
 Tue,  8 Jan 2019 06:08:49 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E3993F70D;
 Tue,  8 Jan 2019 06:08:47 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 22/26] irqchip/gic-v3: Allow interrupts to be set as
 pseudo-NMI
Date: Tue,  8 Jan 2019 14:07:40 +0000
Message-Id: <1546956464-48825-23-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090850_702047_F7ED9F3A 
X-CRM114-Status: GOOD (  19.30  )
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

Implement NMI callbacks for GICv3 irqchip. Install NMI safe handlers
when setting up interrupt line as NMI.

Only SPIs and PPIs are allowed to be set up as NMI.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 4df1e94..447d8ab 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 
 #include <linux/irqchip.h>
@@ -93,6 +94,9 @@ struct gic_chip_data {
  */
 static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
+/* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
+static refcount_t ppi_nmi_refs[16];
+
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
 
@@ -320,6 +324,72 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int gic_irq_nmi_setup(struct irq_data *d)
+{
+	struct irq_desc *desc = irq_to_desc(d->irq);
+
+	if (!gic_supports_nmi())
+		return -EINVAL;
+
+	if (gic_peek_irq(d, GICD_ISENABLER)) {
+		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
+		return -EINVAL;
+	}
+
+	/*
+	 * A secondary irq_chip should be in charge of LPI request,
+	 * it should not be possible to get there
+	 */
+	if (WARN_ON(gic_irq(d) >= 8192))
+		return -EINVAL;
+
+	/* desc lock should already be held */
+	if (gic_irq(d) < 32) {
+		/* Setting up PPI as NMI, only switch handler for first NMI */
+		if (!refcount_inc_not_zero(&ppi_nmi_refs[gic_irq(d) - 16])) {
+			refcount_set(&ppi_nmi_refs[gic_irq(d) - 16], 1);
+			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
+		}
+	} else {
+		desc->handle_irq = handle_fasteoi_nmi;
+	}
+
+	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_NMI_PRI);
+
+	return 0;
+}
+
+static void gic_irq_nmi_teardown(struct irq_data *d)
+{
+	struct irq_desc *desc = irq_to_desc(d->irq);
+
+	if (WARN_ON(!gic_supports_nmi()))
+		return;
+
+	if (gic_peek_irq(d, GICD_ISENABLER)) {
+		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
+		return;
+	}
+
+	/*
+	 * A secondary irq_chip should be in charge of LPI request,
+	 * it should not be possible to get there
+	 */
+	if (WARN_ON(gic_irq(d) >= 8192))
+		return;
+
+	/* desc lock should already be held */
+	if (gic_irq(d) < 32) {
+		/* Tearing down NMI, only switch handler for last NMI */
+		if (refcount_dec_and_test(&ppi_nmi_refs[gic_irq(d) - 16]))
+			desc->handle_irq = handle_percpu_devid_irq;
+	} else {
+		desc->handle_irq = handle_fasteoi_irq;
+	}
+
+	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), GICD_INT_DEF_PRI);
+}
+
 static void gic_eoi_irq(struct irq_data *d)
 {
 	gic_write_eoir(gic_irq(d));
@@ -958,6 +1028,8 @@ static inline void gic_cpu_pm_init(void) { }
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
+	.irq_nmi_setup		= gic_irq_nmi_setup,
+	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -973,6 +1045,8 @@ static inline void gic_cpu_pm_init(void) { }
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
+	.irq_nmi_setup		= gic_irq_nmi_setup,
+	.irq_nmi_teardown	= gic_irq_nmi_teardown,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1176,7 +1250,17 @@ static bool gic_enable_quirk_msm8996(void *data)
 
 static void gic_enable_nmi_support(void)
 {
+	int i;
+
+	for (i = 0; i < 16; i++)
+		refcount_set(&ppi_nmi_refs[i], 0);
+
 	static_branch_enable(&supports_pseudo_nmis);
+
+	if (static_branch_likely(&supports_deactivate_key))
+		gic_eoimode1_chip.flags |= IRQCHIP_SUPPORTS_NMI;
+	else
+		gic_chip.flags |= IRQCHIP_SUPPORTS_NMI;
 }
 
 static int __init gic_init_bases(void __iomem *dist_base,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
