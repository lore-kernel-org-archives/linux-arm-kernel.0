From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 13 Jul 2010 09:42:55 +0800
Subject: [RFC,PATCH 2/2] arm: use addruart macro to establish debug
	mappings
In-Reply-To: <20100712135259.GC6577@n2100.arm.linux.org.uk>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<1278903792.388155.428219242752.2.gpush@pororo>
	<20100712135259.GC6577@n2100.arm.linux.org.uk>
Message-ID: <1278985375.2521.6.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> This is insufficient.  We are setting up section mappings here, which
> must have both the physical and virtual addresses aligned to a megabyte
> boundary.  You're aligning the virtual address but doing nothing with
> the physical one.

Ah, I didn't look at the descriptor setup code closely enough. Will do
the proper masking in the next series.

> I also agree with Nicolas - if we're going to do this, we want addruart
> to return the virtual and physical addresses in two separate registers,
> and then have the debug code select the appropriate one itself.  That
> will simply this code.
> 
> So I suggest:
> 
> Patch #1 - re-jig addruart to return both virtual and physical addresses.
> Patch #2 - implement setup of debug mapping using addruart.
> Patch #3 - remove phys_io and pgoffio from machine_desc.
> 
> I'd also suggest that the patches are against a recent kernel, esp.
> patch #3 as there's been some changes recently in some of the
> initializers.

Yep, sounds like a good approach. Patches coming...

Cheers,


Jeremy
