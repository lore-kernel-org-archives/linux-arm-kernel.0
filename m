Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B445C218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tHfj3wH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B445C218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tlcod+f/PJn/lJMjkV2twR2uNxI+a3r6gLIfgFBRpzU=; b=tHfj3wH09PIwud
	rKzLXbbZfbDgrJWSf6RIGga/2lxmn+wMPiAEIycKstg4JnIerb5eDjfL6Y/ojhmIfRbBlWsafVzDg
	5KgLyzE6gwW4Ynqt28eUfcLL2W86pjzgOhOZT9HhXmGItPRIQC1NjIY1beaWduqcC4yGAe/zCxTZo
	12DVUCdOwBMEQoq5UIdZdCnN4Aw1GMtEhV0G4KTkUzjQjuDayN1iUvANnmpZefqm0zlPtwUOo5eUk
	rDo20yEKvFQiI5M6m2Y4DYQdmpIak1gN91RcVid+jm+RCG/mvtWemOiuPD5ca6sFX/u08i95cG8Tm
	HoCPhofgf9yBkgAGlvlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtHiK-0005QR-Qy; Mon, 11 Feb 2019 19:58:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtHiH-0005HQ-Rr
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 19:57:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0B8580D;
 Mon, 11 Feb 2019 11:57:56 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C9CA3F557;
 Mon, 11 Feb 2019 11:57:55 -0800 (PST)
Date: Mon, 11 Feb 2019 19:57:53 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: Possible to annotate ARM64 IRQ handling to help gdb?
Message-ID: <20190211195750.GI3567@e103592.cambridge.arm.com>
References: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
 <20190204123130.GE3567@e103592.cambridge.arm.com>
 <CAD=FV=U_wfuU9zYSeu+JNrMts0Y1mf8Usvb7P_wCzgVNy0AUhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=U_wfuU9zYSeu+JNrMts0Y1mf8Usvb7P_wCzgVNy0AUhQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_115757_914714_84A864BC 
X-CRM114-Status: GOOD (  35.13  )
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
Cc: Caroline Tice <cmtice@chromium.org>, kgdb-bugreport@lists.sourceforge.net,
 Will Deacon <will.deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 09:27:11AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Feb 4, 2019 at 4:31 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Fri, Feb 01, 2019 at 01:38:05PM -0800, Doug Anderson wrote:
> > > Hi,
> > >
> > > I was wondering if anyone out there has given any thought to
> > > annotating the ARM64 IRQ handling in such a way that we could stack
> > > crawl past el1_irq() when in gdb.
> > >
> > > I spent a bit of time on this a few months ago and documented all my
> > > findings in:
> > >
> > > https://bugs.chromium.org/p/chromium/issues/detail?id=908721
> > >
> > > I can copy and paste all the discussion from that bug here, but since
> > > it's public hopefully folks can read the discussion / investigation
> > > there.  To put it briefly, though: I can stack crawl past "el1_irq"
> > > with the normal linux stack crawl (which is what kdb uses) but I can't
> > > crawl past "el1_irq" in gdb().  After talking to some of our tools
> > > guys here I'm fairly certain that we could solve this with the right
> > > CFI directives, but when I poked at it I wasn't able to figure out the
> > > magic.
> > >
> > >
> > > Anyway, I figured I'd check to see if anyone here happens to know the
> > > right magic.
> >
> > The kernel (appears to) generate a valid frame record for el1_irq:
> >
> >    0xffffff8008082b94 <+84>:    mrs     x22, elr_el1
> >
> >         [...]
> >
> >    0xffffff8008082ba0 <+96>:    stp     x29, x22, [sp, #304]
> >    0xffffff8008082ba4 <+100>:   add     x29, sp, #0x130
> >
> > (I note that 0x130 == 304.  Yay binutils.)
> 
> Right, this is how the kernel is able to do the crawl.  It's also why
> I was able to manually do the crawl in the bug by chaining together
> frame pointers.
> 
> 
> > From the bug report, I don't see any real investigation into what
> > precisely causes gdb to choke on this frame.
> 
> Right.  I just don't know gdb well enough.  :(  I've had it on my list
> to dig into it, but I need to find time.  ;-)
> 
> 
> > Do you have evidence that CFI annotations help in this case?  And can
> > you explain _why_ they help (i.e., precisely how is gdb relying on the
> > annotations)?
> 
> I spent a tiny bit of time playing around with CFI annotations.
> Mostly it was stumbling around in the dark since I had a hard time
> finding good arm/arm64 examples and the documentation was a little
> hard for me to parse.

You could try compiling a few simple C functions with gcc -S
-fexceptions and see what the compiler spits out.

> ...but from my experience with gdb, my guess is that gdb wants more
> than just the simple frame pointers.  It wants to know where _all_ the
> registers are stored on the stack and the only way it's going to get
> that from assembly code (especially assembly code that barfed the
> registers onto the stack somewhere that's not between FUNC and
> ENDFUNC) is with some type of annotation.  My guess is that it doesn't
> fall back to just looking at frame pointer chains.  Specifically as
> you move up the stack frame in gdb and you type "info reg", the set of
> registers changes to be those registers that are correct for the stack
> frame you're on.  Here's a quick example showing how gdb behaves with
> a random register that was barfed, $x22:
> 
> (gdb) frame 3
> #3  0xffffff800846a088 in __handle_sysrq (key=103,
> check_mask=<optimized out>) at .../drivers/tty/sysrq.c:620
> 620                             op_p->handler(key);
> 
> (gdb) disass
> Dump of assembler code for function __handle_sysrq:
>    0xffffff8008469f64 <+0>:     str     x23, [sp, #-64]!
>    0xffffff8008469f68 <+4>:     stp     x22, x21, [sp, #16]
>    0xffffff8008469f6c <+8>:     stp     x20, x19, [sp, #32]
>    0xffffff8008469f70 <+12>:    stp     x29, x30, [sp, #48]
>    0xffffff8008469f74 <+16>:    add     x29, sp, #0x30
> 
> (gdb) print /x $x22
> $13 = 0xffffff8009035000
> 
> (gdb) print /x *(void**)($x29 - 0x30 + 16)
> $14 = 0x8000100
> 
> (gdb) up
> #4  0xffffff800846a0dc in handle_sysrq (key=103) at .../drivers/tty/sysrq.c:649
> 649                     __handle_sysrq(key, true);
> 
> (gdb) print /x $x22
> $15 = 0x8000100


Indeed, but this requires full DWARF or .eh_frame info, which is not
generally available in the kernel.

Except for code built with -fomit-frame-pointer, you should at least
be able to see a list of frames though: this doesn't require all the
registers of ancestor frames to be recovered, just x29 and lr (which is
what the frame records on the stack contain -- so no other magic info
is required in order to recover these).

gdb tries various methods to unwind a frame, and ought to fall back to
this approach if all else fails.  Frame chains that appear to loop
are a problem though, with no straightforward solution.

My hunch is that gdb sees the frame chain attempt to loop backwards
after el1_irq and bails out.  Is your task stack at a lower address than
the IRQ stack?

In the kernel we gave up attempting to fully detect backtrace loops
because of this issue, but this involves some cruddy heuristics which
may not be considered acceptable for gdb.  For one thing, our rules are
specific for the kernel, not general-purpose.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
