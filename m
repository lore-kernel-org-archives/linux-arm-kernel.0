From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 22:27:09 +0200
Subject: [PATCH 3/7] drm/sun4i: Add SAT and DRC drivers
In-Reply-To: <CAGb2v65aSJRBxYX8hweYqezQyfTz_AiqqkGv6c=+8QEL3S+uSw@mail.gmail.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-4-maxime.ripard@free-electrons.com>
 <CAGb2v65aSJRBxYX8hweYqezQyfTz_AiqqkGv6c=+8QEL3S+uSw@mail.gmail.com>
Message-ID: <20160905202709.GE8596@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 02, 2016 at 02:45:06PM +0800, Chen-Yu Tsai wrote:
> > +
> > +DRC
> > +---
> > +
> > +The DRC, found in the latest Allwinner SoCs (A31, A23, A33), allows to
> > +do some backlight control to enhance the power consumption.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun8i-a33-drc
> 
> Since this was first introduced in the A31, maybe using that
> for the compatible is better?
> 
> Or do you want one for each SoC, given these are unknown black
> boxes?

Yeah, I'd prefer to be on the safe side here :/

> > +       drc->mod_clk = devm_clk_get(dev, "mod");
> > +       if (IS_ERR(drc->mod_clk)) {
> > +               dev_err(dev, "Couldn't get our mod clock\n");
> > +               ret = PTR_ERR(drc->mod_clk);
> > +               goto err_disable_bus_clk;
> > +       }
> > +
> > +       return clk_prepare_enable(drc->mod_clk);
> 
> What happens if this fails? No cleanup happens.

Indeed, will fix.

Thanks!
Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/d96df651/attachment.sig>
