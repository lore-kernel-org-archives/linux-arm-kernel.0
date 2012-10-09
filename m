From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 9 Oct 2012 13:52:50 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121008141455.324f914b@skate>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
 <20121008141455.324f914b@skate>
Message-ID: <20121009115250.GB28817@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 02:14:55PM +0200, Thomas Petazzoni wrote:
> 
> On Sun, 07 Oct 2012 03:53:01 +0200, Domenico Andreoli wrote:
> 
> > Index: b/arch/arm/mach-bcm476x/Makefile.boot
> > ===================================================================
> > --- /dev/null
> > +++ b/arch/arm/mach-bcm476x/Makefile.boot
> > @@ -0,0 +1,5 @@
> > +   zreladdr-y := 0x00008000
> > +params_phys-y := 0x00000100
> > +initrd_phys-y := 0x00800000
> 
> Those params_phys-y and initrd_phys-y lines as useless as you're using
> the Device Tree.
> 
> > +#define BCM476X_PERIPH_PHYS   0x00080000
> > +#define BCM476X_PERIPH_VIRT   0xd0080000
> 
> This one should be defined with IOMEM(). Yes, you will have to add a
> cast to make it play nicely with map_desc.virtual.

Will address both of them. Thank you Thomas.

Regards,
Domenico
