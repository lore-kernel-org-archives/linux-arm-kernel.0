Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:21:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9616217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gnEBHKS9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/Thd5B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9616217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XrIOP+vfD6xdeyadRW9E3qnHyGZ2zFKM9BA+zsnRacE=; b=gnEBHKS9ykYhku
	VYGOShqg196RMpV0wpqpVyeehm+TX3iNjBzUzR2Fs3DZfLYtRqx4cFUHklRhjPYMBgDrkM39PmRCr
	MkoWk6o+Aq60CwKWhmxrUobL6Rsls6KWaKW7D819yDnXjHV4qSF7yh2xXena4udPudpi4B5b1V+Ce
	iAnkcTFEj+Eu09aINx0MtM3jw39Q/O9K6GSCJ/T33hN9dUDgUEhVSmBoRQd6nKCoBmXvGL0VHfy1I
	U+GRxOIWSbGxEimaglB/1QdEfWisterZ/THxqPHu7qQC6Lad1AfwCrJYpOKZPS/OXWnF0MTGsscF8
	fJLZDGB/YtCebKLu2EiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgSq-0001PF-61; Wed, 19 Dec 2018 18:21:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgSY-00016E-Uh
 for linux-arm-kernel@bombadil.infradead.org; Wed, 19 Dec 2018 18:20:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g2Lt267tgAGimZL662McEFMNCdenlKcPCkqEBjn9lK8=; b=b/Thd5B0LG3u8f4XX3uLvVWjSd
 QkdwlW8g3ldSLqdwI0ANGU7nQ3W0j8jZOHXaISenRNHhlWMRnRNTTnzJSS3lzOkWvAbH4anoOMFKF
 9tGSj3rD1JSP5DJFgfi6r7VqDiIYyw5kwLSmcaL7vx90Dw5DZpjz0nduFCFZETVhL6vHaZdP9oRsQ
 1w23H0e0L9Q2ndAg5GbZ5yTmwqEvf5Gu1c015KorYWUCpECKyRkEspp8NOXCpCO2UShCD5kRRj4bw
 vdeqAnMprmvqirrDPFV1Hlnlgzrmhl4vM2xNr7TS57KZqkR+E5aoBsuhsc6ipuOSjuBZ7Uv1Qwfgm
 V+SNEKzw==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDg-0008Hv-Al
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E65BC1688;
 Wed, 19 Dec 2018 10:05:18 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6772E3F675;
 Wed, 19 Dec 2018 10:05:16 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 25/28] KVM: arm/arm64: Fix unintended stage 2 PMD mappings
Date: Wed, 19 Dec 2018 18:03:46 +0000
Message-Id: <20181219180349.242681-26-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_180520_660618_7C371716 
X-CRM114-Status: GOOD (  23.20  )
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

There are two things we need to take care of when we create block
mappings in the stage 2 page tables:

  (1) The alignment within a PMD between the host address range and the
  guest IPA range must be the same, since otherwise we end up mapping
  pages with the wrong offset.

  (2) The head and tail of a memory slot may not cover a full block
  size, and we have to take care to not map those with block
  descriptors, since we could expose memory to the guest that the host
  did not intend to expose.

So far, we have been taking care of (1), but not (2), and our commentary
describing (1) was somewhat confusing.

This commit attempts to factor out the checks of both into a common
function, and if we don't pass the check, we won't attempt any PMD
mappings for neither hugetlbfs nor THP.

Note that we used to only check the alignment for THP, not for
hugetlbfs, but as far as I can tell the check needs to be applied to
both scenarios.

Cc: Ralph Palutke <ralph.palutke@fau.de>
Cc: Lukas Braun <koomi@moshbit.net>
Reported-by: Lukas Braun <koomi@moshbit.net>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 86 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index f605514395a1..dee3dbd98712 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1595,6 +1595,63 @@ static void kvm_send_hwpoison_signal(unsigned long address,
 	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
 }
 
