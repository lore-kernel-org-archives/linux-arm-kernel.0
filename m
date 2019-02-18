Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF9C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35F521901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QhszEAQz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Kim7VCp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35F521901
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=471zge+HjNJVqWRM7gFbjn3rxWkZXasALX3p7Tq3In8=; b=QhszEAQzqDyEe5
	j7v3d7lSEHsWVGQnGwdnRyQwoZDxmSP+YFzo9IDllazY6Cr9KsuzG/8OyBBGld+UnbBEGj6BUHx2f
	JNyr5ofNnmBOC+aJH2i9HbobbagI4TBuWQGly4e0bbwfwOxND3Cd1O5jXqOXmntEaMkrih9Nru7ug
	hdfzFX/z9wKEuS6KF4ld7iFyOROkrFutBm0yodgmV2H2dI/qJaiLmBa0QN5nGyos9KZwTp8PZNdPV
	kGbx5vjCg9BAcKZBY7Q65OM7/FjH5T6qeD60YEpRfsmTYbEJNZGd7ZVe3tFMKvLhTY9pCy1IAOzq9
	i8WkFbrSFR+kHQ9ZQeyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvs6L-0000LO-TS; Mon, 18 Feb 2019 23:13:29 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvs6I-0000KU-Tp
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 23:13:28 +0000
Received: by mail-it1-x142.google.com with SMTP id i2so1890180ite.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U/EYw2rlCI4mDqlXBqXNVekL8hDo+V+cu5waHUfY2FU=;
 b=Kim7VCp0StMXRnvvAWqYcMEpvO63kYz5zHERRNvlruuQQyJ/O/6e+78airAc6V3njt
 QPh65tXH7igo5M8n9Y+AY35NXYR4O99incnRtGZjj5tDT4G/3SpUfm/d5+VrXm3QMc14
 75MeWggtjgmG93XKz8SbkdnbNJxnW40gBOu2nYy4fTAaAZalUyFgJHBLbbsFBZcpmf7r
 gIqdQ766/KCsrLwCM+YpAq/CN78i4u/aY+3DZvUca0RcFYIOEnylrKumqeycBQkWaONH
 MUXpvu3EkRdDRMckSlclBjo8KbsFUEzseKNLXMHT/gA5Kd3J8udX+m6D9rsbbBHZIn4Z
 4luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U/EYw2rlCI4mDqlXBqXNVekL8hDo+V+cu5waHUfY2FU=;
 b=l4q9+ouGm/G7/xGTeL1JpIOIIi+TCAQt/CjHCDIsCdURX5SN3kvrH6Stukr+FJRXP7
 sFtyBfbYorSi4CmM7NPEDgIvUqbwE85DqQf+KMN6AVvlDpH6yYCgxt3M1MNxqBr64Pv0
 Qc29bk3rlYImifJJwew7QDnaIuT4Yt15/MEacwxoDc1JToAnUMIkd6nXcybpMHnoj9BR
 g99YZNOH4QN+Bwrks2oDOVJxshkju26hzkjW12iQD/LCm3/FszDk52eWdXiTHRckM2Bh
 KtLdt8RO9eEi2lrFvyjvVXJyC8hvjGXbMdH+Slok4qADFum1p89jN6fKODEg8END747C
 6OlA==
X-Gm-Message-State: AHQUAuaiw+PkFtxlkWSEZ6pBzhiPQiMcHVeGP9uz4o33MvYGnyX9prgH
 irHvBSGOKJljeRKPQOezmrMhUQ==
X-Google-Smtp-Source: AHgI3IZhDNTkjmRqX5ciPMAt1QHx6yCLXNgtuFuVzvtd4/Fv0kqYiBMJG132E3NRHTpB/NiNuEH4qw==
X-Received: by 2002:a24:918c:: with SMTP id i134mr744158ite.92.1550531604541; 
 Mon, 18 Feb 2019 15:13:24 -0800 (PST)
Received: from yuzhao.bld.corp.google.com
 ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id x23sm6541463ion.38.2019.02.18.15.13.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 15:13:23 -0800 (PST)
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Date: Mon, 18 Feb 2019 16:13:17 -0700
Message-Id: <20190218231319.178224-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214211642.2200-1-yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_151326_988645_D1C55B50 
X-CRM114-Status: GOOD (  15.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Nick Piggin <npiggin@gmail.com>, Jun Yao <yaojun8558363@gmail.com>,
 linux-mm@kvack.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For pte page, use pgtable_page_ctor(); for pmd page, use
pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
p4d and pgd), don't use any.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b6f5aa52ac67..fa7351877af3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -98,7 +98,7 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static phys_addr_t __init early_pgtable_alloc(void)
+static phys_addr_t __init early_pgtable_alloc(int shift)
 {
 	phys_addr_t phys;
 	void *ptr;
@@ -173,7 +173,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void),
+				phys_addr_t (*pgtable_alloc)(int),
 				int flags)
 {
 	unsigned long next;
@@ -183,7 +183,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	if (pmd_none(pmd)) {
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
-		pte_phys = pgtable_alloc();
+		pte_phys = pgtable_alloc(PAGE_SHIFT);
 		__pmd_populate(pmdp, pte_phys, PMD_TYPE_TABLE);
 		pmd = READ_ONCE(*pmdp);
 	}
@@ -207,7 +207,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot,
-		     phys_addr_t (*pgtable_alloc)(void), int flags)
+		     phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pmd_t *pmdp;
@@ -245,7 +245,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void), int flags)
+				phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
@@ -257,7 +257,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	if (pud_none(pud)) {
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
-		pmd_phys = pgtable_alloc();
+		pmd_phys = pgtable_alloc(PMD_SHIFT);
 		__pud_populate(pudp, pmd_phys, PUD_TYPE_TABLE);
 		pud = READ_ONCE(*pudp);
 	}
@@ -293,7 +293,7 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 
 static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(void),
+			   phys_addr_t (*pgtable_alloc)(int),
 			   int flags)
 {
 	unsigned long next;
@@ -303,7 +303,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	if (pgd_none(pgd)) {
 		phys_addr_t pud_phys;
 		BUG_ON(!pgtable_alloc);
-		pud_phys = pgtable_alloc();
+		pud_phys = pgtable_alloc(PUD_SHIFT);
 		__pgd_populate(pgdp, pud_phys, PUD_TYPE_TABLE);
 		pgd = READ_ONCE(*pgdp);
 	}
@@ -344,7 +344,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 unsigned long virt, phys_addr_t size,
 				 pgprot_t prot,
-				 phys_addr_t (*pgtable_alloc)(void),
+				 phys_addr_t (*pgtable_alloc)(int),
 				 int flags)
 {
 	unsigned long addr, length, end, next;
@@ -370,11 +370,20 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
-static phys_addr_t pgd_pgtable_alloc(void)
+static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
-	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
-		BUG();
+	BUG_ON(!ptr);
+
+	/*
+	 * Initialize page table locks in case later we need to
+	 * call core mm functions like apply_to_page_range() on
+	 * this pre-allocated page table.
+	 */
+	if (shift == PAGE_SHIFT)
+		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
+	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
+		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));
 
 	/* Ensure the zeroed page is visible to the page table walker */
 	dsb(ishst);
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
