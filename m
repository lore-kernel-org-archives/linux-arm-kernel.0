Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF18BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E47214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6CfNLMd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jygpbt94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E47214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pEYy1N6iCcP/R+KEuNixsE9529rTIUYgIaI8GuVGeGI=; b=O6CfNLMdVDoi6A
	jZmezGZE5SLPQiuxDQnn+rNZBTthKq5zH0kgtP1PWfLj0VdwHjRTMZtMFyg+BKYwDwVEpXaW6uuj9
	B+q0jZfUKRkER5u9UlFBavCwp8TUxciZfwOb1IO0q8AVzuq07u0Bzr+SnvS7UHGW8azfD601Oc8nc
	8rdAqoOTRENds4lzmu30ABuutl9nFPYm+wP8yYKqOwve6g3j9VVRxLSfbheJEvyBUv3O7hzsGY50M
	efZZ6La5bbJZ6mqqcrSWcTH9HFr9YxGWDX6Rt7Ok6uAt5d/XV+s0g+5NGPKZnTcu9yl2/WXDXXI4j
	j7cITjp3oPNRrm+pb+Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmsr-0007fn-Ew; Thu, 21 Feb 2019 11:51:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmsj-0007P3-Hr
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 11:51:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GFC0FYBY+JUrvKT/vb2dapYcOoZxpui37OtBzYO/OGU=; b=Jygpbt94uOBJFCwodEoZJGehfM
 TJPVG4Che0fdOzMBpP7FVI/OKUEtQYbC/6UFVFHZcrWn67D7n3tgg9THdeIOc3iRggeopMUTGJhKK
 6JRvW0yW8wBq1OJUa5CJ/2uQNjzq31vScyKGNBMjdnc7b7zcpn2CICDStVxovB9u3Ga60km0FMKsA
 Qu5IhTSQPzaPEs/WAaYL9vyY2WoTMo6ApC+oWVL1Yg4ID9hZv7tkJdrDHzcaLMZCN+twmMxrc/S0e
 2KJqIEmPz9ByJPCOnsFW8rtFjU1vW32wjAb2sJpUaYo71qP0uBsQcStLXQjYDt8QEnNpM3jgdB9Hq
 bjyydXHg==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmdr-0005aO-4F
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 11:35:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBD6A16A3;
 Thu, 21 Feb 2019 03:35:49 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 451F73F5C1;
 Thu, 21 Feb 2019 03:35:46 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 09/13] x86/mm: Point to struct seq_file from struct pg_state
Date: Thu, 21 Feb 2019 11:34:58 +0000
Message-Id: <20190221113502.54153-10-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221113502.54153-1-steven.price@arm.com>
References: <20190221113502.54153-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_113551_625530_06DD969F 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

mm/dump_pagetables.c passes both struct seq_file and struct pg_state
down the chain of walk_*_level() functions to be passed to note_page().
Instead place the struct seq_file in struct pg_state and access it from
struct pg_state (which is private to this file) in note_page().

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/mm/dump_pagetables.c | 69 ++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index cf37abc0f58a..b1b86157d456 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -40,6 +40,7 @@ struct pg_state {
 	bool to_dmesg;
 	bool check_wx;
 	unsigned long wx_pages;
+	struct seq_file *seq;
 };
 
 struct addr_marker {
@@ -268,11 +269,12 @@ static void note_wx(struct pg_state *st)
  * of PTE entries; the next one is different so we need to
  * print what we collected so far.
  */
-static void note_page(struct seq_file *m, struct pg_state *st,
-		      pgprot_t new_prot, pgprotval_t new_eff, int level)
+static void note_page(struct pg_state *st, pgprot_t new_prot,
+		      pgprotval_t new_eff, int level)
 {
 	pgprotval_t prot, cur, eff;
 	static const char units[] = "BKMGTPE";
+	struct seq_file *m = st->seq;
 
 	/*
 	 * If we have a "break" in the series, we need to flush the state that
@@ -357,8 +359,8 @@ static inline pgprotval_t effective_prot(pgprotval_t prot1, pgprotval_t prot2)
 	       ((prot1 | prot2) & _PAGE_NX);
 }
 
-static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
-			   pgprotval_t eff_in, unsigned long P)
+static void walk_pte_level(struct pg_state *st, pmd_t addr, pgprotval_t eff_in,
+			   unsigned long P)
 {
 	int i;
 	pte_t *pte;
@@ -369,7 +371,7 @@ static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
 		pte = pte_offset_map(&addr, st->current_address);
 		prot = pte_flags(*pte);
 		eff = effective_prot(eff_in, prot);
-		note_page(m, st, __pgprot(prot), eff, 5);
+		note_page(st, __pgprot(prot), eff, 5);
 		pte_unmap(pte);
 	}
 }
@@ -382,22 +384,20 @@ static void walk_pte_level(struct seq_file *m, struct pg_state *st, pmd_t addr,
  * us dozens of seconds (minutes for 5-level config) while checking for
  * W+X mapping or reading kernel_page_tables debugfs file.
  */
-static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
-				void *pt)
+static inline bool kasan_page_table(struct pg_state *st, void *pt)
 {
 	if (__pa(pt) == __pa(kasan_early_shadow_pmd) ||
 	    (pgtable_l5_enabled() &&
 			__pa(pt) == __pa(kasan_early_shadow_p4d)) ||
 	    __pa(pt) == __pa(kasan_early_shadow_pud)) {
 		pgprotval_t prot = pte_flags(kasan_early_shadow_pte[0]);
-		note_page(m, st, __pgprot(prot), 0, 5);
+		note_page(st, __pgprot(prot), 0, 5);
 		return true;
 	}
 	return false;
 }
 #else
-static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
-				void *pt)
+static inline bool kasan_page_table(struct pg_state *st, void *pt)
 {
 	return false;
 }
