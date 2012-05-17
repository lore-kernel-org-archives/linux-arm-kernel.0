From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 May 2012 18:44:12 +0200
Subject: [PATCH v4 4/7] ARM: imx: Enable imx53 low power idle
In-Reply-To: <CAMXH7KGBK=FkggQxJBaNZ-CZDQm=bV9ZtuB3Yf6vykR5FULA8A@mail.gmail.com>
References: <1337135616-8988-1-git-send-email-rob.lee@linaro.org>
 <1337135616-8988-5-git-send-email-rob.lee@linaro.org>
 <20120516174740.GW30400@pengutronix.de>
 <CAMXH7KGBK=FkggQxJBaNZ-CZDQm=bV9ZtuB3Yf6vykR5FULA8A@mail.gmail.com>
Message-ID: <20120517164412.GB30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 09:46:21AM -0500, Rob Lee wrote:
> On Wed, May 16, 2012 at 12:47 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >>
> >> +void __init imx5_init_late(void)
> >> +{
> >> + ? ? imx5_pm_init();
> >> +}
> >> +
> >> ?void __init imx51_init_late(void)
> >> ?{
> >> ? ? ? mx51_neon_fixup();
> >> - ? ? imx5_pm_init();
> >> + ? ? imx5_init_late();
> >> ?}
> >
> > Where would you add i.MX53 specific code above? Hint: imx5_init_late is
> > the wrong function name.
> 
> I added imx5_init_late for late_init functionality that is common
> among all imx5.  For example, in the future imx50 may use it as well.
> But I can remove this and repeat the imx5_pm_init() calls for each
> platform if you prefer that.

The point is that the init_late callback should have a imx53_* name,
otherwise if you call it imx5_* there is no place to add imx53 only
functionality. You can always call imx5 specific things from imx53
context, but not the other way round.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
