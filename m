Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EEFC0044B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:19:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C8321872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mYUCJ2yc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fftl5pJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C8321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vY+wKZ1UmWiY1y/D5y7mqOQmaSwbqUwN5eoPkUA7Tm0=; b=mYUCJ2ycC+tNpk
	L4FcrCSQt+qXziXp3qcEq7bhxL3EBp4nKqNbH/DBtwDFElPGUfyCdyassJGDEM68ayGvZGU2N+vPY
	Xs9XpJU979/gZeq6VHx3aeqcbkBROu6GUeqx2YO4Qmz6QH/EZrKIfoqIUap9dodZEoTMZhgXvinta
	52cQnTbCVvIFOe0/15tltEsGl/fsNAeT+2lfIv2vm4++MPZAQO02/TLMwOIydA3zcmSSJic8H4fYo
	OZLDR9qGCsKhBCweNbndNiybqVx40D3qJE89em2bgcoY2oSJ4Msddef7eMPUEnhZUB4clLmW1Jqqb
	4jwJpcUtw3g4mVlGLM/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu1wP-0004EA-LO; Wed, 13 Feb 2019 21:19:37 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu1wL-0004Dh-RM
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:19:36 +0000
Received: by mail-vs1-xe43.google.com with SMTP id e16so2327222vsq.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pZbmU7dD1o3OwXDtvUj3R22GSVn8M9oli7ukUv49OTs=;
 b=fftl5pJYXJ5VP/+J1i1XN/GoxZo+MkeHQO4Qar1dZh0ELM0mOBOODKfvz0D7NeYfq3
 FskY5aUnWrI6ArNn73R3sOmdSDyhkH6Spa2EsJuJRmDIjrW4ZunwYOQRb0z21Z/IN6dW
 BjPGXbcckLb6aI74RD9cSuF8nJThIj7i+riVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pZbmU7dD1o3OwXDtvUj3R22GSVn8M9oli7ukUv49OTs=;
 b=FB++rIUmttMXpkL4yHRNoZ+Aw2rxc0iWOFOwgKDrKJbLY895MOamRq4cnWmCs7EI2b
 otqrMPBxwiKdwlDA6cqzT5IdIvS+8XkOXF6BYjq8tvI7lKK7cEhk5u76dqGnOzhqYcj/
 zIyEGd6NVUQ/DaWNauiPPWkYEHbBZcnPoTcJedh1/jwW4LspOeNZTrVPuSbDXLdcUFsf
 L30P63E2biPgXV6kCHgChecPfhEpz72EVe8sP3RgrB+1krfnBFtx4BZ+g/LYjOP5QN4y
 DRqZ5DKQ1t8LN6UIVP/3OWAIk+ajb2m9F+Pv8hdSZIDnWrOyhsCWf767iwCXlenjwM9G
 X0/Q==
X-Gm-Message-State: AHQUAuYlqfSk4AHZQiPv5r45uXLqaJ17C/vW8eeomI6OdywNpN0KCOPz
 mXbdK8uYVmlopN6zM6tOKJn2U8kTWco=
X-Google-Smtp-Source: AHgI3Ib/SJuIt+RtvZpGapRtxY6S4m+bnPxTriJ2667zXlLnohRuwaUkSl6lC8rn3xs5dUW/nGn1uw==
X-Received: by 2002:a67:f997:: with SMTP id b23mr121271vsq.41.1550092771735;
 Wed, 13 Feb 2019 13:19:31 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44])
 by smtp.gmail.com with ESMTPSA id x132sm97271vke.52.2019.02.13.13.19.30
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 13:19:31 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id z24so1283872ual.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:19:30 -0800 (PST)
X-Received: by 2002:ab0:70b7:: with SMTP id q23mr118302ual.15.1550092770406;
 Wed, 13 Feb 2019 13:19:30 -0800 (PST)
