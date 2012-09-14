From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Sep 2012 09:22:12 +0100
Subject: [PATCH 12/19] i2c-nomadik: Register sub-devices when passed via
 Device Tree
In-Reply-To: <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-13-git-send-email-lee.jones@linaro.org>
 <CACRpkdaCrus9SOpxyK+kV2gKr3sEZJsHCn6ivn2gA3ri0rcvHw@mail.gmail.com>
Message-ID: <20120914082210.GD3374@gmail.com>
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
> 
> With the changes to the device tree itself being dependent
> on this, they should thus also go through the I2C tree.
> 
> But they may be heavily dependent on the other DT
> changes you've done, so they cannot be applied to
> Wolfram's tree...
> 
> And thus you may need to hold this change off
> until the I2C changes are upstream, or start creating
> cross-tree dependencies.
> 
> Maybe I shouldn't worry about these things and just
> ACK stuff, but I have such problems with cross-tree
> merges myself so just trying to be helpful :-/

If I send all my stuff though arm-soc, then I have no
dependencies at all. All my patches are based on the latest
-rc. It seems a little silly to split them all up and push
them through lots of different trees. That way we're bound
to increase the chances of merge conflicts surely?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
