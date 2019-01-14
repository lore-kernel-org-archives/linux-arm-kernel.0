Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4021C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:21:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949FB2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hSIyK2Gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949FB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AdeafTsfuayfikybiBcNsl4QRhyz37dg4C4VIA34in8=; b=hSIyK2GmbSy3Ku
	ad7CsdRF7myagqh68FOT71WMLmPH2jqOLq7eDMd/l7pHAhf4lutGHANcOT7kmsa1wBQ0WOOz/kBiO
	J36NtFUYaRDLAcVRrkEVmp0Ck+irvKEkYyBTfiIK9HZ2RtkdP9gyfuvyMYAd99lGve1ADvueM3Kw1
	aijXot8/37VrSFeTT6DDFMy0TYUvpZ8no4Y3X2RPv+qWXfawmfE1T6Qma2sNcrW3NYdxmhnfp+aj1
	LsLTw/YjrIpOhphi1dstr3rQL00sQa2bqq2GpAKmbPfzxZGgsvYwFafV0DDOIDkSmuiN50iUoP+8C
	eLaXstN2XlCarhfEaW+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4zJ-0003wm-Po; Mon, 14 Jan 2019 16:21:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4zG-0003wF-4N
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:21:20 +0000
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CDF9420873;
 Mon, 14 Jan 2019 16:21:16 +0000 (UTC)
Date: Mon, 14 Jan 2019 11:21:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190114112115.1cbf21c0@gandalf.local.home>
In-Reply-To: <20190112065701.30841-1-changbin.du@gmail.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_082118_191398_D16927B5 
X-CRM114-Status: GOOD (  17.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 12 Jan 2019 14:57:01 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> This patch adds a new trace option 'funcgraph-retval' and is disabled by
> default. When this option is enabled, fgraph tracer will show the return
> value of each function. This is useful to find/analyze a original error
> source in a call graph.
> 
> One limitation is that kernel doesn't know the prototype of functions. So
> fgraph assumes all functions have a retvalue of type int. You must ignore
> the value of *void* function. And if the retvalue looks like an error code
> then both hexadecimal and decimal number are displayed.
> 
> In this patch, only x86 and ARM platforms are supported.
> 
> Here is example showing the error is caused by vmx_create_vcpu() and the
> error code is -5 (-EIO).
> 
> with echo 1 > /sys/kernel/debug/tracing/options/funcgraph-retval
> 
>  3)               |  kvm_vm_ioctl() {
>  3)               |    mutex_lock() {
>  3)               |      _cond_resched() {
>  3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
>  3)   0.704 us    |      } /* ret=0x0 */
>  3)   1.226 us    |    } /* ret=0x0 */
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
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>

Hi Changbin,

I'm rewriting a lot of the function graph tracer code to have
kretprobes be able to work on top of it. It's still a work in progress.
It would be easier to add something to that work when its done than to
do it now.

Thanks!

-- Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
