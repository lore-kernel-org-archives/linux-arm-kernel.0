Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53023C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:30:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D47222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="deCOm2SC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xEtjjyJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D47222DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uYhYmxvF4cTA1XD4c+EaASJZVGKHsLOxOpkXfstAlzs=; b=deCOm2SCCzso2c
	/zclN18Nb/KuFOmzLsKLICwLlkaZEP9PagoNcNpmQIC4skeJfQgYkXoxACLeEg2pYxzMrkAV4PkiV
	L5zNIxri4SXTbIj1fZk9FGxmetveAv6nuQ4mdst/gcCs1cHyGXEw/KNcs25LDOohglwMO4thWtAiQ
	SwJjnrIIaK0vfPq3aEDvPZV9s7ugcxPneaAmV6kBZm1LyuDvk8a9U0X3bRSsSR4/1uIMOgSTi2Lbo
	ODKnvc/+JmlqPFGqtu7quRve6zFiFgL1hsF79nSCAyCzY1C6MvvQt58p9gMC9hrjgmDaswsM7Y1+o
	bbx0bEer8x4/+X9d1QMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guxFG-0003wB-N8; Sat, 16 Feb 2019 10:30:54 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guxFE-0003w4-QN
 for linux-arm-kernel@bombadil.infradead.org; Sat, 16 Feb 2019 10:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=myhR7JERoDfu2IeT6NVXGFHfmgtZTqs8HmBqII9TuUE=; b=xEtjjyJkguuIDY05HA33PEPdD
 2DY65orj8zOSvYITfGFVpDndP94CdragUz1DBQKTorMAUGwmX/fu1SNVVKys656f4VZf3gqGtfjyz
 TfBRgwf/oscnScF2fbYkpsQIsCVVhZMw3JaxLzOaRtBifPxP7yT48Mkvurt6Vqskki/RCjZfdGvYm
 gxoyQX5zgKDp0UbRd38/dtJVt9R6FxWIde+x49kgNdIZGcjFwYNNqU5YhPfgt26Us1IA0OlwnEPpT
 XrIh2AvcGVdFfuynmLoMRK00VvRY4yfPtemycBoLlrIlMWtCn7xF5mGFM63CMn2tkxA2kDgTnsQpr
 g7qtFLEsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guxF9-0001vD-EP; Sat, 16 Feb 2019 10:30:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id D712323E8CC39; Sat, 16 Feb 2019 11:30:44 +0100 (CET)
Date: Sat, 16 Feb 2019 11:30:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: hpa@zytor.com
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190216103044.GR32494@hirez.programming.kicks-ass.net>
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
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
Cc: dvlasenk@redhat.com, jpoimboe@redhat.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 valentin.schneider@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 mingo@redhat.com, james.morse@arm.com, luto@kernel.org, brgerst@gmail.com,
 bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 08:06:56PM -0800, hpa@zytor.com wrote:
> This implies we invoke schedule -- a restricted operation (consider
> may_sleep) during execution of STAC-enabled code, but *not* as an
> exception or interrupt, since those preserve the flags.

Meet preempt_enable().

> I have serious concerns about this. This is more or less saying that
> we have left an unlimited gap and have had AC escape.

Yes; by allowing normal C in between STAC and CLAC this is so.

> Does *anyone* see a need to allow this? I got a question at LPC from
> someone about this, and what they were trying to do once all the
> layers had been unwound was so far down the wrong track for a root
> problem that actually has a very simple solution.

Have you read the rest of the thread?

All it takes for this to explode is a call to a C function that has
tracing on it in between the user_access_begin() and user_access_end()
things. That is a _very_ easy thing to do.

Heck, GCC is allowed to generate that broken code compiling
lib/strnlen_user.c; it doesn't _have_ to inline do_strnlen_user (esp.
with CONFIG_OPTIMIZE_INLINING), and making that a function call would
get us fentry hooks and ftrace and *BOOM*.

(Now, of course, its a static function with a single caller, and GCC
isn't _THAT_ stupid, but it could, if it wanted to)

Since the bar is _that_ low for mistakes, I figure we'd better fix it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
