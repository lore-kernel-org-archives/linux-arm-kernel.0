Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA36C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:59:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD142177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s8XzePIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD142177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RHrTSyoCwsyA8PxBZx4JLI2ZEpyHoC3gr2cTsYzD7Yg=; b=s8XzePIYD5X7D8
	BG06OVl3Zz77EwTcEiq4EpoRJRxOw00KCLsKvI/0od4bfLM4Trk+T5zOaQJ9fYRsJeqiQVtvsczMp
	gchsK8qsNx3Sg4CNIA/ruZ0MsDU2oglaYMwkPQUtnlnx9sDZNrkwBfFJZzpegZcbSQvkQn7mZ2m6U
	EUAqibnUNsvyn6FrHV12ID4ajIC3C5r91XNgA9m+nsaKeTq/TFUtW9rmhhs2cvORDHzSPI9eTHK0u
	06AMyRq1xdQ82qLhlDThASV5yNjvYzv0rrUW1WuSrvV9sy/Qm23KsHSNT6dkm60qsW8DyLDCmxT42
	Zwr5axlmDvSUm/D3mAtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbnFL-00084g-O9; Tue, 25 Dec 2018 13:59:47 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gbnFE-00084P-D9; Tue, 25 Dec 2018 13:59:40 +0000
Date: Tue, 25 Dec 2018 05:59:40 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Kehong Zhang <zhangkehong@hisilicon.com>
Subject: Re: [RFC] mm: add pad in sturct page
Message-ID: <20181225135940.GA20878@bombadil.infradead.org>
References: <1545703503-20939-1-git-send-email-zhangkehong@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545703503-20939-1-git-send-email-zhangkehong@hisilicon.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will.deacon@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Souptick Joarder <jrdr.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 25, 2018 at 10:05:03AM +0800, Kehong Zhang wrote:
>         When I analysis the performance of using nginx for static websites.
> 	I found a high cpu workload in the code below:
> 
> 	mm/filemap.c
> 	@@ 1425,3 @@ struct page *find_get_entry(struct address_space 
> 						*mapping, pgoff_t offset)
> 	head = compound_head(page);
> 	if (!page_cache_get_speculative(head))
> 		goto repeat;
>         
> 	The code will read page->compound_head and atomic add page->_refcount,
> 	which two variables are in the same cache-line. As multiple core 
> 	read/write two variables in the same cache-line	will cause serious
> 	slowdown,

page->compound is written at allocation.  It's not modified during use,
so your analysis is wrong here.  What you're seeing is the first attempt
to access this struct page, so it's a cache-miss.  If you take away the
access to page->compound, you'll instead see all of the penalty incurred
on the next attempt to access the struct page.

>       I test the performance of using nginx for static websites
> 	in two cases, add patch below and original.
> 
> 	core num\Scenes        add pad        no pad      
> 	8core                  317654         344414

These numbers aren't particularly useful.  How stable are they from run
to run?  That is, if you do five runs, what range do they fall in?  Also,
is higher better or is lower better?  I can't tell if this is requests
per second or latency or something else being measured.

> 	As we know, struct page is the most used struct and should be as
> 	small as possible. And I don't have a better way to solve it, if
> 	anybody have any idea to solve it?

Obviously we're not going to grow struct page from 64 bytes to 256 bytes.
I have briefly investigated an idea to eliminate the reference counting
for page cache accesses that don't need to sleep, but it's a long way
down my todo list.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
