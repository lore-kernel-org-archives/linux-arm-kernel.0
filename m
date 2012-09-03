From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 3 Sep 2012 06:57:22 +0000
Subject: [PATCH 1/3] ASoC: Davinci: McASP: add support new McASP IP Variant
In-Reply-To: <20120901004443.GB21451@opensource.wolfsonmicro.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-2-git-send-email-gururaja.hebbar@ti.com>
 <20120901004443.GB21451@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA718B0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 06:14:44, Mark Brown wrote:
> On Fri, Aug 31, 2012 at 06:20:57PM +0530, Hebbar, Gururaja wrote:
> 
> > +			if (dev->version == MCASP_VERSION_3) {
> > +				mcasp_clr_bits(dev->base + MCASP_VER3_RFIFOCTL,
> >  								FIFO_ENABLE);
> > -			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
> > +				mcasp_set_bits(dev->base + MCASP_VER3_RFIFOCTL,
> >  								FIFO_ENABLE);
> > +			} else {
> > +				mcasp_clr_bits(dev->base +
> > +					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
> > +				mcasp_set_bits(dev->base +
> > +					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
> > +			}
> 
> This is all basically OK but it seems like it'd be better if all these
> dev->version checks were switch statements.  That way when the hardware
> designers get bored and add version 4 of the register map it'll slot in
> naturally, and it'll be more clear what the code currently handles.

Ok I will update this. Since 3/3 is already accepted & I don?t see any reviews
for 2/3, I will only resend this patch (1/3). Is it ok?

> 


Regards, 
Gururaja
