From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 12 Jun 2012 08:30:57 +0000
Subject: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
In-Reply-To: <4FD65BA5.4020205@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
 <4FD65BA5.4020205@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 02:27:09, Hunter, Jon wrote:

> > +static __devinit int gpmc_setup_cs_mem(struct gpmc_cs_data *cs,
> > +						struct resource *res)

> > +	return 1;
> > +}
> 
> Nit-pick, CodingStyle chapter 16 states that 0 should be used for
> success when returning from a function.

I doubt whether this falls to the category you are referring.
This function returns number of resources setup, please see
similar for irq too, there it can be 2 also, success or failure
is not sufficient for the other, and with this we have both
functions returning values similar way.

> > +static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
> > +{
> > +	return bitmask;
> > +}
> 
> I have to ask what is the value in this helper function? ;-)

It is to stress the fact that flag user is passing need not be
same as irq bit (here both have same value), this kind of an
arrangement would be required later if waitpin interrupt also
has to be handled, do you still prefer removing it now ?

Regards
Afzal
