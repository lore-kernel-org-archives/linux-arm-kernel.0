From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Jan 2011 19:59:35 -0800
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101223210649.GT7771@atomide.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<20101223195503.GN7771@atomide.com>
	<20101223203046.GR3636@n2100.arm.linux.org.uk>
	<20101223210649.GT7771@atomide.com>
Message-ID: <20110107035935.GA880@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101223 13:12]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [101223 12:30]:
> > 
> > It's also queued for 2.6.38, but there is an issue with the latest gcc
> > stuffing a .armv7 directive (or whatever) at the beginning of its
> > output, thereby overriding the -Wa,-march=armv7-a on the command line.
> > I think someone's looking at fixing GCC.
> > 
> > This stuff _is_ in linux-next, and has been in linux-next for ages.
> 
> Yes, but that's a different patch :) Sorry I should have provided a link
> for the one I'm talking about, it's the patch that changes the options
> for SWP_EMULATE to have "depends on CPU_V7 && !CPU_V6":
> 
> http://marc.info/?l=linux-arm-kernel&m=128748874510144&w=2
> 
> That's still needed until we have the assembly in a separate .S file,
> or have the GCC options changed.

I'll queue Catalin's patch as I need it for omap2plus_defconfig to
build. Let me if you want to take it and I'll drop it.

Regards,

Tony
