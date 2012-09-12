From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Sep 2012 12:52:02 +0200
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed
 via Device Tree
In-Reply-To: <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
Message-ID: <20120912105202.GD2624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 04:42:36AM -0700, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Each I2C device can be correctly probed already using Device Tree,
> > but the sub-devices still have to be registered by calls to
> > i2c_register_board_info(). After this patch, each sub-device can
> > be registered directly from Device Tree instead, removing the
> > requirement for the aforementioned calls from platform code.
> >
> > CC: linux-i2c at vger.kernel.org
> > CC: Wolfram Sang <w.sang@pengutronix.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> The patch as such is fine.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> ...but there will be merge issues (of the type I'm
> discussing with Arnd in another thread).
> 
> > ---
> >  drivers/i2c/busses/i2c-nomadik.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> > index 5d1a970..01231c2 100644
> > --- a/drivers/i2c/busses/i2c-nomadik.c
> > +++ b/drivers/i2c/busses/i2c-nomadik.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/platform_data/i2c-nomadik.h>
> >  #include <linux/of.h>
> > +#include <linux/of_i2c.h>
> 
> This is clearly dependent on the other patches to I2C to
> be merged first (the include above is not yet there in
> linux-next even), so this patch should go into Wolfram's
> tree right? Else we have to rip out all the patches to the
> I2C driver from his tree and funnel it all through ARM SoC.

First, I'd like to have this patch squashed with "i2c: nomadik: Add
Device Tree support to the Nomadik I2C driver". I wanted to do this on
my own, but the patches do not apply to 3.6-rc5 (with or without
regulator removal patch from Linus)?

I can also take the I2C related changes to the devicetrees via my tree.
This is not uncommon. Some people prefer to do this via their soc-trees,
though. I don't care much since this is not really a hard dependency
causing build failures or merge conflicts, but just needs a little extra
time until the patches are all there...

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/2163b71c/attachment.sig>
