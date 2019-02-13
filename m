Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73164C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43ECE20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHQz5IUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43ECE20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xmHdn/b/zeESmMz3OqCQnFWQpWo42/gc5x8peCCIPfQ=; b=sHQz5IUlRzDzHy
	4sZk8QkRHCmD5o8YpKMwBb+ha84pJ+YKAXmKRC1t2p2Y/llq0JyNjiVDRUQ3b13uGpjcjdRHsrNPQ
	teR0263/mE+g24J7witf0z9F6SWBoN26f1nA9oN4hrK2O/3eDsi2pAlzC7H2+Rz0OSWc98SQjQTUU
	DLFuOqjyJYhD67pxTeNo0fWNOLOBU3JpHrR1scQ5O7vJjaeHMoPotNHCQcCJg0aIyCiUvwqbb1sLE
	3iIOgTqwj8LulR1oNwRK8SgCVVCjcEK2WjCTHeojr9jqQExW+pf3wqLi1oubQ3ptCi/FjyRCv9ik3
	rok4KNWd8/psgqPm5g7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsfR-0004Xc-KZ; Wed, 13 Feb 2019 11:25:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsfP-0004XE-25
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:25:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA702A78;
 Wed, 13 Feb 2019 03:25:26 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D3523F557;
 Wed, 13 Feb 2019 03:25:23 -0800 (PST)
Date: Wed, 13 Feb 2019 11:25:21 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213112520.GB1912@brain-police>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111843.GA1912@brain-police>
 <20190213112141.GO9565@techsingularity.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213112141.GO9565@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_032527_109768_9478C78A 
X-CRM114-Status: GOOD (  17.65  )
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Yury Norov <yury.norov@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
 Zi Yan <zi.yan@cs.rutgers.edu>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 11:21:41AM +0000, Mel Gorman wrote:
> On Wed, Feb 13, 2019 at 11:18:44AM +0000, Will Deacon wrote:
> > On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> > > My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> > > Backtrace is not too verbose:
> > > (gdb) i threads
> > >   Id   Target Id         Frame
> > > * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
> > >     at arch/arm64/lib/delay.c:49
> > >   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
> > >   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
> > >   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> > > (gdb) bt
> > > #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> > > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > > 
> > > Reverting the patch
> > > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > > fragmentation event occurs") together with following patch
> > > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > > helps me to boot normally. 
> > > 
> > > Some system information is below, and config is attached.
> > 
> > FWIW, running with your command-line and .config under KVM with earlycon
> > leads to an early page allocation failure followed by a NULL dereference
> > during boot if only 1G is configured (log below). For the mm folks, it's
> > probably worth pointing out that you're using 64k pages.
> > 
> 
> Thanks Will.
> 
> While I agree that going OOM early is a problem and would explain why
> the boosting logic was hit at all, it's still the case that the boosting
> should not divide by zero. Even if the booting is broken due to a lack
> of memory, I'd still not prefer to crash due to 1c30844d2dfe272d58c.

Yup, sorry, our previous mails crossed paths. Your patch looks sensible in
its own right, I'm just left wondering why we're OOM so early during boot!

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
