Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:00:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B05217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FQIYbsZq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hUZUNWu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B05217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K5qQodaWP7n8we/lA/QB21RGcLfmps44eQHtFTlKdpY=; b=FQIYbsZq9+OzyF
	fSSNpkU8c1NoBriMaZQNbgz04cW1RjmXtxRH/NHzvzI67Lz5pK0d3QzyVOgkgPqaRMaAjveCcp/7O
	ldMzdG62yXgxbGUzPXyJVfeu4DXIqu9bWUHnQKXvFY9HOv/8+GwhEUkrkmtRxP3MMMqs8D/G2kW7u
	GzJntzPSP0wcYDuVsctZNNmYPnzJOfOsPkeYeXbcl56ltN75WARUSDpnmkTc5JlUIXUetj44v688n
	QJvQd9AXeb0WblTcQF6YdeVrlRDl7Zw2uWPhzvntj/YaKqgIrJHVyHRNiDIvwTHyDcVokfkJZ8bob
	+WwHjUZHT+s7S7mkfjqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCAr-0007lO-73; Tue, 18 Dec 2018 10:00:25 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCAp-0007lF-8E
 for linux-arm-kernel@bombadil.infradead.org; Tue, 18 Dec 2018 10:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sAPOe0gM5iUG74dB+h9n+e8IQvrL8+xWqxnhfJm5eMg=; b=hUZUNWu33qeudHIzgIz9J5nEI
 w+AkybM2olseab72QSAhNbQzwpHIS/8xtvqBlhxubfLhqi8aZHfwONuriSaQ83aaefy8S6+zwALem
 DNDzaS5ahD9jkcN5Hq4d+jht6WKLOIvE+vnW6Sh4jpN/WOOmXN3QChX0WLAs+MYaQ2I8YwQcpFCqI
 56LgRx9nc2Z+pSWFCd78vOJk5C5LfGan3/8+9we6oa0Jd6jFswh1Hwe71LJ2ES32gBdSHmiX9mw8W
 7TCB1RXVBvVX+ox0LDH4eaFsjbUeVCW1rDX47kDczTBJnp0D8wfWU+ULZ8yaBD4Qlyj0wC0Vv9qjn
 LQMfsZkWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCAk-0007E3-EF; Tue, 18 Dec 2018 10:00:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6FE332027DA8E; Tue, 18 Dec 2018 11:00:14 +0100 (CET)
Date: Tue, 18 Dec 2018 11:00:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181218100014.GA16284@hirez.programming.kicks-ass.net>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
 <20181218000800.GB25620@tassilo.jf.intel.com>
 <20181218091824.GI2218@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218091824.GI2218@hirez.programming.kicks-ass.net>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:18:24AM +0100, Peter Zijlstra wrote:
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

A variant that is actually broken on x86 too (due to issuing the loads
in the 'wrong' order):

  val = objs[0].ponies;
  if (idx & 1)
    val = objs[1].ponies;

Which is a translation that makes sense if we either marked
unlikely(idx & 1) or if PGO found the same.

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
