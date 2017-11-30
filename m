From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Thu, 30 Nov 2017 23:02:46 +0100
Subject: [PATCH 1/5] mtd: nand: use usual return values for the
 ->erase() hook
In-Reply-To: <20171130215113.458d616f@bbrezillon>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
 <20171130170132.27522-2-miquel.raynal@free-electrons.com>
 <20171130215113.458d616f@bbrezillon>
Message-ID: <20171130230246.61a9ed19@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/drivers/mtd/nand/nand_base.c
> > b/drivers/mtd/nand/nand_base.c index 630048f5abdc..4d1f2bda6095
> > 100644 --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -3077,7 +3077,7 @@ int nand_erase_nand(struct mtd_info *mtd,
> > struct erase_info *instr, status = chip->erase(mtd, page &
> > chip->pagemask); 
> >  		/* See if block erase succeeded */
> > -		if (status & NAND_STATUS_FAIL) {
> > +		if (status) {
> >  			pr_debug("%s: failed erase, page 0x%08x\n",
> >  					__func__, page);
> >  			instr->state = MTD_ERASE_FAILED;  
> 
> You forgot to patch single_erase() accordingly.

Right, sorry about that, I will fix that.

Thanks,
Miqu?l
