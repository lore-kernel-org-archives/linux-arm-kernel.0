Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C891222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ectDaqE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C891222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FSbf904w9xLlpWBPjvIlF6GlcxNcYBqyz2e4bCp12SU=; b=ectDaqE5GmVPf9
	C5zDnNGHkU2x2BiDMOBpM6zveujvOrYjAf39H/qDu0esN/1Oi3mVfYlLXaYF+JU70tRGdWwfOhKK1
	yiky6tIiEzVu2O0NWJrmRXzSSDCwezhoSAZ18ttM+6M+VBoOhiM878srAwMyQGBVR0JZ8i8E2zhUz
	swSbcj49a2tDo2Oslkz4af5vXpTOLJLBSMuQbxD7u6CeuWIlOee/nWfnrEepaWX5dFtmOBdCTJ1//
	aa49iP18YQiicC0ZUDVV+syXKltz77Xn3+x9Uyz8CMb67Csrt4rniUvGVHqLXOtaI9ZGKbxPaZYOL
	u7lrxJ7DLxi1l4FH2hVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsUi-0007F9-I7; Wed, 13 Feb 2019 11:14:24 +0000
Received: from outbound-smtp08.blacknight.com ([46.22.139.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsUf-0007ED-18
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:14:23 +0000
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
 by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id
 1F1761C1DD7 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 11:14:11 +0000 (GMT)
Received: (qmail 10497 invoked from network); 13 Feb 2019 11:14:11 -0000
Received: from unknown (HELO techsingularity.net)
 (mgorman@techsingularity.net@[37.228.225.79])
 by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated);
 13 Feb 2019 11:14:10 -0000
Date: Wed, 13 Feb 2019 11:14:09 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Yury Norov <yury.norov@gmail.com>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213111409.GN9565@techsingularity.net>
References: <20190213082134.GA21834@yury-thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213082134.GA21834@yury-thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_031421_205974_93276029 
X-CRM114-Status: GOOD (  18.51  )
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-arm-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> Hi Mel, all,
> 
> My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> Backtrace is not too verbose:
> (gdb) i threads
>   Id   Target Id         Frame
> * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
>     at arch/arm64/lib/delay.c:49
>   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
>   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
>   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> (gdb) bt
> #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
> Reverting the patch
> 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> fragmentation event occurs") together with following patch
> 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> helps me to boot normally. 
> 

Well, that's a bad start to any day. Thanks for tracking it down. Does
the following patch help? I can't test it properly as I didn't recreate
your boot image or initrd but this appears to get past the initial boot
phase at least.

---8<---
mm, page_alloc: Fix a division by zero error when boosting watermarks

Yury Norov reported that an arm64 KVM instance could not boot since after
v5.0-rc1 and could addressed by reverting the patches

1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")

The problem is that a division by zero error is possible if boosting occurs
either very early in boot or if the high watermark is very small. This
patch checks for the conditions and avoids boosting in those cases.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Reported-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..ae7e4ba5b9f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2170,6 +2170,11 @@ static inline void boost_watermark(struct zone *zone)
 
 	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
 			watermark_boost_factor, 10000);
+
+	/* high watermark be be uninitialised or very small */
+	if (!max_boost)
+		return;
+
 	max_boost = max(pageblock_nr_pages, max_boost);
 
 	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
