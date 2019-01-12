Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D0C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:21:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5C220854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jFq+6SAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5C220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sDSBnPGEdQ9x7/Q386qj6KK7fiN4D6NxJZgwYWGuV3Q=; b=jFq+6SAyW9DV1q
	1xEP7OwIhnZvRQYBvue5zk2MF2wuyAOCYfThe/dFnB2u77W3xzYt4byGUpmIOR9ImDaVxEwGNcPFZ
	ZvRaUOplr1aTllAF/mQ/xnl88pBmszvne42b5zW3pk3ur1cvfvJU6koWWdGnPvtPKmTVSmFRcseHn
	vyY5HK/nug7iJtuvoTywiWhk8ZyF5XnUL6rSG3pMmAXiMMdhB4S658qzuT0duTOMSE/OGDGEaYapX
	bddBWTgjr5Fj7/KnP9MbpgCegRtdUlp6oS+KcOqtuhKXFGco2SFhO/m0cfR+XHwJjuuiWGk37Qe3P
	2s1v/BGvoJVcSK/MwXKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIHt-0008Bg-3G; Sat, 12 Jan 2019 12:21:17 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1giIHp-0008BR-G4; Sat, 12 Jan 2019 12:21:13 +0000
Date: Sat, 12 Jan 2019 04:21:13 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190112122113.GR6310@bombadil.infradead.org>
References: <20190112065701.30841-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190112065701.30841-1-changbin.du@gmail.com>
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
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 02:57:01PM +0800, Changbin Du wrote:
> This patch adds a new trace option 'funcgraph-retval' and is disabled by
> default. When this option is enabled, fgraph tracer will show the return
> value of each function. This is useful to find/analyze a original error
> source in a call graph.
> 
> One limitation is that kernel doesn't know the prototype of functions. So
> fgraph assumes all functions have a retvalue of type int. You must ignore
> the value of *void* function. And if the retvalue looks like an error code
> then both hexadecimal and decimal number are displayed.

I don't think we can do this.  You're leaking a _lot_ of kernel addresses
this way, and we've been trying very hard to avoid doing that because
it gives a lot of information to attackers.

Something more clever that prints out only errors (ie IS_ERR_VALUE())
might be acceptable.  I would think printing return values that are
between 0 and 4095 should also be OK since they can't be real pointers.
We'd leak whether a function called kmalloc(0, x) since that returns
16, but that seems like a not-very-useful information leak.

>  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
>  3)               |    kvm_arch_vcpu_create() {
>  3)               |      vmx_create_vcpu() {
>  3) + 17.969 us   |        kmem_cache_alloc(); /* ret=0xffff88813a980040 */
>  3) + 15.948 us   |        kmem_cache_alloc(); /* ret=0xffff88813aa99200 */
>  3)   0.653 us    |        allocate_vpid.part.88(); /* ret=0x1 */
>  3)   6.964 us    |        kvm_vcpu_init(); /* ret=0xfffffffb */
>  3)   0.323 us    |        free_vpid.part.89(); /* ret=0x1 */
>  3)   9.985 us    |        kmem_cache_free(); /* ret=0x80000000 */
>  3)   9.491 us    |        kmem_cache_free(); /* ret=0x80000000 */
>  3) + 69.858 us   |      } /* ret=0xfffffffffffffffb/-5 */
>  3) + 70.631 us   |    } /* ret=0xfffffffffffffffb/-5 */
>  3)               |    mutex_lock() {
>  3)               |      _cond_resched() {
>  3)   0.199 us    |        rcu_all_qs(); /* ret=0x80000000 */
>  3)   0.594 us    |      } /* ret=0x0 */
>  3)   1.067 us    |    } /* ret=0x0 */
>  3)   0.337 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
>  3) + 92.730 us   |  } /* ret=0xfffffffffffffffb/-5 */

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
