From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 10 Jul 2015 12:02:19 +0200
Subject: [PATCH] pinctrl: imx1-core: Fix debug output pin array index
In-Reply-To: <20150709180652.GJ1426@pengutronix.de>
References: <1436364966-19778-1-git-send-email-mpa@pengutronix.de>
 <20150709071252.GF1426@pengutronix.de>
 <559E3098.9070609@gtsys.com.hk>
 <20150709133036.GK7573@pengutronix.de>
 <20150709180652.GJ1426@pengutronix.de>
Message-ID: <20150710100219.GO7573@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 09, 2015 at 08:06:52PM +0200, Uwe Kleine-K?nig wrote:
> Hi,
> 
> On Thu, Jul 09, 2015 at 03:30:36PM +0200, Markus Pargmann wrote:
> > > b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
> > > index 5ac59fb..8408bd8 100644
> > > --- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
> > > +++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
> > > @@ -403,14 +403,16 @@ static int imx1_pinconf_set(struct pinctrl_dev *pctldev,
> > >  			     unsigned num_configs)
> > >  {
> > >  	struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> > > -	const struct imx1_pinctrl_soc_info *info = ipctl->info;
> > > +	struct pin_desc *desc;
> > >  	int i;
> > > 
> > > +	desc = pin_desc_get(pctldev, pin_id);
> > 
> > For the rest of this function pin_desc_get() is not necessary. This is
> > not a simple function call but a radix tree lookup as far as I can see.
> > I am not sure how important this debugging information is and how
> > expensive this function call is?!
> If it's moved into the call to pr_debug it should be optimized away when
> debugging is off. That together with a merge of Chris' and mine commit
> log and I'm happy.

Ok. If you change that I am happy as well.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150710/9ef8930b/attachment.sig>
