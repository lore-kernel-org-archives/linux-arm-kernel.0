From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Oct 2012 09:01:23 -0700
Subject: [PATCH] Add FDT support to Pandaboard initialization
In-Reply-To: <20121029061427.GP17570@arwen.pp.htv.fi>
References: <1351363800-28744-1-git-send-email-const@MakeLinux.com>
 <20121029061427.GP17570@arwen.pp.htv.fi>
Message-ID: <20121029160122.GB11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [121028 23:22]:
> On Sat, Oct 27, 2012 at 08:50:00PM +0200, Constantine Shulyupin wrote:
> > From: Constantine Shulyupin <const@MakeLinux.com>
> > 
> > Problem:
> > - FDT is supported only by generic OMAP board initialization in arch/arm/mach-omap2/board-generic.c and lacks some configurations, which are not yet configured in FDT (USB for example).
> > Solution:
> > - arch/arm/mach-omap2/board-omap4panda.c supports initialization with FDT and without it.
> > 
> > Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> 
> NAK, the whole idea of DT is to drop board-*.c. It would be best to see
> the "missing initialization" being added to board-generic/dts files.

Yes I agree, let's rather get board-generic.c to work with panda.

The other board-*.c files will be dropped as soon as we have
things usable with devicetree. And we're only two board-*.c files
away from making omap4 device tree only ;)

I think we are only missing DSS, USB and WLAN bindings to
have blaze and panda usable with device tree to the point
where everything else can be added later on.

Regards,

Tony
