Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:14:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91922146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n2mrIYRx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oz6Vj4Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91922146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xEHp1ijCj7Nt+ux9z3nIOzsXZiC/jRGprubK/5Q7Tf0=; b=n2mrIYRx2WLBld
	9BOVXdv7hR0eZ/FjL5cX+xIRzUC+vS3qqhlH220QANdS08bybH7fe/rO+eeMo0OSn02cZKnRk4rDD
	UxOCM8FD+jfrPp8sW4DhidK9yRGb31JcO57fAsuS1WilAdbRqOqcls2XoJBh60cnjhlQMc25jWiUL
	1WhPVusCwsbBQIC+gCExo1JGntoa1515FDn4NOGol+7L14tgqtwqEtddvvqsda5jNRivvfb9RqGIt
	xJRJOcnUvKIPnx0R19EoIBdeAJy++XHokVhsEDVfIUi313yhSOHbkOQbI6ZUiIFzKWpW+rg2v6SyY
	ljHieeWJe7oMhMepOrLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvs6x-000168-F0; Mon, 18 Feb 2019 23:14:07 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvs6K-0000Kx-FY
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 23:13:29 +0000
Received: by mail-it1-x141.google.com with SMTP id r11so1900795itc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ptp8Fjet112pFAX81FwzCfRXujZdfs3mZO2hPYz+OK0=;
 b=oz6Vj4Z9Eu13inGGnH5X0txN4tIEXnED3IA3SA+DL8Hs6lXNzNnfm18np5LEndb7ZA
 voPhslSSyKSjUqu885dvRfDAXX/PbCgZmQFNVkOsVEN+4xI1ESCcr1mz5xtEvA5kvars
 09wiPRS+Hwsa+5nu9xpAsdZrJaodFZfBOg3XimOLubN9MU2y8MKftP9YelUNkAzC/6g9
 QAcyLa4Y+3B7hEfLJ2RdQBWvCjW1fk05ykLXknVMZlQjFrReHBgkwhMkb22PovOrMA07
 3g+h9qiMKm7CgJHN837fmuTIcRUGWB9IqflxYJVAswPy/99fhVawSTjRKNSbOu0mCQwq
 hz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ptp8Fjet112pFAX81FwzCfRXujZdfs3mZO2hPYz+OK0=;
 b=kyd4DVdlwUhf5dBgLOI1G4M/i4w07xoqzWPUTr/FxvGB+kQA1ZESE6S8sGBrMnsEm0
 p/lEwA0UM3i8hA2/VBnujrdPWAmZqDeFqwF3YXGCxqzccA6mPIOIhqH2L2IvpkacGaqC
 +MllGyYbqmLxNbWHRDtyZwHTSRD7HL3wpiFP7QxhZgdNn58GaaX+COe+hIn96/FWY4UR
 5PcW9qlUl48KwZCc57x+4rdu4k5KysWLfmk5kj7I9F4VSxM/I+0tW8SjbiEVm+5N8mgD
 n02U+aCb03kFssHQy/lddDHm08KOAB7JlhDMXA1q9I7SQUyJUJeF3huFCtJZGDPTNMqD
 l+9Q==
X-Gm-Message-State: AHQUAua5lk4NwvB3+KVqK3EWkXc5RB5F9MoE6ULTLVv4cqUwRLWSSDmt
 q5NiQ0934wkXEsxopxsz3kaX6A==
X-Google-Smtp-Source: AHgI3IacpXhp7hqR4gpLOYb6jmTOiOS9RIZiMJQCPu5S8CRxsY3H9kPVQ0HReFAyHwtbAO1IIUX12g==
X-Received: by 2002:a5d:8545:: with SMTP id b5mr15973963ios.288.1550531607332; 
 Mon, 18 Feb 2019 15:13:27 -0800 (PST)
Received: from yuzhao.bld.corp.google.com
 ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id x23sm6541463ion.38.2019.02.18.15.13.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 15:13:26 -0800 (PST)
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 3/3] arm64: mm: enable per pmd page table lock
Date: Mon, 18 Feb 2019 16:13:19 -0700
Message-Id: <20190218231319.178224-3-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_151328_514822_FCBF05EC 
X-CRM114-Status: GOOD (  15.94  )
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

Switch from per mm_struct to per pmd page table lock by enabling
ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
large system.

I'm not sure if there is contention on mm->page_table_lock. Given
the option comes at no cost (apart from initializing more spin
locks), why not enable it now.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 arch/arm64/include/asm/tlb.h     |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..8dbfa49d926c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y if PGTABLE_LEVELS > 2
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c73bf0..dabba4b2c61f 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -33,12 +33,22 @@
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	struct page *page;
+
+	page = alloc_page(PGALLOC_GFP);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	return page_address(page);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
 	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
+	pgtable_pmd_page_dtor(virt_to_page(pmdp));
 	free_page((unsigned long)pmdp);
 }
 
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 106fdc951b6e..4e3becfed387 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,7 +62,10 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pmdp));
+	struct page *page = virt_to_page(pmdp);
+
+	pgtable_pmd_page_dtor(page);
+	tlb_remove_table(tlb, page);
 }
 #endif
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
