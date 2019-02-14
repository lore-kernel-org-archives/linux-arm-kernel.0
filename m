Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF01C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:17:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD3F218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="llOj1nBp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="haog/nuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD3F218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5tKehTVHt9j8M2nRdjLECcOqR94ZEV4TidvZFUUX4uc=; b=llOj1nBp6Pv/9a
	8FU90X9RLUhMMR0Ewb5RCxC1NQOsk+QANP+zGloTm/Hm3HJiGPNeZeNi7YLNQsV8hvRU/R7K7muz0
	kt6/KvbTAxVlSiiwigJujgsAG0+G1aMqnI6f2qX+6uzEXdYBW2cGLqVoSte1HXCw1E+GZeTpYyE5s
	gTTO7iTYv9lpHWH9TcTLSf28cBlAjwcyf+kPan9EGm6+6JWomWlVBQjV8EUoMEYjwfj6qg2Z2bYSV
	FFtpjLTNGWIT1cDf8ykxB0BxPR8dq84rppNHlAEORRl0s84zM7Ril9YuzdUdbaTNkNAe7xz1+c9Zs
	DkO9hL49DLxBsoj4LB2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guONR-0001Ao-OL; Thu, 14 Feb 2019 21:17:01 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guONO-00019S-O9
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 21:17:00 +0000
Received: by mail-it1-x144.google.com with SMTP id l15so5297038iti.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GvPYFe28/mAoQO+bY6nMt8BakmTEWjcsUcqZny6LKyY=;
 b=haog/nuWNwVzMoU13+bJ0VOVleco8VrScsofzKVQriJp/kpIegpS08FgzPJW6MCcMM
 umb1am7jn04ZVfp/yOI5y2yZNIPu/vejkxNHZoUsN71HWLQEH7YIx7zv4pBqIcXovU3w
 JPZM6QRRB7y782DQnTFoAEKXvcAWCZ+X6byTykTsL+dfSL7xz/fpbcUiIBhrukUyvjLi
 g4eVuY6/2Kdj7uMouqF364Lq2Wvvx9u7FnZJDVv0fv6MtPkEGYCwZRV4qimeeXmvzRZw
 7OEpCUNx91DhVAacamw53xKewe0hTNal7SlZMnIezgIODwSu4C+aoijN+x+caBgPcoxZ
 /odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GvPYFe28/mAoQO+bY6nMt8BakmTEWjcsUcqZny6LKyY=;
 b=FGeU7dNM39Kn3eFpbaLJwRCs2abEkeHmOahIFD/MQDRxdrnaSeCe+aCcH0EGNKSoLQ
 IdMcCJGTBk1XU5l/ECvibNSPg3xGyScSYApY/PnKX4yCz4zgAWbelZ3ZjUVFt0Kb7G5m
 WGidhVa65WDEBq+Zv4Ysi+8HRjNms1SLb20JSNMVAdI/11b0IAsGAr8JpDarBqD3tMyR
 c1ol5+EU5ilcpAPCQW3cpux66aUTfftrHdYEJwQy/LalEqkml01TvXpI5iMqIbZ5NhSs
 2JGH3RmyjQh/rht3BF9ueM8IzTswgMn4s1c1QEQ0DeNEoqHUMo7CMhlUVXLTRvXaB7oG
 O8OA==
X-Gm-Message-State: AHQUAuavFaxVE+Mbb9ZtoNgLX5E9/eYfHzVGtaeAdbmzC2MlEZN71HEE
 kYiV8hMsugJ91mZkpoxvDNGAhA==
X-Google-Smtp-Source: AHgI3IYCX5V8B/n/JHfBn5gh5KmKCeTbBeku15y0Wkk318G3E77K2o5/6CJ6L2HV9dr2oRQlrIFuFg==
X-Received: by 2002:a24:9a84:: with SMTP id l126mr3836833ite.77.1550179014078; 
 Thu, 14 Feb 2019 13:16:54 -0800 (PST)
Received: from yuzhao.bld.corp.google.com
 ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id h2sm1491498itk.0.2019.02.14.13.16.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 13:16:53 -0800 (PST)
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: mm: enable per pmd page table lock
Date: Thu, 14 Feb 2019 14:16:42 -0700
Message-Id: <20190214211642.2200-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_131658_782326_EB63756E 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: linux-arch@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Nick Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
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
index a4168d366127..104325a1ffc3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y
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
