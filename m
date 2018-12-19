Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78011C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9E9217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dwp7On9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9E9217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y0Kua40D4u5qXVKF2FkYB4YE8V1/9TymukiP//RY3So=; b=dwp7On9jSJ007m
	igVnNUseiIwW/Uri/tH5sv8fp6LxJi33MiKLgAT8zu/aGgrL5Oswk7IjFj91EsKnGzLzIsq0NGSFD
	4KedAml8QDaug+se2xMFWZwhVNGvz3PwUF2r6mjl0zeDFWhasQYTTn0IGATn9PdOdnDi5ghxUBum5
	UQSPdfxI3d2fEG60pjUlOgRw9AJ/lqjleixI3/Qcy6KvWMDvInPRYAqclpfcarWCFpEw3kf17yEI1
	RNKeMZU5X1KNHCr8uxMaaHQ+eFxqKllLV8jUp0Kgkqpw+ubBxwHY7tEy+Hw4/FfWwaHmKYKkeGKgX
	8uDA5VJ0XZMYMyvTnAag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgGB-0001r9-Bt; Wed, 19 Dec 2018 18:07:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDF-0006Ks-5Q
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 376F6165C;
 Wed, 19 Dec 2018 10:04:51 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC53F3F675;
 Wed, 19 Dec 2018 10:04:48 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 15/28] KVM: arm64: Clarify explanation of STAGE2_PGTABLE_LEVELS
Date: Wed, 19 Dec 2018 18:03:36 +0000
Message-Id: <20181219180349.242681-16-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100454_139723_FD670EBD 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, punitagrawal@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Suzuki Poulose <suzuki.poulose@arm.com>,
 Lukas Braun <koomi@moshbit.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Christoffer Dall <christoffer.dall@arm.com>

In attempting to re-construct the logic for our stage 2 page table
layout I found the reasoning in the comment explaining how we calculate
the number of levels used for stage 2 page tables a bit backwards.

This commit attempts to clarify the comment, to make it slightly easier
to read without having the Arm ARM open on the right page.

While we're at it, fixup a typo in a comment that was recently changed.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/stage2_pgtable.h | 16 +++++++---------
 virt/kvm/arm/mmu.c                      |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index d352f6df8d2c..5412fa40825e 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -30,16 +30,14 @@
 #define pt_levels_pgdir_shift(lvls)	ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (lvls))
 
 /*
- * The hardware supports concatenation of up to 16 tables at stage2 entry level
- * and we use the feature whenever possible.
+ * The hardware supports concatenation of up to 16 tables at stage2 entry
+ * level and we use the feature whenever possible, which means we resolve 4
+ * additional bits of address at the entry level.
  *
- * Now, the minimum number of bits resolved at any level is (PAGE_SHIFT - 3).
- * On arm64, the smallest PAGE_SIZE supported is 4k, which means
- *             (PAGE_SHIFT - 3) > 4 holds for all page sizes.
- * This implies, the total number of page table levels at stage2 expected
- * by the hardware is actually the number of levels required for (IPA_SHIFT - 4)
- * in normal translations(e.g, stage1), since we cannot have another level in
- * the range (IPA_SHIFT, IPA_SHIFT - 4).
+ * This implies, the total number of page table levels required for
+ * IPA_SHIFT at stage2 expected by the hardware can be calculated using
+ * the same logic used for the (non-collapsable) stage1 page tables but for
+ * (IPA_SHIFT - 4).
  */
 #define stage2_pgtable_levels(ipa)	ARM64_HW_PGTABLE_LEVELS((ipa) - 4)
 #define kvm_stage2_levels(kvm)		VTCR_EL2_LVLS(kvm->arch.vtcr)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 2dcff38868d4..f605514395a1 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1356,7 +1356,7 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
 	struct page *page = pfn_to_page(pfn);
 
 	/*
-	 * PageTransCompoungMap() returns true for THP and
+	 * PageTransCompoundMap() returns true for THP and
 	 * hugetlbfs. Make sure the adjustment is done only for THP
 	 * pages.
 	 */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
