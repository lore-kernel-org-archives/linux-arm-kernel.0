Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39D020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IulYSTl9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nbHIUOV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39D020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=JNKkBcs7RJMaGk4/yqBxfVPH/HjYPKI2zcvNNDvDsT8=; b=Iul
	YSTl9abW92PhynsT/AtMXFfyYyo7WqyJeM1WCXkyf4nJwL8tnGkCJtpGfDZH4AbgWpaYAdnq3MUpj
	iT40vrKF40O2QE21YBPYmPFBoJQA6B2tFF/zDZZy6JLCXrnWYO2LLTXUXjqK/QZQXxWsz1dkR4pMz
	w1DYIbsqh9AspwsPJqiwHWfoWZ7jBS3GJAbbbwY+oTv2N4PfQMo/kqvEXWdTd/pk04MyN+93BsAGg
	ZTO8WWdENr9tvNbgHiCznKcv6sjjlSexxP7LQbmsxLPN6kTFBdpGhpYfOQtS29fF4rmmx+dsZE+0X
	M4SqiCscnFx7XiApzRoA7MQfjD8wvBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhwN-0004xv-Io; Mon, 04 Feb 2019 17:21:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhkr-0003OJ-NY
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 17:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IBq4f+EU57KQKEZCfnjcyljvyISxXphHzcyrCjrqINM=; b=nbHIUOV/iDUUgpL9Tn1m45AwC
 S1g+y8P+NOdPlsQJBID5QfRmQyef3QKXhbQe20cAhEBKzCGdUHZlSnDwUfEFnJecpaEZTh58k/xZI
 B4DzjpovDZ5uqkjjl8RAUP0d/x0fkVZa5wHKl9PZ9raDelgIy1Uzn2Fw9nXp5SOe0tfJMn+mKqAvN
 /oKNVamGY3mpaZSS+cXrgMeIRz5InN7MPnPn1MZcJ6Gkt0ZDeUtSg9PstOu6GAsCUXaNJLWVgTqdN
 3ncOaTWiNMZUbTvQzSJTOQ6tJx6x3XoYr9s2zkRUqGyX0kD2wbOoJazRYKf0/Csx/BZ+lVmbrSceJ
 4Eg722PtA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhWI-0005Gc-B1
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:54:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3046015AD;
 Mon,  4 Feb 2019 08:54:53 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 441CC3F589;
 Mon,  4 Feb 2019 08:54:52 -0800 (PST)
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: ptdump: Don't iterate kernel page tables using
 PTRS_PER_PXX
Date: Mon,  4 Feb 2019 16:54:46 +0000
Message-Id: <20190204165446.23662-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_165454_676029_9C0081FC 
X-CRM114-Status: GOOD (  10.67  )
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
Cc: Will Deacon <will.deacon@arm.com>, cai@lca.pw, steve.capper@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When 52-bit virtual addressing is enabled for userspace
(CONFIG_ARM64_USER_VA_BITS_52=y), the kernel continues to utilise 48-bit
virtual addressing in TTBR1. Consequently, PTRS_PER_PGD reflects the
larger page table size for userspace and the pgd pointer for kernel page
tables is offset before being written to TTBR1.

This means that we can't use PTRS_PER_PGD to iterate over kernel page
tables unless we apply the same offset, which is fiddly to get right and
leads to some non-idiomatic walking code. Instead, just follow the usual
pattern when walking page tables by using a while loop driven by
pXd_offset() and pXd_addr_end().

Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
Acked-by: Steve Capper <steve.capper@arm.com>
Tested-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/dump.c | 59 ++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index fcb1f2a6d7c6..99bb8facb5cb 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -286,74 +286,73 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 
 }
 
-static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start)
+static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start,
+		     unsigned long end)
 {
-	pte_t *ptep = pte_offset_kernel(pmdp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long addr = start;
+	pte_t *ptep = pte_offset_kernel(pmdp, start);
 
-	for (i = 0; i < PTRS_PER_PTE; i++, ptep++) {
-		addr = start + i * PAGE_SIZE;
+	do {
 		note_page(st, addr, 4, READ_ONCE(pte_val(*ptep)));
-	}
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
 }
 
-static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start)
+static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start,
+		     unsigned long end)
 {
-	pmd_t *pmdp = pmd_offset(pudp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long next, addr = start;
+	pmd_t *pmdp = pmd_offset(pudp, start);
 
-	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
+	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
+		next = pmd_addr_end(addr, end);
 
-		addr = start + i * PMD_SIZE;
 		if (pmd_none(pmd) || pmd_sect(pmd)) {
 			note_page(st, addr, 3, pmd_val(pmd));
 		} else {
 			BUG_ON(pmd_bad(pmd));
-			walk_pte(st, pmdp, addr);
+			walk_pte(st, pmdp, addr, next);
 		}
-	}
+	} while (pmdp++, addr = next, addr != end);
 }
 
-static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start)
+static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start,
+		     unsigned long end)
 {
-	pud_t *pudp = pud_offset(pgdp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long next, addr = start;
+	pud_t *pudp = pud_offset(pgdp, start);
 
-	for (i = 0; i < PTRS_PER_PUD; i++, pudp++) {
+	do {
 		pud_t pud = READ_ONCE(*pudp);
+		next = pud_addr_end(addr, end);
 
-		addr = start + i * PUD_SIZE;
 		if (pud_none(pud) || pud_sect(pud)) {
 			note_page(st, addr, 2, pud_val(pud));
 		} else {
 			BUG_ON(pud_bad(pud));
-			walk_pmd(st, pudp, addr);
+			walk_pmd(st, pudp, addr, next);
 		}
-	}
+	} while (pudp++, addr = next, addr != end);
 }
 
 static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
 		     unsigned long start)
 {
-	pgd_t *pgdp = pgd_offset(mm, 0UL);
-	unsigned i;
-	unsigned long addr;
+	unsigned long end = (start < TASK_SIZE_64) ? TASK_SIZE_64 : 0;
+	unsigned long next, addr = start;
+	pgd_t *pgdp = pgd_offset(mm, start);
 
-	for (i = 0; i < PTRS_PER_PGD; i++, pgdp++) {
+	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
+		next = pgd_addr_end(addr, end);
 
-		addr = start + i * PGDIR_SIZE;
 		if (pgd_none(pgd)) {
 			note_page(st, addr, 1, pgd_val(pgd));
 		} else {
 			BUG_ON(pgd_bad(pgd));
-			walk_pud(st, pgdp, addr);
+			walk_pud(st, pgdp, addr, next);
 		}
-	}
+	} while (pgdp++, addr = next, addr != end);
 }
 
 void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