@@ -405,7 +405,7 @@ static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
 
 #if PTRS_PER_PMD > 1
 
-static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
+static void walk_pmd_level(struct pg_state *st, pud_t addr,
 			   pgprotval_t eff_in, unsigned long P)
 {
 	int i;
@@ -419,19 +419,19 @@ static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
 			prot = pmd_flags(*start);
 			eff = effective_prot(eff_in, prot);
 			if (pmd_large(*start) || !pmd_present(*start)) {
-				note_page(m, st, __pgprot(prot), eff, 4);
-			} else if (!kasan_page_table(m, st, pmd_start)) {
-				walk_pte_level(m, st, *start, eff,
+				note_page(st, __pgprot(prot), eff, 4);
+			} else if (!kasan_page_table(st, pmd_start)) {
+				walk_pte_level(st, *start, eff,
 					       P + i * PMD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 0, 4);
+			note_page(st, __pgprot(0), 0, 4);
 		start++;
 	}
 }
 
 #else
-#define walk_pmd_level(m,s,a,e,p) walk_pte_level(m,s,__pmd(pud_val(a)),e,p)
+#define walk_pmd_level(s,a,e,p) walk_pte_level(s,__pmd(pud_val(a)),e,p)
 #undef pud_large
 #define pud_large(a) pmd_large(__pmd(pud_val(a)))
 #define pud_none(a)  pmd_none(__pmd(pud_val(a)))
@@ -439,8 +439,8 @@ static void walk_pmd_level(struct seq_file *m, struct pg_state *st, pud_t addr,
 
 #if PTRS_PER_PUD > 1
 
-static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
-			   pgprotval_t eff_in, unsigned long P)
+static void walk_pud_level(struct pg_state *st, p4d_t addr, pgprotval_t eff_in,
+			   unsigned long P)
 {
 	int i;
 	pud_t *start, *pud_start;
@@ -455,13 +455,13 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 			prot = pud_flags(*start);
 			eff = effective_prot(eff_in, prot);
 			if (pud_large(*start) || !pud_present(*start)) {
-				note_page(m, st, __pgprot(prot), eff, 3);
-			} else if (!kasan_page_table(m, st, pud_start)) {
-				walk_pmd_level(m, st, *start, eff,
+				note_page(st, __pgprot(prot), eff, 3);
+			} else if (!kasan_page_table(st, pud_start)) {
+				walk_pmd_level(st, *start, eff,
 					       P + i * PUD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 0, 3);
+			note_page(st, __pgprot(0), 0, 3);
 
 		prev_pud = start;
 		start++;
@@ -469,21 +469,21 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 }
 
 #else
-#define walk_pud_level(m,s,a,e,p) walk_pmd_level(m,s,__pud(p4d_val(a)),e,p)
+#define walk_pud_level(s,a,e,p) walk_pmd_level(s,__pud(p4d_val(a)),e,p)
 #undef p4d_large
 #define p4d_large(a) pud_large(__pud(p4d_val(a)))
 #define p4d_none(a)  pud_none(__pud(p4d_val(a)))
 #endif
 
-static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
-			   pgprotval_t eff_in, unsigned long P)
+static void walk_p4d_level(struct pg_state *st, pgd_t addr, pgprotval_t eff_in,
+			   unsigned long P)
 {
 	int i;
 	p4d_t *start, *p4d_start;
 	pgprotval_t prot, eff;
 
 	if (PTRS_PER_P4D == 1)
-		return walk_pud_level(m, st, __p4d(pgd_val(addr)), eff_in, P);
+		return walk_pud_level(st, __p4d(pgd_val(addr)), eff_in, P);
 
 	p4d_start = start = (p4d_t *)pgd_page_vaddr(addr);
 
@@ -493,13 +493,13 @@ static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
 			prot = p4d_flags(*start);
 			eff = effective_prot(eff_in, prot);
 			if (p4d_large(*start) || !p4d_present(*start)) {
-				note_page(m, st, __pgprot(prot), eff, 2);
-			} else if (!kasan_page_table(m, st, p4d_start)) {
-				walk_pud_level(m, st, *start, eff,
+				note_page(st, __pgprot(prot), eff, 2);
+			} else if (!kasan_page_table(st, p4d_start)) {
+				walk_pud_level(st, *start, eff,
 					       P + i * P4D_LEVEL_MULT);
 			}
 		} else
-			note_page(m, st, __pgprot(0), 0, 2);
+			note_page(st, __pgprot(0), 0, 2);
 
 		start++;
 	}
@@ -537,6 +537,7 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 	}
 
 	st.check_wx = checkwx;
+	st.seq = m;
 	if (checkwx)
 		st.wx_pages = 0;
 
@@ -550,13 +551,13 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 			eff = prot;
 #endif
 			if (pgd_large(*start) || !pgd_present(*start)) {
-				note_page(m, &st, __pgprot(prot), eff, 1);
+				note_page(&st, __pgprot(prot), eff, 1);
 			} else {
-				walk_p4d_level(m, &st, *start, eff,
+				walk_p4d_level(&st, *start, eff,
 					       i * PGD_LEVEL_MULT);
 			}
 		} else
-			note_page(m, &st, __pgprot(0), 0, 1);
+			note_page(&st, __pgprot(0), 0, 1);
 
 		cond_resched();
 		start++;
@@ -564,7 +565,7 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 
 	/* Flush out the last page */
 	st.current_address = normalize_addr(PTRS_PER_PGD*PGD_LEVEL_MULT);
-	note_page(m, &st, __pgprot(0), 0, 0);
+	note_page(&st, __pgprot(0), 0, 0);
 	if (!checkwx)
 		return;
 	if (st.wx_pages)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
