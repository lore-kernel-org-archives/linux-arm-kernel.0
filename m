Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:17:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D20218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RtNXYpoV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GDA4RE+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D20218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=M2RTh7V79Z3l0Friww2l6UEJZpm8uWUCyqTGK4IFBe0=; b=RtNXYpoVqhV5ogKKU+NzHII4mp
	qdICEjAR1ERZkQQXp1a3oObkqErA58k9UOL1I6mi67fjtOVAKHKfNxIaWSm2w+HhoiHlbAbQaj0/t
	UrTCkBxNw9vWv7cNmFSiC1k3+YpddHDsYVyk4pwt0+Nb7WefhXo2+/jmCRzsaO8zF8W/Jd8y+q2lb
	kmObO/ci9ppdrLacIMA29qsAC2lbo/LEU/G3djok9cGaNsDbuOu5Gx9YrthZb6J3d3f4YmAK7XUNe
	dLOPauDbLvBFWYJRt5qzd4fjIh9wP1IYk/vMA5EDp9D+jhxjpHumPHiyDtH40pXxiqLDpI3CHQA3W
	EV9eCCBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpE5s-0002W6-4W; Thu, 31 Jan 2019 15:17:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpE4w-0001CY-JS
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 15:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1X5MfRqa3ZlJcm7OWern5IDqYjUJQYr1pBu4z7fZ/Iw=; b=GDA4RE+Z7fN6n1V4rkowohuln
 coqEYOPfYj9tnYg8gdkcl/csPLnziiR7OI0XgeuWlITp7qN74WfM8MinKRQRGpcXHVX81KyHWupF7
 95peRyMoz5MWzmsNz1glFM2RItdIJvZha+wz0wGccScto8DlTdg+RNnQQHgYrkFApxchbSfw3eOGZ
 ON4VYjSgui1jRCZ7Dxe3LRsFNJqSTb08BQKRTi80ZwXc4BUIrjYF1FbEXYfJxy0B59E2JOXbYEwu9
 2q66Mc/Rz0G4l17WmTOPTsYC8jbfNYwZQbLhD4Egd2jCmvfbZfYd7H1+pz6A2RwyaSkHfx7f74sYc
 fiuQk+0Ig==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDpA-0008Hb-1o
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:00:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C07169E;
 Thu, 31 Jan 2019 07:00:15 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49AE03F59C;
 Thu, 31 Jan 2019 07:00:13 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 25/25] arm64: Enable the support of pseudo-NMIs
Date: Thu, 31 Jan 2019 14:59:03 +0000
Message-Id: <1548946743-38979-26-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_150016_327109_51CB8D1A 
X-CRM114-Status: GOOD (  14.28  )
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
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a build option and a command line parameter to build and enable the
support of pseudo-NMIs.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/arm64/Kconfig                              | 14 ++++++++++++++
 arch/arm64/kernel/cpufeature.c                  | 10 +++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf..4d85fa5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1831,6 +1831,11 @@
 			to let secondary kernels in charge of setting up
 			LPIs.
 
+	irqchip.gicv3_pseudo_nmi= [ARM64]
+			Enables support for pseudo-NMIs in the kernel. This
+			requires the kernel to be built with
+			CONFIG_ARM64_PSEUDO_NMI.
+
 	irqfixup	[HW]
 			When an interrupt is not handled search all handlers
 			for it. Intended to get systems with badly broken
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d3..702198f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1328,6 +1328,20 @@ config ARM64_MODULE_PLTS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
 
+config ARM64_PSEUDO_NMI
+	bool "Support for NMI-like interrupts"
+	select CONFIG_ARM_GIC_V3
+	help
+	  Adds support for mimicking Non-Maskable Interrupts through the use of
+	  GIC interrupt priority. This support requires version 3 or later of
+	  Arm GIC.
+
+	  This high priority configuration for interrupts needs to be
+	  explicitly enabled by setting the kernel parameter
+	  "irqchip.gicv3_pseudo_nmi" to 1.
+
+	  If unsure, say N
+
 config RELOCATABLE
 	bool
 	help
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b530fb24..e24e94d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1207,10 +1207,18 @@ static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 #ifdef CONFIG_ARM64_PSEUDO_NMI
+static bool enable_pseudo_nmi;
+
+static int __init early_enable_pseudo_nmi(char *p)
+{
+	return strtobool(p, &enable_pseudo_nmi);
+}
+early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
+
 static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 				   int scope)
 {
-	return false;
+	return enable_pseudo_nmi && has_useable_gicv3_cpuif(entry, scope);
 }
 #endif
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
