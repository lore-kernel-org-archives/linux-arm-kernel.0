Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C63AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:58:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37007208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cDKDqcs3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBaqha41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37007208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HBjSpoVDatuvXvwHnEF8XCvEmT7YSeJwG/cLnR+p0n4=; b=cDKDqcs3vgwEvj
	ey1xs1XYtrEMHdP1gOmwS8wRnbQowMHluhhmctcjD6mwkuJ3N/Hb92pI/0yE+VctrrQjCTXURYrvR
	uJTAlsesRewCxxpr0/19WTcMSvFJAv+uSL7G1ademtHJMvIHmQdfS0+VE2NVuxoDkxDUa5HdXHLlH
	I5DDJu5Af8POlKxLURNKzRLOLdFMHtbsB2Amvg2tMHVxxqCeqcoWO4WNQA+vMxd7BYcwiykYU83QM
	sTt7dZDsj8ew1lyFuI5vye9TWMZxod4t91WK4UkafQpShE0L3e3GL9D5iIjVA8Kb+xtGCSRMT4M/G
	dl9FSlDV5oqOuBFVzoZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw42z-0003m3-AD; Tue, 19 Feb 2019 11:58:49 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw42x-0003lu-7L
 for linux-arm-kernel@bombadil.infradead.org; Tue, 19 Feb 2019 11:58:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=063b44LnIli6UeiU3wWvish88zFP5Ns8Dmd2qWXtsD4=; b=oBaqha41N6526htEcKVMXn6cz
 fWMi0W2rm6slY4Uhkd8XZdaMNmzRg0sQ+J7u0EMImV5MYD9SROimDtR1AweEuAPgIFwBurR1NVU7/
 ySPCTdG2/HfDfkO76hqmHpOqroqzslUkPk3pmZl0vpXuXmKuT0ZznZVCe7QWSaKK4Cecrzg6VCV4F
 wgwDj5y7V3ez5gySFyzPnvL0XZzMVBLejaGDYKLuG3X0RfKIsdp7U1REw2D8H37aYggNrhw0pzctR
 WL36Y3xO5d8p45IWRIDVrPjoQ1DroLy0Dxpug5SOgJLKqP0qTDcwJsASGswhh82mJGxdSTCAMi3tC
 /X8z1JoNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw42s-0001cF-C0; Tue, 19 Feb 2019 11:58:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 10598201A577B; Tue, 19 Feb 2019 12:58:40 +0100 (CET)
Date: Tue, 19 Feb 2019 12:58:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190219115840.GV32477@hirez.programming.kicks-ass.net>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219094438.GV32534@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902191238250.1644@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902191238250.1644@nanos.tec.linutronix.de>
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
Cc: jpoimboe@redhat.com, dvlasenk@redhat.com, brgerst@gmail.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 valentin.schneider@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 mingo@redhat.com, james.morse@arm.com, luto@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, bp@alien8.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 12:38:42PM +0100, Thomas Gleixner wrote:
> On Tue, 19 Feb 2019, Peter Zijlstra wrote:
> 
> > On Tue, Feb 19, 2019 at 10:04:09AM +0100, Peter Zijlstra wrote:
> > > > Does that make more sense?
> > > 
> > > It appears to me you're going about it backwards.
> > 
> > So how about you do a GCC plugin that verifies limits on code-gen
> > between user_access_begin/user_access_end() ?
> > 
> >  - No CALL/RET
> >    - implies user_access_end() happens
> >    - implies no fentry hooks
> >  - No __preempt_count frobbing
> >  - No tracepoints
> >  - ...
> > 
> > That way you put the burden on the special code, not on the rest of the
> > kernel.
> 
> And then you have kprobes ....

They prod the INT3 byte and then take an exception, and exceptions are
'fine'.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