MIME-Version: 1.0
References: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
 <20190204123130.GE3567@e103592.cambridge.arm.com>
 <CAD=FV=U_wfuU9zYSeu+JNrMts0Y1mf8Usvb7P_wCzgVNy0AUhQ@mail.gmail.com>
 <20190211195750.GI3567@e103592.cambridge.arm.com>
In-Reply-To: <20190211195750.GI3567@e103592.cambridge.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 13 Feb 2019 13:19:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V6mPHUBGn6u5v4=D_DBxrtj_MAyfHk+TOnbCRNNokYJQ@mail.gmail.com>
Message-ID: <CAD=FV=V6mPHUBGn6u5v4=D_DBxrtj_MAyfHk+TOnbCRNNokYJQ@mail.gmail.com>
Subject: Re: Possible to annotate ARM64 IRQ handling to help gdb?
To: Dave Martin <Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_131933_942842_195FBEB0 
X-CRM114-Status: GOOD (  42.43  )
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

Hi,

On Mon, Feb 11, 2019 at 11:58 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Feb 11, 2019 at 09:27:11AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Feb 4, 2019 at 4:31 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > >
> > > On Fri, Feb 01, 2019 at 01:38:05PM -0800, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > I was wondering if anyone out there has given any thought to
> > > > annotating the ARM64 IRQ handling in such a way that we could stack
> > > > crawl past el1_irq() when in gdb.
> > > >
> > > > I spent a bit of time on this a few months ago and documented all my
> > > > findings in:
> > > >
> > > > https://bugs.chromium.org/p/chromium/issues/detail?id=908721
> > > >
> > > > I can copy and paste all the discussion from that bug here, but since
> > > > it's public hopefully folks can read the discussion / investigation
> > > > there.  To put it briefly, though: I can stack crawl past "el1_irq"
> > > > with the normal linux stack crawl (which is what kdb uses) but I can't
> > > > crawl past "el1_irq" in gdb().  After talking to some of our tools
> > > > guys here I'm fairly certain that we could solve this with the right
> > > > CFI directives, but when I poked at it I wasn't able to figure out the
> > > > magic.
> > > >
> > > >
> > > > Anyway, I figured I'd check to see if anyone here happens to know the
> > > > right magic.
> > >
> > > The kernel (appears to) generate a valid frame record for el1_irq:
> > >
> > >    0xffffff8008082b94 <+84>:    mrs     x22, elr_el1
> > >
> > >         [...]
> > >
> > >    0xffffff8008082ba0 <+96>:    stp     x29, x22, [sp, #304]
> > >    0xffffff8008082ba4 <+100>:   add     x29, sp, #0x130
> > >
> > > (I note that 0x130 == 304.  Yay binutils.)
> >
> > Right, this is how the kernel is able to do the crawl.  It's also why
> > I was able to manually do the crawl in the bug by chaining together
> > frame pointers.
> >
> >
> > > From the bug report, I don't see any real investigation into what
> > > precisely causes gdb to choke on this frame.
> >
> > Right.  I just don't know gdb well enough.  :(  I've had it on my list
> > to dig into it, but I need to find time.  ;-)
> >
> >
> > > Do you have evidence that CFI annotations help in this case?  And can
> > > you explain _why_ they help (i.e., precisely how is gdb relying on the
> > > annotations)?
> >
> > I spent a tiny bit of time playing around with CFI annotations.
> > Mostly it was stumbling around in the dark since I had a hard time
> > finding good arm/arm64 examples and the documentation was a little
> > hard for me to parse.
>
> You could try compiling a few simple C functions with gcc -S
> -fexceptions and see what the compiler spits out.

Thanks, this definitely helped!


