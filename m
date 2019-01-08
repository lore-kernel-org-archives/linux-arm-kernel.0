Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:24:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B02820827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mg+YNB9y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nxQf3pkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B02820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=X6xWvzNp5WfgcMGhv91fOvvqQ5lv2qagYT+rKbXAA3o=; b=mg+YNB9y6uO4r0rReMabZrFpUA
	wHfM+jUskGVG0UIrVWa02MP6P1au8kwdQuG1HBmWfDwar+Fz/oRZiE3ST4LmNkFJ+2vd68s4H1IYm
	FrvRJiOCCKruQ5tQ2w6gtkUliiYzk/smq9V88d7me0smSqCuGdRdZPB2o6WgdYcH4nFm1/1e6a0NB
	bpgG72IsXFs2IvmWRUB21/FdnAbf+bQQFC/Jt9kxImQAUznSZVtIk9JpxwpsvxcObvJgKZJje2Zeq
	BJPa9Q9k4bQo+aENpgLrsg3D3Sny5QkFuXQHvW6swd/hO8SuMgr2ICPa/iVZliPFtU4mJOET1UdDt
	LiPWFc1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggsIy-00026Z-Pc; Tue, 08 Jan 2019 14:24:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggsIh-0001UO-4Z
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 14:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ujAaZBBSWGsHZR1hIzlyw+ls1nuns/eGRC9xbXpn7OE=; b=nxQf3pkqbKBy/lehLqAy8bGw9
 OBHwjz3qNfX7XhiNlYkw/KtPwxkHKb3NKKiW82cLIMG1wqyXUNXuD9Aiq8WT4cY0XjVqhgBdd967u
 9Na8dtufrRQjU3jDx1fFcsS6f0SV3kW5/moB3IkKSG2EGhSBeHoTvwdRsRo/6Wvx3Jf53NLefLPRI
 icyOSwyox9k2kvT7fLRqwqzYO7ZIBojgP4PeaX04LP7x0vOxV8E66tWVApiCMUeLnJ6Admd4F6iao
 +l8xDTbDJ7mZT2r27kMzIRYVP+8doR8fRO7a3YqJFrcfMEdFoLvQjP22ZNLVQarXsm7wCfcfJaYJm
 N+SKrOdTg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3w-00061o-8a
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:09:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C948680D;
 Tue,  8 Jan 2019 06:08:58 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCAF93F70D;
 Tue,  8 Jan 2019 06:08:56 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 26/26] arm64: Enable the support of pseudo-NMIs
Date: Tue,  8 Jan 2019 14:07:44 +0000
Message-Id: <1546956464-48825-27-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_140900_558726_0FB2D8EC 
X-CRM114-Status: GOOD (  14.44  )
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
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 arch/arm64/Kconfig                              | 14 ++++++++++++++
 arch/arm64/kernel/cpufeature.c                  | 11 ++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf..173e2cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1197,6 +1197,12 @@
 			to discrete, to make X server driver able to add WB
 			entry later. This parameter enables that.
 
+	enable_pseudo_nmi [ARM64]
+			Enables support for pseudo-NMIs in the kernel. This
+			requires both the kernel to be built with
+			CONFIG_ARM64_PSEUDO_NMI and to be running on a
+			platform with GICv3.
+
 	enable_timer_pin_1 [X86]
 			Enable PIN 1 of APIC timer
 			Can be useful to work around chipset bugs
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d3..8d84bfd 100644
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
+	  This high priority configuration for interrupts need to be
+	  explicitly enabled through the new kernel parameter
+	  "enable_pseudo_nmi".
+
+	  If unsure, say N
+
 config RELOCATABLE
 	bool
 	help
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 71c8d4f..9df1217 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1202,10 +1202,19 @@ static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 #ifdef CONFIG_ARM64_PSEUDO_NMI
+static bool enable_pseudo_nmi;
+
+static int __init early_enable_pseudo_nmi(char *p)
+{
+	enable_pseudo_nmi = true;
+	return 0;
+}
+early_param("enable_pseudo_nmi", early_enable_pseudo_nmi);
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
