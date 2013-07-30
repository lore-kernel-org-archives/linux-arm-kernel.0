From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 22:31:15 +0200
Subject: [linux-sunxi] [PATCH 04/10] pinctrl: sunxi: Wrap long compatible
 declaration lines
In-Reply-To: <1375196953.32691.61.camel@kazak.uk.xensource.com>
References: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375196394-21138-5-git-send-email-maxime.ripard@free-electrons.com>
 <1375196953.32691.61.camel@kazak.uk.xensource.com>
Message-ID: <20130730203115.GE12562@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Tue, Jul 30, 2013 at 04:09:13PM +0100, Ian Campbell wrote:
> On Tue, 2013-07-30 at 16:59 +0200, Maxime Ripard wrote:
> > The compatible declaration and their associated data are exceeding the
> > 80-characters width limit.
> > 
> > Split these lines to make them more readable and fit in the kernel
> > coding guidelines.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/pinctrl/pinctrl-sunxi.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
> > index 5985e60..246310b 100644
> > --- a/drivers/pinctrl/pinctrl-sunxi.c
> > +++ b/drivers/pinctrl/pinctrl-sunxi.c
> > @@ -628,10 +628,22 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
> >  }
> >  
> >  static struct of_device_id sunxi_pinctrl_match[] = {
> > -	{ .compatible = "allwinner,sun4i-a10-pinctrl", .data = (void *)&sun4i_a10_pinctrl_data },
> > -	{ .compatible = "allwinner,sun5i-a10s-pinctrl", .data = (void *)&sun5i_a10s_pinctrl_data },
> > -	{ .compatible = "allwinner,sun5i-a13-pinctrl", .data = (void *)&sun5i_a13_pinctrl_data },
> > -	{ .compatible = "allwinner,sun6i-a31-pinctrl", .data = (void *)&sun6i_a31_pinctrl_data },
> > +	{
> > +		.compatible = "allwinner,sun4i-a10-pinctrl",
> > +		.data = (void *)&sun4i_a10_pinctrl_data,
> > +	},
> 
> I'm not sure this is actually an improvement, the original reads quite
> naturally even if it is a little long. What about a #define such that
> you can write:
>          COMPAT("allwinner,sun4i-a10-pinctrl", sun4i_a10_pinctrl_data),
> and thereby stay within 80-chars?
> 
> If you wanted to go overboard you could code the macro such that:
>         SUNXI_COMPAT(sun4i,a10),
> expanded to what you want, that's pretty obfuscated though.

To be honest, I'm not convinced by any of the constructs seen above. The
one we had is too long, the 4-lines one is not that great either, and
the macro only obfuscates things away.

You know what, I'll drop this patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/5afa76e1/attachment.sig>
