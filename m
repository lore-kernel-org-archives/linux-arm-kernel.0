From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 14 Apr 2011 15:09:00 +0200
Subject: [PATCH v2] at91: remove MTD_NAND_ATMEL_BUSWIDTH_16 option
In-Reply-To: <20110414125716.GI1611@n2100.arm.linux.org.uk>
References: <1302712141-6952-1-git-send-email-plagnioj@jcrosoft.com>
	<1302784833-25930-1-git-send-email-plagnioj@jcrosoft.com>
	<20110414125716.GI1611@n2100.arm.linux.org.uk>
Message-ID: <20110414130900.GC7290@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +/*
> > + * board revision encoding
> > + * bit 0:
> > + *	0 => nand 8 bit
> > + *	1 => nand 16 bit
> > + */
> > +#define HAVE_NAND_16BIT	(1 << 0)
> > +static int inline ek_have_nand_16bit(void)
> > +{
> > +	return system_rev & HAVE_NAND_16BIT;
> > +}
> 
> Do we really need six identical bits of code checking bit 0 of the system
> revision, which are different from an already established usage?
> 
> Please consolidate this down to a single implementation.
I want to do it but the system_rev is 32bit only and I was not wishing to
impose it but if you incist I can try it

as example on 9g20 we have 1 or 2 mmc selection
on 9g45 we have lcd type

so I can try to reserve so upper bit for generic at91 feature and the rest
board specifc

Best Regards,
J.
