From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Jun 2014 02:57:15 -0700
Subject: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <53A00970.3090902@ti.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
 <20140617085846.GO17845@atomide.com> <53A00970.3090902@ti.com>
Message-ID: <20140617095715.GS17845@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140617 02:26]:
> On 17/06/14 11:58, Tony Lindgren wrote:
> 
> >> +/* rfbi */
> > 
> > I think we're still missing am43x_rfbi_sysc entry though?
> > 
> >> +static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
> >> +	.name		= "dss_rfbi",
> >> +	.class		= &omap2_rfbi_hwmod_class,
> >> +	.clkdm_name	= "dss_clkdm",
> >> +	.main_clk	= "disp_clk",
> >> +	.prcm = {
> >> +		.omap4 = {
> >> +			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
> >> +		},
> >> +	},
> >> +};
> 
> That should come from omap2/3 hwmod data, as the above references
> omap2_rfbi_hwmod_class. The bits there looked correct for AM43xx to me.

OK looks good to me then:

Acked-by: Tony Lindgren <tony@atomide.com>