+static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
+					       unsigned long hva)
+{
+	gpa_t gpa_start, gpa_end;
+	hva_t uaddr_start, uaddr_end;
+	size_t size;
+
+	size = memslot->npages * PAGE_SIZE;
+
+	gpa_start = memslot->base_gfn << PAGE_SHIFT;
+	gpa_end = gpa_start + size;
+
+	uaddr_start = memslot->userspace_addr;
+	uaddr_end = uaddr_start + size;
+
+	/*
+	 * Pages belonging to memslots that don't have the same alignment
+	 * within a PMD for userspace and IPA cannot be mapped with stage-2
+	 * PMD entries, because we'll end up mapping the wrong pages.
+	 *
+	 * Consider a layout like the following:
+	 *
+	 *    memslot->userspace_addr:
+	 *    +-----+--------------------+--------------------+---+
+	 *    |abcde|fgh  Stage-1 PMD    |    Stage-1 PMD   tv|xyz|
+	 *    +-----+--------------------+--------------------+---+
+	 *
+	 *    memslot->base_gfn << PAGE_SIZE:
+	 *      +---+--------------------+--------------------+-----+
+	 *      |abc|def  Stage-2 PMD    |    Stage-2 PMD     |tvxyz|
+	 *      +---+--------------------+--------------------+-----+
+	 *
+	 * If we create those stage-2 PMDs, we'll end up with this incorrect
+	 * mapping:
+	 *   d -> f
+	 *   e -> g
+	 *   f -> h
+	 */
+	if ((gpa_start & ~S2_PMD_MASK) != (uaddr_start & ~S2_PMD_MASK))
+		return false;
+
+	/*
+	 * Next, let's make sure we're not trying to map anything not covered
+	 * by the memslot. This means we have to prohibit PMD size mappings
+	 * for the beginning and end of a non-PMD aligned and non-PMD sized
+	 * memory slot (illustrated by the head and tail parts of the
+	 * userspace view above containing pages 'abcde' and 'xyz',
+	 * respectively).
+	 *
+	 * Note that it doesn't matter if we do the check using the
+	 * userspace_addr or the base_gfn, as both are equally aligned (per
+	 * the check above) and equally sized.
+	 */
+	return (hva & S2_PMD_MASK) >= uaddr_start &&
+	       (hva & S2_PMD_MASK) + S2_PMD_SIZE <= uaddr_end;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1621,6 +1678,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+	if (!fault_supports_stage2_pmd_mappings(memslot, hva))
+		force_pte = true;
+
+	if (logging_active)
+		force_pte = true;
+
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	down_read(&current->mm->mmap_sem);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
@@ -1637,28 +1700,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 */
 	if ((vma_pagesize == PMD_SIZE ||
 	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pud(kvm))) &&
-	    !logging_active) {
+	    !force_pte) {
 		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
-	} else {
-		/*
-		 * Fallback to PTE if it's not one of the Stage 2
-		 * supported hugepage sizes or the corresponding level
-		 * doesn't exist
-		 */
-		vma_pagesize = PAGE_SIZE;
-
-		/*
-		 * Pages belonging to memslots that don't have the same
-		 * alignment for userspace and IPA cannot be mapped using
-		 * block descriptors even if the pages belong to a THP for
-		 * the process, because the stage-2 block descriptor will
-		 * cover more than a single THP and we loose atomicity for
-		 * unmapping, updates, and splits of the THP or other pages
-		 * in the stage-2 block range.
-		 */
-		if ((memslot->userspace_addr & ~PMD_MASK) !=
-		    ((memslot->base_gfn << PAGE_SHIFT) & ~PMD_MASK))
-			force_pte = true;
 	}
 	up_read(&current->mm->mmap_sem);
 
@@ -1697,7 +1740,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		 * should not be mapped with huge pages (it introduces churn
 		 * and performance degradation), so force a pte mapping.
 		 */
-		force_pte = true;
 		flags |= KVM_S2_FLAG_LOGGING_ACTIVE;
 
 		/*
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
