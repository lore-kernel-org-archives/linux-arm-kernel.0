From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 May 2014 22:09:48 +0200
Subject: [PATCH] ARM: remove ARM710 specific assembler code
In-Reply-To: <20140520160512.GE27830@atomide.com>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <5053472.zFAHKQVpbv@wuerfel> <20140520160512.GE27830@atomide.com>
Message-ID: <4437236.32BrGIk46D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 May 2014 09:05:13 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [140519 04:27]:
> > On Saturday 17 May 2014 10:56:02 Catalin Marinas wrote:
> > 
> > For the case of ARM710T, I think the last remaining user that can be
> > configured is mach-integrator, but I don't know if anybody even has that
> > CPU tile, or wants to keep using it. If Russell and Linus as the only
> > people that have cared about Integrator in the past years want to
> > cut down the number of supported CPUs, that would be a different matter:
> > quite a number of CPUs are not supported in any other platform.
> > Note that the integrator target in qemu does not support any ARM7, only
> > StrongARM, ARM9 or later. I also double-checked about mach-clps711x,
> > but I'm pretty sure those SoCs are all either ARM710a (no longer supported)
> > or ARM720T (quite active).
> 
> Hmm I don't think mach-integrator is using ARM710T?

I don't know, we don't have a separate Kconfig option, so ARM710T and ARM720T
use the same CONFIG_CPU_ARM720T symbol that can be enabled for integrator.
Without any further information, I assumed that both might potentially be used.

> The ARM710T was done by NEC and was used by the Psion MX hardware.
> It's very close to ARM720T as far as I remember so might as well keep
> the CPU support for it as that's just a few lines of code in the
> mainline kernel.
> 
> I don't think we have any mach directories using ARM710T, but I
> would not be surprised if somebody comes along with device tree
> based booting patches for Psion MX at some point.

Of course, if someone does this, the CPU support would be the least
of their work ;-)

Just out of curiosity: was that NEC 710T a SoC that replaced the
CL/PS7110, or a standalone CPU that Psion combined with a custom
ASIC?

	Arnd