> > ...but from my experience with gdb, my guess is that gdb wants more
> > than just the simple frame pointers.  It wants to know where _all_ the
> > registers are stored on the stack and the only way it's going to get
> > that from assembly code (especially assembly code that barfed the
> > registers onto the stack somewhere that's not between FUNC and
> > ENDFUNC) is with some type of annotation.  My guess is that it doesn't
> > fall back to just looking at frame pointer chains.  Specifically as
> > you move up the stack frame in gdb and you type "info reg", the set of
> > registers changes to be those registers that are correct for the stack
> > frame you're on.  Here's a quick example showing how gdb behaves with
> > a random register that was barfed, $x22:
> >
> > (gdb) frame 3
> > #3  0xffffff800846a088 in __handle_sysrq (key=103,
> > check_mask=<optimized out>) at .../drivers/tty/sysrq.c:620
> > 620                             op_p->handler(key);
> >
> > (gdb) disass
> > Dump of assembler code for function __handle_sysrq:
> >    0xffffff8008469f64 <+0>:     str     x23, [sp, #-64]!
> >    0xffffff8008469f68 <+4>:     stp     x22, x21, [sp, #16]
> >    0xffffff8008469f6c <+8>:     stp     x20, x19, [sp, #32]
> >    0xffffff8008469f70 <+12>:    stp     x29, x30, [sp, #48]
> >    0xffffff8008469f74 <+16>:    add     x29, sp, #0x30
> >
> > (gdb) print /x $x22
> > $13 = 0xffffff8009035000
> >
> > (gdb) print /x *(void**)($x29 - 0x30 + 16)
> > $14 = 0x8000100
> >
> > (gdb) up
> > #4  0xffffff800846a0dc in handle_sysrq (key=103) at .../drivers/tty/sysrq.c:649
> > 649                     __handle_sysrq(key, true);
> >
> > (gdb) print /x $x22
> > $15 = 0x8000100
>
>
> Indeed, but this requires full DWARF or .eh_frame info, which is not
> generally available in the kernel.

Yup, but I have it for gdb and right now the problem I'm trying to
solve is being able to crawl in gdb since the kernel seems to be OK.
I guess I was thinking that perhaps the DWARF info could be confusing
gdb?



> Except for code built with -fomit-frame-pointer, you should at least
> be able to see a list of frames though: this doesn't require all the
> registers of ancestor frames to be recovered, just x29 and lr (which is
> what the frame records on the stack contain -- so no other magic info
> is required in order to recover these).
>
> gdb tries various methods to unwind a frame, and ought to fall back to
> this approach if all else fails.  Frame chains that appear to loop
> are a problem though, with no straightforward solution.
>
> My hunch is that gdb sees the frame chain attempt to loop backwards
> after el1_irq and bails out.  Is your task stack at a lower address than
> the IRQ stack?

Here's what I've got (not lower)

#16 0xffffff8008082bf0 in el1_irq () at
/mnt/host/source/src/third_party/kernel/v4.19/arch/arm64/kernel/entry.S:622
622             irq_handler

(gdb) print /x $sp
$11 = 0xffffff8008004000
(gdb) print /x $x29
$12 = 0xffffff8009003e90
(gdb) print /x ((void**)$x29)[0]
$13 = 0xffffff8009003ed0
(gdb) print /x (*(void***)$x29)[0]
$14 = 0xffffff8009003ee0


...but then I poked a bit more and found out one really big problem is
this that "irq_stack_entry" swaps the stack before calling
gic_handle_irq() and this seemed to be confusing gdb.  Specifically
the value of "sp" when I point gdb at the "el1_irq" frame is actually
"irq_stack_ptr" AKA 0xffffff8008004000.


I've been fighting a bit with trying to figure out how to make .cfi
directives do what I want and I managed a stupid/ugly hack that at
least seems to get my stack pointer to be correct in el1_irq now:

---

 static asmlinkage void __exception_irq_entry gic_handle_irq(struct
pt_regs *regs)
 {
        u32 irqnr;
+       asm volatile (".cfi_register 31, 19");

---

...when I do that then my stack pointer sane which I point at el1_irq
(it matches x19), but I still can't get a trace.  I also haven't yet
been able to figure out how to accomplish that without hacking it into
gic_handle_irq().


While it would be nice to get all this solved, it's probably not high
priority right now, so I might have to punt unless there's some other
obvious / low hanging fruit to try.


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
