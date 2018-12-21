Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE5EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:21:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F9120866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JpRmpL2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F9120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ociIcJFcBRUYFDfyc16BilOjmYul4Z+3U+iL4w+7c4g=; b=JpRmpL2IlIhYrT
	Mdif14M7j8mNtKccMS0fFzTlgyh8ZCGq8xmu30udqJEo3tRoYOPTiOVDat71osK9LA1RzCvFSNcYv
	nIIEChSeMnR1mzzITrrwu3pPo/rcR6KBAC5t0e7c7mlsP0D4BUTCbfszjjHDYc0ohtnpCWkBLJO+h
	pUig7mEtENKNdPwnyepll8ltWlxnYQQ9PfDJ/vOg+8cY98ektHOO1oNpfSLINvlFpbhKjQLJdxGsN
	Dyv53zpFRb6C0haalFCjHdkSOR6UJHpbWnFGNsieoIhANm24wquB1XhKfkYAp1hTaCLR0QIntVDI5
	ghdzTc0Bl3+SnIIvjmvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaOTs-0003FL-15; Fri, 21 Dec 2018 17:21:00 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaOTo-0003EI-6C
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 17:20:57 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Dec 2018 09:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; d="scan'208";a="305773566"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
 by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2018 09:20:44 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
 id 69927301036; Fri, 21 Dec 2018 09:20:44 -0800 (PST)
Date: Fri, 21 Dec 2018 09:20:44 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181221172044.GE25620@tassilo.jf.intel.com>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
 <20181218000800.GB25620@tassilo.jf.intel.com>
 <20181218091824.GI2218@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218091824.GI2218@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_092056_246855_310FFD01 
X-CRM114-Status: GOOD (  19.27  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 hubicka@ucw.cz, Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> In particular turning an address-dependency into a control-dependency,
> which is something allowed by the C language, since it doesn't recognise
> these concepts as such.
> 
> The 'optimization' is allowed currently, but LTO will make it much more
> likely since it will have a much wider view of things. Esp. when combined
> with PGO.
> 
> Specifically; if you have something like:
> 
> int idx;
> struct object objs[2];
> 
> the statement:
> 
>   val = objs[idx & 1].ponies;
> 
> which you 'need' to be translated like:
> 
>   struct object *obj = objs;
>   obj += (idx & 1);
>   val = obj->ponies;
> 
> Such that the load of obj->ponies depends on the load of idx. However
> our dear compiler is allowed to make it:
> 
>   if (idx & 1)
>     obj = &objs[1];
>   else
>     obj = &objs[0];
> 
>   val = obj->ponies;

I don't see why a compiler would do such an optimization. Clearly
the second variant is worse than the first, bigger and needs
branch prediction resources.

In fact compilers usually try hard to go into the other direction
and apply if conversion.

Has anyone seen real world examples of such changes being done, or is this
all language lawyering theory?

-Andi

> 
> Because C doesn't recognise this as being different. However this is
> utterly broken, because in this translation we can speculate the load
> of obj->ponies such that it no longer depends on the load of idx, which
> breaks RCU.
> 
> Note that further 'optimization' is possible and the compiler could even
> make it:
> 
>   if (idx & 1)
>     val = objs[1].ponies;
>   else
>     val = objs[0].ponies;
> 
> Now, granted, this is a fairly artificial example, but it does
> illustrate the exact problem.
> 
> The more the compiler can see of the complete program, the more likely
> it can make inferrences like this, esp. when coupled with PGO.
> 
> Now, we're (usually) very careful to wrap things in READ_ONCE() and
> rcu_dereference() and the like, which makes it harder on the compiler
> (because 'volatile' is special), but nothing really stops it from doing
> this.
> 
> Paul has been trying to beat clue into the language people, but given
> he's been at it for 10 years now, and there's no resolution, I figure we
> ought to get compiler implementations to give us a knob.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
