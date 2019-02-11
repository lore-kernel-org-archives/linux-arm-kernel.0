Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:40:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D8A2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c1QGJQXJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNRXSHAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D8A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y0EgoPEkjEUEJ9OzeKbzTA31KG4D7bRIVqEx6N5A6/U=; b=c1QGJQXJX3mbiZ
	rwxGKurmsh/cu8Hvlr2Qc05IOQzM1chMUHaxhf/b/OXDY6YjdkQYTz0XtS7gbLAn9jGDWKCbu4/kI
	mTvw2xLgYrwLGOObNd8V0lw5bNhLF8u69wnc/mXqkZbaXqUTjK0HQu+oPwk8NZSvXPvZKQfTSiEum
	syH46qgKtx9it87bbuH5k0StU0JERhu+2gerBNKBdqmfTshnxEzEgakaTs44WFOj08/T7ZkHAgGyr
	TvDmNJz6jSud7w7WOdyBDrncUmH5NzZ9oJy814yTH6a+BXrPEKe99CM0qRprWWOPoj71mMRtmH3ON
	ZEn6f7NFoQUzOsSMtMbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt854-00016E-4q; Mon, 11 Feb 2019 09:40:50 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt852-00015w-3b
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 09:40:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ghs6LH9pD2+Qt1fMHsHWX7VIkwjblgvPz91UThcXfc=; b=nNRXSHARKVBmPUa0LVuH1O7kS
 D/oHBcrwrbjjDaMI/I4qewdIuT/u+ArfVn2Q44kMxGKdqoZU4BrB2JiF0LZk1bGZZs9L580RjqEhj
 L/USBXhXhYD/MgwY5GbFdlv5b6PiOyMPil73fSwdB7H5xlLFS5BPFM67km0fFGywwBOAawYMifq1G
 HSHzGXev8QvIMVygJwKAVAp68/g6FyGSdabNsVYCSP3ClQnb39d/wPIfqLOWNXziE3BHkxIZYnbfz
 /l7StgJN3Z3/SLfPW5ugji1Mm5WmfSdNY0eEzYTydiDQebUNZUpbq0AD6mr1QzMtp4JGqmU6Lyx2E
 +SFo6yR3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt84z-0006Pu-Pp; Mon, 11 Feb 2019 09:40:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8EEA220D0BED0; Mon, 11 Feb 2019 10:40:44 +0100 (CET)
Date: Mon, 11 Feb 2019 10:40:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211094044.GG32534@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <20190211093601.GT32511@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211093601.GT32511@hirez.programming.kicks-ass.net>
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

On Mon, Feb 11, 2019 at 10:36:01AM +0100, Peter Zijlstra wrote:
> On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:
> > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > +{
> > +	long tmp;
> > +
> > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > +			return 1;
> 
> That really wants to be:
> 
> 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> 						    tmp + RWSEM_ACTIVE_READ_BIAS))
> 
> > +		}
> > +	}
> > +	return 0;
> > +}

Also, the is the one case where LL/SC can actually do 'better'. Do you
have benchmarks for say PowerPC or ARM64 ?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
