From: Oskar.Andero@sonyericsson.com (=?iso-8859-1?Q?=22Ander=F6=2C_Oskar=22?=)
Date: Tue, 19 Apr 2011 16:41:07 +0200
Subject: [PATCH] arm: omap2: enable smc instruction for sleep34xx
In-Reply-To: <20110419102852.GA30588@arm.com>
References: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
	<00D61D20F3A8774CBC77798B3FBC427082058F986D@seldmbx02.corpusers.net>
	<loom.20110419T100624-335@post.gmane.org>
	<20110419092014.GA2267@arm.com>
	<00D61D20F3A8774CBC77798B3FBC427082058F9871@seldmbx02.corpusers.net>
	<20110419102852.GA30588@arm.com>
Message-ID: <00D61D20F3A8774CBC77798B3FBC427082058F9872@seldmbx02.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Apr 19, 2011 at 12:13:26PM +0200, "Ander?, Oskar" wrote:
> > > > > Ping!
> > > > >
> > > > > Anyone else that gets bitten by the following when compiling
> > > > omap2plus_defconfig with gcc 4.5:
> > > > > arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor
> does
> > > not
> > > > support ARM mode `smc #1'
> > > > >
> > > > > -Oskar
> > > > >
> > > >
> > > > I can report that I get the exact same compile error as this.
> > > > OP patch worked beautifully.
> > > >
> > > > -Alex
> > >
> > > Can you check what options are being passed to the compiler
> > > and the assembler, and check for .arch / .arch_extension directives
> > > in the assembler input?
> > >
> > > i.e.,
> > >
> > > make V=1 CFLAGS_KERNEL='-v -save-temps' arch/arm/mach-
> omap2/sleep34xx.o
> > >
> > > ...and look at the output and the generated sleep34xx.s
> > >
> > > Maybe the options being passed to the compiler/assembler are wrong
> > > somewhere along the line.
> > Yes, the "+sec" extension of armv7-a (i.e. -march=armv7-a+sec) is
> missing and hence the smc instruction can't be used. This is what my
> patch fixes. I guess earlier versions of binutils silently ignored this.
> >
> > It's not visible in my patch, but plus_sec is declared as:
> > plus_sec := $(call as-instr,.arch_extension sec,+sec)
> 
> Ah right, I was slightly confused by the context.
> 
> You're right -- sleep34xx.S also needs this change in the Makefile,
> as per your patch.  This isn't new; the original patch focused on
> omap4, so I guess this file was just missed.
I will soon resubmit the patch (v2) with a slightly more correct git comment. Please, feel free to review it or ack it. ;)

-Oskar
