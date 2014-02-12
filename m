From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 12 Feb 2014 14:11:33 +0100
Subject: [PATCH] ARM: imx6: fix !CONFIG_PM and !CONFIG_CPU_IDLE build
In-Reply-To: <CAOMZO5DJNBQU1oL+V3r_=WfX8b_Qd_-OVbdnzVj=AMSS8ndhcg@mail.gmail.com>
References: <1392201948-16311-1-git-send-email-l.stach@pengutronix.de>
 <CAOMZO5DJNBQU1oL+V3r_=WfX8b_Qd_-OVbdnzVj=AMSS8ndhcg@mail.gmail.com>
Message-ID: <1392210693.4661.8.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 12.02.2014, 11:04 -0200 schrieb Fabio Estevam:
> On Wed, Feb 12, 2014 at 8:45 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > --- a/arch/arm/mach-imx/common.h
> > +++ b/arch/arm/mach-imx/common.h
> > @@ -138,7 +138,6 @@ void imx_gpc_irq_unmask(struct irq_data *d);
> >  void imx_anatop_init(void);
> >  void imx_anatop_pre_suspend(void);
> >  void imx_anatop_post_resume(void);
> > -int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
> >  void imx6q_set_chicken_bit(void);
> 
> This function has been renamed since commit f191d820b1b (ARM: imx: Use
> INT_MEM_CLK_LPM as the bit name)
> 
Which isn't in imx/fixes, where this patch should probably go to.

Also this patch doesn't touch the chicken/whatever function at all, it
just ensures that it is available for linking when needed, so there
shouldn't be any conflicts (aside from a few context mismatches).

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
