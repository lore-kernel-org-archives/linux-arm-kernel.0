Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BC3218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmoETkxG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bsfGy1P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BC3218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sthsSvMUaaQjyiG0CMwXttSgvn7Rs18HWIvM/c2VlGU=; b=rmoETkxGcuPzWq
	1u8RaGr+1xl95OVH4okYmvlnjCAxRX9QuitV0oVqsFU+eCholUB8XMQlBPZdW7UhC+W4TAcv3ixji
	fDRmWfAUiVjkQjykGEqm7TDNQsR+oXgua73rdwg1C6PDYUV4uGi0a+ED/PSG/aNlz+h8Bv6lfPAW/
	s0leh0Cl+jDGZOX0B4TTS4D/VO+SiNXOWCdnII6Zi7QluI49Zrt6oW9ZfbQXxoiNfg1+wCtby9qbF
	pFWqmI6BA0soy0Pw58an5j4r6RiqUUUtxp1fYIwyark11O3BxDi1GTqw+xhnSM+yZ+/r2gyrMYX9U
	Zy+AZopE3nmXNU4mj88g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvs6S-0000VC-Vq; Mon, 18 Feb 2019 23:13:37 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvs6J-0000KV-AG
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 23:13:28 +0000
Received: by mail-it1-x143.google.com with SMTP id l66so1919547itg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V1IdqbYubtCixESl5TR0muUvkg/E2O8mQvzM202vMJY=;
 b=bsfGy1P+JAaNzK2xsZmC2Tj104zGh/lur1QTBqvenBJ2/qYq2g/zlrWxNZQtQfM35p
 SvHcbH51aav58mTv6SC3r+eXafQV/q2wT7dySMfLdYtqGwd3IU4BO5OncxK0Sc1m+fIj
 nQfKurxrxsrekUV5Engn2LJyRILWrYvwJyz5n0SWzgddARHKb325HaCw91Il4vDU1Zx/
 mk9/PYlyIFAHhkP2hr5znpaOUFZOUpl6KFCa/NcBzVtwHJoN4RB7/T7YpN2vbUZpYTCL
 LQgIbfhf2ht7PVFcOoXfG78S2gMcj0aiK0WoV3lEAuUhwncWxtNbknbhAN1dIFxSI790
 gxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V1IdqbYubtCixESl5TR0muUvkg/E2O8mQvzM202vMJY=;
 b=HlfyH1qI3pgLl4fE6jhEf2y23PkxO/yEJsEfv5i8ZnHGJG0s59HK3lKM5HDmlD9zUW
 tryyWkWIqu/l6rjS5Nysdv86ytyqw3kvJQi67Pe7vhg17wyg2J2EX00/ZtWMEamwdK4m
 QsaRmjuotT417b4qUiw0fUoC6QQnIfTYzlwlCwuMY3jGEo/ok4/icpY1qIW0AzGlS3DR
 rjQPrPUpg1Rif7Vm7jb0dSQ2GzEZUdJhHzYeVbVm4zCYQfjy5FE7PLgS0lbg9CWfO+U+
 6LI4z8tmdfaNAEgNKTLEs1ldgxCtCdZvs23yeGXqZTjMPhVV/0MY5wtC421utkyYvEhH
 +iHA==
X-Gm-Message-State: AHQUAua4mjl0TGaGdHgSd5PiUgNj/YEeIgltidAgDCXf3Q7ikJKI9kkC
 eZzf8jqYIbbO3C6o5cgjVFnuKw==
X-Google-Smtp-Source: AHgI3IZT6Mu4hL5CdKV5I1EiL7aKLnA6dLePkX8jtfw/N38Liese0eXKCRasVCtk+AF0ZUvijxlkeQ==
X-Received: by 2002:a24:7d88:: with SMTP id b130mr796701itc.163.1550531606189; 
 Mon, 18 Feb 2019 15:13:26 -0800 (PST)
Received: from yuzhao.bld.corp.google.com
 ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id x23sm6541463ion.38.2019.02.18.15.13.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 15:13:25 -0800 (PST)
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/3] arm64: mm: don't call page table ctors for init_mm
Date: Mon, 18 Feb 2019 16:13:18 -0700
Message-Id: <20190218231319.178224-2-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_151327_351891_A1F48F60 
X-CRM114-Status: GOOD (  15.26  )
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

init_mm doesn't require page table lock to be initialized at
any level. Add a separate page table allocator for it, and the
new one skips page table ctors.

The ctors allocate memory when ALLOC_SPLIT_PTLOCKS is set. Not
calling them avoids memory leak in case we call pte_free_kernel()
on init_mm.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fa7351877af3..e8bf8a6300e8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -370,6 +370,16 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
+static phys_addr_t pgd_kernel_pgtable_alloc(int shift)
+{
+	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
+	BUG_ON(!ptr);
+
+	/* Ensure the zeroed page is visible to the page table walker */
+	dsb(ishst);
+	return __pa(ptr);
+}
+
 static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
@@ -591,7 +601,7 @@ static int __init map_entry_trampoline(void)
 	/* Map only the text into the trampoline page table */
 	memset(tramp_pg_dir, 0, PGD_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
-			     prot, pgd_pgtable_alloc, 0);
+			     prot, pgd_kernel_pgtable_alloc, 0);
 
 	/* Map both the text and data into the kernel page table */
 	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
@@ -1067,7 +1077,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
+			     size, PAGE_KERNEL, pgd_kernel_pgtable_alloc,
+			     flags);
 
 	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
 			   altmap, want_memblock);
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
