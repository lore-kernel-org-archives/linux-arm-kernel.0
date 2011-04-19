From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 19 Apr 2011 10:20:14 +0100
Subject: [PATCH] arm: omap2: enable smc instruction for sleep34xx
In-Reply-To: <loom.20110419T100624-335@post.gmane.org>
References: <1301581164-26538-1-git-send-email-oskar.andero@sonyericsson.com>
	<00D61D20F3A8774CBC77798B3FBC427082058F986D@seldmbx02.corpusers.net>
	<loom.20110419T100624-335@post.gmane.org>
Message-ID: <20110419092014.GA2267@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 08:18:37AM +0000, Alexander Stevens wrote:
> Ander?, Oskar <Oskar.Andero <at> sonyericsson.com> writes:
> 
> > 
> > Ping!
> > 
> > Anyone else that gets bitten by the following when compiling
> omap2plus_defconfig with gcc 4.5:
> > arch/arm/mach-omap2/sleep34xx.S:150: Error: selected processor does not
> support ARM mode `smc #1'
> > 
> > -Oskar
> > 
> 
> I can report that I get the exact same compile error as this.
> OP patch worked beautifully.
> 
> -Alex

Can you check what options are being passed to the compiler
and the assembler, and check for .arch / .arch_extension directives
in the assembler input?

i.e.,

make V=1 CFLAGS_KERNEL='-v -save-temps' arch/arm/mach-omap2/sleep34xx.o

...and look at the output and the generated sleep34xx.s

Maybe the options being passed to the compiler/assembler are wrong
somewhere along the line.

---Dave
