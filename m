Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313A3C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:37:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E858F2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IXJbYmif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E858F2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nNBFc1NYsFryYu/zO3q/ulJcPC86oPxJYUndQskAhR0=; b=IXJbYmifdItiML
	H4Cmn1ntLpzKkkGlRWlhdwzPe9FQ2J5wdge4Earc73JIWy9G14JMwIqHozNfobIJ/cr6V10OAR6Ka
	PTCGtkUEDXlq3sfu2HdHEK1c3Wn/3I6N3y71JkMoYWqnfjEjKPjJ5AWvSpmPcCbQBYUMT8GgYX15y
	wpBwLJPf6Om+LCoq4qVc5GODfTMIaVcVRX8MCXf0mAR0d9TWBVme4ro/nVA5GrMu3FxNSzv8EhyrG
	91BvPmJ4auwGVxZLgGmf+DUVTWDcUrzeIyH9OI/2DeNd0EE7fCz9gIbb0MY1v4L/k+GHjr5TwUKld
	h0pBoy6mVsVg3NHwpzWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grpTq-0007dj-5q; Thu, 07 Feb 2019 19:37:02 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grpTn-0007db-3V; Thu, 07 Feb 2019 19:36:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8E1222029E062; Thu,  7 Feb 2019 20:36:56 +0100 (CET)
Date: Thu, 7 Feb 2019 20:36:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-tip 04/22] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190207193656.GF32511@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-5-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549566446-27967-5-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 02:07:08PM -0500, Waiman Long wrote:

> +static inline int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +			return 1;
> +		}
> +	}

Nah, you're supposed to write that like:

	for (;;) {
		val = atomic_long_cond_read_relaxed(&sem->count, VAL < 0);
		if (atomic_long_try_cmpxchg_acquire(&sem->count, &val,
						    val + RWSEM_ACTIVE_READ_BIAS))
			break;
	}

> +	return 0;
> +}


Anyway, yuck, you're keeping all that BIAS nonsense :/ I was so hoping
for a rwsem implementation without that impenetrable crap.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
