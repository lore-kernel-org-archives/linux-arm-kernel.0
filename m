Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828E5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5263D20643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AlqwUmSe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rOdTOU/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5263D20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V09WEHCPnRFv7n7bUMG9HXcNRQog9bCk+gn868a0Btc=; b=AlqwUmSesLlTZK
	3suLRgga1EDcXab3WDSuHCcH/XZcv/03J6ZchJ5uoDvHKOj6qhJRBYWItN02O9Y33VwSXx5Q+iumh
	s+CiRWwtnHPVrNltSadXp+c7p/QKTp2LYPBM0FZw7bO7vwcogH2E7phqHMq0jAj2XtzS2IE1nL60f
	L9fkshq+RnQjblvW2nApEuJNIAzD8zBqyffqEn8Y3ZoeCDzSzx+kOf5u5CCdNtPd2FehRGUiwT+MR
	hF2awW5Xx5lCD9EvvMM5R9ZPnwAhXQpp+yth91qcC95LxJ3xL42ZrKrZcHvZp3eOHydIL76qeppxy
	z9jf/1hshDqR/2kxGtBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2vw-00037R-Br; Wed, 27 Feb 2019 17:23:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2vs-0002gA-Ps
 for linux-arm-kernel@bombadil.infradead.org; Wed, 27 Feb 2019 17:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N4WRLTZt28lkUemP8bmvX63q6AU2uYVq26PdhSIkK84=; b=rOdTOU/gGeSgViWbYQIaN0JgHA
 2cxA7a6xcYiGQjSYMoZVPB+mGekNOMo5DhMIv/l3xgIXdsT7MQbdLEGH7ZJYXFv1YyfJDGnedkARS
 V2a9bc9AiHU4/izbKxu8gFgboXOaC0+rHZTfhGHE4KKnwqyNJiAryB7naM+Bmhr1QpeUkMbapFqR7
 ORw15YYzAlkDJSpUFrvsOKrvzRCAJmd3yXL3WSOFny2igj5C3ojRRyLRuPzW1QOddFbxoE2PUOQQ0
 sgzeG1ApIGvqPWj1ClgPX29wT+MlMKh9oSVbc4XWW4kuMdOU+edWX9xRhPrVOStXGX8JWqW5NxAfb
 attFxyTQ==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2gI-0000Vh-1l
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:07:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E822174E;
 Wed, 27 Feb 2019 09:07:41 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5CD3F738;
 Wed, 27 Feb 2019 09:07:37 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH v3 19/34] sh: mm: Add p?d_large() definitions
Date: Wed, 27 Feb 2019 17:05:53 +0000
Message-Id: <20190227170608.27963-20-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_170742_570870_2C3A8693 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
 Steven Price <steven.price@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For sh, we don't support large pages, so add stubs returning 0.

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/sh/include/asm/pgtable-3level.h | 1 +
 arch/sh/include/asm/pgtable_32.h     | 1 +
 arch/sh/include/asm/pgtable_64.h     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 7d8587eb65ff..9d8b2b002582 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -48,6 +48,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 #define pud_present(x)	(pud_val(x))
 #define pud_clear(xp)	do { set_pud(xp, __pud(0)); } while (0)
 #define	pud_bad(x)	(pud_val(x) & ~PAGE_MASK)
+#define pud_large(x)	(0)
 
 /*
  * (puds are folded into pgds so this doesn't get actually called,
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 29274f0e428e..61186aa11021 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -329,6 +329,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 #define pmd_present(x)	(pmd_val(x))
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	(pmd_val(x) & ~PAGE_MASK)
+#define pmd_large(x)	(0)
 
 #define pages_to_mb(x)	((x) >> (20-PAGE_SHIFT))
 #define pte_page(x)	pfn_to_page(pte_pfn(x))
diff --git a/arch/sh/include/asm/pgtable_64.h b/arch/sh/include/asm/pgtable_64.h
index 1778bc5971e7..80fe9264babf 100644
--- a/arch/sh/include/asm/pgtable_64.h
+++ b/arch/sh/include/asm/pgtable_64.h
@@ -64,6 +64,7 @@ static __inline__ void set_pte(pte_t *pteptr, pte_t pteval)
 #define pmd_clear(pmd_entry_p)	(set_pmd((pmd_entry_p), __pmd(_PMD_EMPTY)))
 #define pmd_none(pmd_entry)	(pmd_val((pmd_entry)) == _PMD_EMPTY)
 #define pmd_bad(pmd_entry)	((pmd_val(pmd_entry) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define pmd_large(pmd_entry)	(0)
 
 #define pmd_page_vaddr(pmd_entry) \
 	((unsigned long) __va(pmd_val(pmd_entry) & PAGE_MASK))
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
