From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 08:23:36 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B85C4A4.4060005@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
Message-ID: <20100225082336.GA30605@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 01:30:28AM +0100, Hector Martin wrote:
> Russell King - ARM Linux wrote:
> > On Thu, Feb 25, 2010 at 12:57:20AM +0100, Hector Martin wrote:
> >> Russell King - ARM Linux wrote:
> >>> On Wed, Feb 24, 2010 at 06:34:49PM -0500, Nicolas Pitre wrote:
> >>>> What about simply not compiling the decompressor with -fPIC when using 
> >>>> ZBOOT_ROM=y?  That would certainly solve the problem with the only 
> >>>> restriction that such kernel images won't be bootable from RAM which is 
> >>>> probably an acceptable compromize.
> >>> Unfortunately, that doesn't solve the stack-bashing with ZBOOT_ROM=n.
> >> Yes it does, that's exactly what my first version of the patch did. Once
> >> you get rid of the partial relocation used for ROM builds (with split
> >> text/bss) you don't need -Dstatic=, and once you get rid of that you
> >> solve the stack-bashing. The ROM build becomes a bog standard
> >> non-relocatable ROM image (with the usual LMA/VMA linker script stuff to
> >> copy initialized data to RAM), and the RAM build becomes a bog standard
> >> relocatable image (a single contiguous blob including
> >> text/rodata/data/bss) that doesn't suffer from any issues when you move
> >> it around.
> > 
> > Did you bother to read my previous reply explaining that this is not
> > a hack for the toolchain?  It sounds to me like you didn't.
> 
> Are you new to C? It looks like you are seriously still claiming that
> -Dstatic= is A-OK under all circumstances. It very obviously isn't.

Clearly you didn't (a) read my mail and (b) understand it.

And if you're going to be that insulting, I see no point discussing
this further with you.
