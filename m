From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 14 Dec 2016 00:05:47 +0530
Subject: [PATCH RFC 2/2] ARM: nommu: remap exception base address to RAM
In-Reply-To: <20161213100226.GW14217@n2100.armlinux.org.uk>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
 <20161213100226.GW14217@n2100.armlinux.org.uk>
Message-ID: <20161213183547.GB4629@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 13, 2016 at 10:02:26AM +0000, Russell King - ARM Linux wrote:
> On Sun, Dec 11, 2016 at 06:42:55PM +0530, Afzal Mohammed wrote:

> >  	bic	r0, r0, #CR_V
> >  #endif
> >  	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
> > +
> > +#ifdef CONFIG_REMAP_VECTORS_TO_RAM
> > +	mov	r3, #CONFIG_VECTORS_BASE	@ read VECTORS_BASE
> > +	mcr	p15, 0, r3, c12, c0, 0		@ write to VBAR
> > +#endif
> > +

> Is there really any need to do this in head.S ?

Seeing the high vector configuration done here, pounced upon it :)

> I believe it's
> entirely possible to do it later - arch/arm/mm/nommu.c:paging_init().
> 
> Also, if the region setup for the vectors was moved as well, it would
> then be possible to check the ID registers to determine whether this
> is supported, and make the decision where to locate the vectors base
> more dynamically.

i will look into it.

Regards
afzal
