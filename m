From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 03 Dec 2012 14:27:49 -0500 (EST)
Subject: [PATCH 2/3] ARM: nommu: prevent generation of kernel unaligned
 memory accesses
In-Reply-To: <50BCF589.4010509@gmail.com>
References: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
 <1354557403-20386-2-git-send-email-will.deacon@arm.com>
 <50BCF589.4010509@gmail.com>
Message-ID: <alpine.LFD.2.02.1212031427270.6589@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Dec 2012, Rob Herring wrote:

> On 12/03/2012 11:56 AM, Will Deacon wrote:
> > Recent ARMv7 toolchains assume that unaligned memory accesses will not
> > fault and will instead be handled by the processor.
> > 
> > For the nommu case (without an MPU), memory will be treated as
> > strongly-ordered and therefore unaligned accesses may fault regardless
> > of the SCTLR.A setting.
> > 
> > This patch passes -mno-unaligned-access to GCC when compiling for nommu
> > targets, preventing the generation of unaligned memory access in the
> > kernel.
> 
> BTW, this option will not fully prevent unaligned accesses. This code
> will still generate unaligned accesses:
> 
> void func(void)
> {
> 	char array[] = { 1, 2, 3 };
> }

Isn't that a gcc bug?


Nicolas
