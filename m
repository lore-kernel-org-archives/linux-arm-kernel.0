From: briannorris@chromium.org (Brian Norris)
Date: Thu, 11 Jan 2018 18:18:02 -0800
Subject: [PATCH 2/3] ARM: tegra: paz00: drop nonstandard
 'backlight-boot-off'
In-Reply-To: <27065017.X8cFkIFnZg@fb07-iapwap2>
References: <20180106004757.8239-1-briannorris@chromium.org>
 <20180106004757.8239-2-briannorris@chromium.org>
 <27065017.X8cFkIFnZg@fb07-iapwap2>
Message-ID: <20180112021801.GA243980@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 12:31:31PM +0100, Marc Dietrich wrote:
> Hi,
> 
> Am Samstag, 6. Januar 2018, 01:47:56 CET schrieb Brian Norris:
> > This was used out-of-tree as a hack for resolving issues where some
> > systems expect the backlight to turn on automatically at boot, while
> > others expect to manage the backlight status via a DRM/panel driver.
> > Those issues have since been fixed upstream in pwm_bl.c without device
> > tree hacks, and so this un-documented property should no longer be
> > useful.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> seems to work again. Thanks!

BTW, I guess I could have put this in the commit message, but the
problem that this out-of-tree property was trying to resolve was fixed
by this (and some other related patches):

d1b812945750 backlight: pwm_bl: Check the PWM state for initial backlight power state

Brian

> Reviewed-by: Marc Dietrich <marvin24@gmx.de>
> 
> > ---
> >  arch/arm/boot/dts/tegra20-paz00.dts | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> > b/arch/arm/boot/dts/tegra20-paz00.dts index 30436969adc0..12c63b23ed5e
> > 100644
> > --- a/arch/arm/boot/dts/tegra20-paz00.dts
> > +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> > @@ -504,8 +504,6 @@
> > 
> >  		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224
> > 240 255>; default-brightness-level = <10>;
> > -
> > -		backlight-boot-off;
> >  	};
> > 
> >  	clocks {
> 
