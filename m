From: schen@mvista.com (Steve Chen)
Date: Thu, 3 Feb 2011 08:31:04 -0600
Subject: "Porting the Linux Kernel to a New ARM Platform", updated...?
In-Reply-To: <87a7d0$e7q8m3@out1.ip07ir2.opaltelecom.net>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
	<20110127073009.GR9041@pengutronix.de>
	<20110127093044.GA30756@shlinux1.ap.freescale.net>
	<4D415BA2.2020207@freescale.com>
	<20110127121928.GA1948@richard-laptop>
	<87a7d0$e7q8m3@out1.ip07ir2.opaltelecom.net>
Message-ID: <AANLkTikWsU2V+1ohAaiFfRneLjsGRWx7ee5X655mAa18@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 6:58 AM, Nick Pelling <nickpelling@nanodome.com> wrote:
> Hi everyone,
>
> I've been looking for a good source of information on getting Linux working
> on a new ARM target, including a checklist of things to cover such as
> putc(), arch_decomp_setup(), etc. So far, pretty much the best source of
> information I've found is Wookey & Tak-Shing's "Porting the Linux Kernel to
> a New ARM Platform"...
> ? ? ? ?http://www.glomationinc.com/PortingLinuxKernel.pdf
> ...but I can't help but notice that this is from 2002.
>
> Is there an updated version of this document (or perhaps a book chapter
> covering this) you would recommend?
>
> Cheers, ....Nick Pelling....

Hello,

I took a quick look at the document.  Much of the information still
applies to the latest kernel.  The biggest change that I can see is
that the directories were moved and files renames.  For example

arch/arm/deconfigs/ is now arch/arm/configs
config.in is now Kconfig
include/asm-arm/arch-xxx is moved to arch/arm/mach-xxx/include

By the way, include/asm is a symlink points to
include/asm-arm/arch-xxxx in the older kernels.  The link is created
by the make.  If I were to get Linux to boot on a new board, I would
start by looking at code for a similar target with the same SoC.

I hope that helps.

Steve
