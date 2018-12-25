Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE5C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:06:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57E8218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5GpWOSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57E8218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HCQVKbDuiIo4P3vhsomUF+h6jPe+v13/KFtzFynUQoI=; b=P5GpWOSA95p7iJ
	xEjKPtUlxGANgFC8qVZroXCMCYM/vYTMJoDj+O8Ezy/uNqExC4wwV8NqidmuC0wINaY4kaAWXswoz
	CkFQvC0hvDn3jKnK/8m1mlSZiwevJoXvxftXZ+mdSML32Ql8uF7nrcIYSpcRPCigZ305q30xDmn1s
	6FvJ+6TOyFv2kbG1CNDfbPWPcgdspxqxq76xQtKhmBKD0w6tS9sLE6axtjo3awj5wwYXEeK1zHY0l
	GHVSlOzmIPj/3nkaKHt2OeDgxuDWc+Ocv3HyTiGz7ccohzoKrfxbElyLloJ8e+vqYaoU54EIFTKOG
	8/Qg8jSfx+9CXzr2h9ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbc7L-000061-ML; Tue, 25 Dec 2018 02:06:47 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbc7E-00005C-Fw
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 02:06:45 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D08F1FC6B7B99;
 Tue, 25 Dec 2018 10:06:19 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Dec 2018 10:06:13 +0800
From: Kehong Zhang <zhangkehong@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>
Subject: [RFC] mm: add pad in sturct page 
Date: Tue, 25 Dec 2018 10:05:03 +0800
Message-ID: <1545703503-20939-1-git-send-email-zhangkehong@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_180640_709087_C530F76F 
X-CRM114-Status: GOOD (  15.03  )
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
Cc: Michal Hocko <mhocko@suse.com>, Rik van
 Riel <riel@surriel.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Vlastimil Babka <vbabka@suse.cz>, Andrey Konovalov <andreyknvl@google.com>,
 Andrey
 Ryabinin <aryabinin@virtuozzo.com>, Andrew Morton <akpm@linux-foundation.org>,
 Kehong Zhang <zhangkehong@hisilicon.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Souptick Joarder <jrdr.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

        When I analysis the performance of using nginx for static websites.
	I found a high cpu workload in the code below:

	mm/filemap.c
	@@ 1425,3 @@ struct page *find_get_entry(struct address_space 
						*mapping, pgoff_t offset)
	head = compound_head(page);
	if (!page_cache_get_speculative(head))
		goto repeat;
        
	The code will read page->compound_head and atomic add page->_refcount,
	which two variables are in the same cache-line. As multiple core 
	read/write two variables in the same cache-line	will cause serious
	slowdown, I test the performance of using nginx for static websites
	in two cases, add patch below and original.

	core num\Scenes        add pad        no pad      
	8core                  317654         344414

	As we know, struct page is the most used struct and should be as
	small as possible. And I don't have a better way to solve it, if
	anybody have any idea to solve it?

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kehong Zhang <zhangkehong@hisilicon.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Kehong Zhang <zhangkehong@hisilicon.com>
---
 arch/arm64/include/asm/memory.h | 2 +-
 include/linux/mm_types.h        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b9644296..652ccf6 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -41,7 +41,7 @@
  * requires its definition to be available at this point in the inclusion
  * chain, and it may not be a power of 2 in the first place.
  */
-#define STRUCT_PAGE_MAX_SHIFT	6
+#define STRUCT_PAGE_MAX_SHIFT	8
 
 /*
  * VMEMMAP_SIZE - allows the whole linear region to be covered by
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f62..0a11c5b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -179,6 +179,8 @@ struct page {
 		int units;			/* SLOB */
 	};
 
+	unsigned char pad[128];
+
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
 	atomic_t _refcount;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
