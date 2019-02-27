Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6B3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785D62184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WWnUBupc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iiORBsyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785D62184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/tzWTXpLsSkZV0Sy45sAfaN3Qp/M+vhv6NCF4lAGxeY=; b=WWnUBupc7VzPBO
	xr+toU7bKEIHcjVhQdv6qsbWqe8jqSWw45Mr/YY4zuUYlHInjEXNaiAg5Bk3sYonZZ8gW/DP7cWTz
	l2KXsavVrMDrpv4FbiFWtnjYXAO46Xj1FPARwnUN1vkbhMxKV8v3W+obPtiJ1LbkEDfUOCR0fhRmy
	yrTjeALvxHGYQLG24ENsivxOolZHxLjkaK4CR9aIwYUb8P83KSFn6Xz2jmzHgcP7GRd2QxIcIv4nA
	m7THHBi92MBG7e8UPqR5GKQ6gxj873ulEZ21DUW+eBPRDy+2VbsSPs01eNU2wZtOsR6VnIws89OrV
	/GnC+aFbyVrUhiGE0Lkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz3ft-0006jx-Q4; Wed, 27 Feb 2019 18:11:21 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz3fN-00063D-N4
 for linux-arm-kernel@bombadil.infradead.org; Wed, 27 Feb 2019 18:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cpDv3mBvbD8hNAclYHZlrnWhwlRtUYmq/kJWE5bqZAU=; b=iiORBsypTjsNxPqzaWKCHcFf7P
 7bz+E6DFUxY9X4DvvbnN4kH7Y5wQQmNOfc/F1GGq3l716V/xnmokXORBH40Mb8r69HZ5F5oetCO7G
 2wiUzOGDn8ZIJnNtLRzUS68LPomG5ezm3kcy8k5Q8HBBsHXXnfn9/GEjTwQm4ty8TxHDMr1AwzKdW
 VSkNXvkjpgSz4U9ZtcFzBL2Lf5C+HXjwQynU//euQSBHB89HLzIpIsWaHFEpdJxx1JBFFK2mrLIFl
 CHJKgsQJZ9FUAiS/K6yjMsfVO0ACaaDWvjOVTFj1r1U2Rb18zPdAgBUdDhmf7ikivNSsk0/oOoEd7
 UqfZBJvg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2g2-0005Uz-Ir
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:07:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FFCD1688;
 Wed, 27 Feb 2019 09:07:25 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEAE63F738;
 Wed, 27 Feb 2019 09:07:21 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 15/34] parisc: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:49 +0000
Message-Id: <20190227170608.27963-16-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_120726_711971_AD798F13 
X-CRM114-Status: GOOD (  16.32  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Steven Price <steven.price@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For parisc, we don't support large pages, so add stubs returning 0.

CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
CC: Helge Deller <deller@gmx.de>
CC: linux-parisc@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/parisc/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index c7bb74e22436..1f38c85a9530 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -302,6 +302,7 @@ extern unsigned long *empty_zero_page;
 #endif
 #define pmd_bad(x)	(!(pmd_flag(x) & PxD_FLAG_VALID))
 #define pmd_present(x)	(pmd_flag(x) & PxD_FLAG_PRESENT)
+#define pmd_large(x)	(0)
 static inline void pmd_clear(pmd_t *pmd) {
 #if CONFIG_PGTABLE_LEVELS == 3
 	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED)
@@ -324,6 +325,7 @@ static inline void pmd_clear(pmd_t *pmd) {
 #define pgd_none(x)     (!pgd_val(x))
 #define pgd_bad(x)      (!(pgd_flag(x) & PxD_FLAG_VALID))
 #define pgd_present(x)  (pgd_flag(x) & PxD_FLAG_PRESENT)
+#define pgd_large(x)	(0)
 static inline void pgd_clear(pgd_t *pgd) {
 #if CONFIG_PGTABLE_LEVELS == 3
 	if(pgd_flag(*pgd) & PxD_FLAG_ATTACHED)
@@ -342,6 +344,7 @@ static inline void pgd_clear(pgd_t *pgd) {
 static inline int pgd_none(pgd_t pgd)		{ return 0; }
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
+static inline int pgd_large(pgd_t pgd)		{ return 0; }
 static inline void pgd_clear(pgd_t * pgdp)	{ }
 #endif
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
