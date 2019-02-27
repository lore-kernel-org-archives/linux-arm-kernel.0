Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45772184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QYpOBZwq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mnQ4HtJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45772184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fdff+OxClfwAoKzVbsCsD7AsCBy/tU52D+qp0g7EHUc=; b=QYpOBZwqQzC0FT
	yeSXyXegdLdk9Me6OajpV30namMyO+znY1iNmfRcFPt3i0nd2qYF+c+etH2tuYHUgPP74m8DVZHNd
	6TCxV0/los3buQs/xU57EsOXaYh5fc+8n394Ayz2L+ajscSkrYettHHbl+Wsc83bLQa43kjfbZPy3
	KyCjdJWaXWhBQmvPffjzn9yejtTRo4nh/nqmrNFGRuYHF9jYWRI5c/hY9O7TowMzT7PJO6KE+8nRT
	srg8SvVLSgv+WEfbbz/6/qWCmM7Xd66mDK0CfB3Ed4mqLwSxFSYq3nlBCrtVCzneQwa0l8nF3l4ik
	ee/5B5vD/+pJtbFnYh0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz3fK-00063O-AG; Wed, 27 Feb 2019 18:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz3fJ-00063D-1Z
 for linux-arm-kernel@bombadil.infradead.org; Wed, 27 Feb 2019 18:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vbZU3Jpl8GuYX6FyWhyD9GsHMstn/Gx+XRtazXG+JbY=; b=mnQ4HtJq8Xan6uVjC/D5WcF7Bx
 OEmN/+AFDIvPKVURrKVrb6qNq+GrBD9r5pjkRe4rAYnlLkEoGUR/CtW6eyPG0ZHaIuzHVheGuLb6f
 98P8UNGQlcgW2FLa3EqABpkLokHR9a+5RfGtGuXLED4nUAM9u+LlxCBn0KlnjpywjO0AMgmba6qbd
 icO/S8aS719wjC+3hvQM6xeIKZuayumyH4sd5L/ZhguUkHzs2rrMJiS3zgQszn6yoHlbnTEgrvRyh
 KSwdqfCiWHCRQQ7YAotRzVAancAhfh1FiSZmxyJWIjKsyf5u7iPMdRDLzLXt6trAOz071ZTbCheCg
 fHVwKj/A==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2fv-0005Ts-GD
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:07:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD4F5174E;
 Wed, 27 Feb 2019 09:07:13 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384C63F738;
 Wed, 27 Feb 2019 09:07:10 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 12/34] nds32: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:46 +0000
Message-Id: <20190227170608.27963-13-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_120719_630674_13A18B66 
X-CRM114-Status: GOOD (  14.27  )
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
 Greentime Hu <green.hu@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, James Morse <james.morse@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For nds32, we don't support large pages, so add stubs returning 0.

CC: Greentime Hu <green.hu@gmail.com>
CC: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/nds32/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 9f52db930c00..202ac93c0a6b 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -309,6 +309,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 #define pmd_none(pmd)         (pmd_val(pmd)&0x1)
 #define pmd_present(pmd)      (!pmd_none(pmd))
+#define pmd_large(pmd)        (0)
 #define	pmd_bad(pmd)	      pmd_none(pmd)
 
 #define copy_pmd(pmdpd,pmdps)	set_pmd((pmdpd), *(pmdps))
@@ -349,6 +350,7 @@ static inline pmd_t __mk_pmd(pte_t * ptep, unsigned long prot)
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
 #define pgd_present(pgd)  	(1)
+#define pgd_large(pgd)		(0)
 #define pgd_clear(pgdp)		do { } while (0)
 
 #define page_pte_prot(page,prot)     	mk_pte(page, prot)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
