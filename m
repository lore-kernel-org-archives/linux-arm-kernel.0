From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 08:40:43 +0000
Subject: [PATCH v5 11/14] ARM: OMAP2+: gpmc: handle connected peripherals
In-Reply-To: <4FD8B23C.4020900@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <5b3939381db2b7ac29d9df1e817af2ce80016007.1339419492.git.afzal@ti.com>
 <4FD8B23C.4020900@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999694@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 21:01:08, Hunter, Jon wrote:
> On 06/11/2012 09:27 AM, Afzal Mohammed wrote:

> > +static __devinit int gpmc_setup_cs(struct gpmc_peripheral *g_per,
> > +				struct gpmc_cs_data *cs, struct resource *res) {
> > +	int num, ret;
> > +
> > +	num = gpmc_setup_cs_mem(cs, res);
> > +	if (IS_ERR_VALUE(num))
> > +		return num;
> > +
> > +	ret = gpmc_setup_cs_config_timing(g_per, cs);
> > +	if (IS_ERR_VALUE(ret))
> > +		return ret;
> > +
> > +	num += gpmc_setup_cs_irq(cs, res + num);
> 
> 
> What happens if the above function returns an error?

That has been deliberately done as that implies user has not
specified irq flag & hence is not an error.

But it seems, I should print error information if user tries to use an
interrupt and if driver does not want/unable to use gpmc interrupt.

Regards
Afzal
