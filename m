From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 11:55:19 +0100
Subject: [PATCH 5/6] arm/ns9xxx: fix debug macro compilation failure
In-Reply-To: <AANLkTilzEDKnO5GdFMedF9kq3vZboT6dcywCuz6YEsdE@mail.gmail.com>
References: <1279074759.517724.734812272398.0.gpush@pororo>
	<1279074759.519643.866429356172.5.gpush@pororo>
	<20100722103834.GH31293@n2100.arm.linux.org.uk>
	<AANLkTilzEDKnO5GdFMedF9kq3vZboT6dcywCuz6YEsdE@mail.gmail.com>
Message-ID: <20100722105519.GJ31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:50:28PM +0200, Eric Miao wrote:
> On Thu, Jul 22, 2010 at 12:38 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Jul 14, 2010 at 10:32:39AM +0800, Jeremy Kerr wrote:
> >> We need mach/memory.h for NS9XXX_CSxSTAT_PHYS, and mach/memory.h needs
> >> asm/memory.h for UL().
> >
> > NAK. ?Definitely NAK. ?You haven't checked what includes whatelse.
> >
> > asm/memory.h includes mach/memory.h to pick up the platform specific
> > parts, and provides mach/memory.h with its pre-requisits. ?Use asm/memory.h
> > _everywhere_ rather than mach/memory.h.
> >
> 
> I think it would be just fine to encode PHYS_OFFSET as 0xNNNNNNNNUL
> instead of using UL() if there is no specific reason. So we don't need
> to include asm/memory.h any more in machine specific code.

No it's not.  0xNNNNNNNNUL isn't able to be parsed by the assembler.
That's the whole reason for UL() existing.
