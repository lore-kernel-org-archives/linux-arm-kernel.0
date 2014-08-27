From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 27 Aug 2014 09:59:37 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <CAOesGMihWucg0HJ1ecdq_98j+hR=C=DhU8cyjrC+5s7rUJM2MQ@mail.gmail.com>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <CAOesGMjo0AY=eGcfTh1sVxKkURK9bzK8SBAeEbvBFN4R0sF34A@mail.gmail.com>
 <CAOesGMihWucg0HJ1ecdq_98j+hR=C=DhU8cyjrC+5s7rUJM2MQ@mail.gmail.com>
Message-ID: <5183639.cXydHclPsr@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Olof,

On Sunday, August 10, 2014 08:05:23 PM Olof Johansson wrote:
> On Tue, Jul 22, 2014 at 1:28 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Tue, Jul 22, 2014 at 11:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Tuesday 22 July 2014 11:01:10 Olof Johansson wrote:
> >>> This is a major refresh of the multi_v7_defconfig:
> >>>
> >>> - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
> >>>  * Enable big.LITTLE
> >>>  * MCPM
> >>>  * CYAPA touchpad
> >>>  * Samsung-related MTD/regulator/clk/pinmux drivers
> >>>  * Add some of the CrOS EC drivers
> >>> - Turn on TPM, HW_RANDOM
> >>> - OMAP_USB3 -> TI_PIPE3 option rename
> >>> - Enable MCPM/b.L for VEXPRESS
> >>> - Add new CONFIG_MTD_SPI_NOR since it otherwise masks off SPI NOR drivers
> >>> - CONFIG_LOGO, because penguins.
> >>>
> >>> I took care to keep the new options that have been added for whose the
> >>> drivers are not yet in our for-next branch. This was pretty awkward so
> >>> we should sort out how to handle those better in the future.
> >>
> >> Since you've already done all those, how about enabling THUMB2_KERNEL?
> >> For the multi_v7_defconfig, it should actually give some benefits,
> >> since it's rather large, and it would be good to have some more testing
> >> with this option enabled.
> >>
> >> I guess the first step would be to enable it and just see if your
> >> boot farm survives the change.
> >
> > Good point, I'll definitely give that a go once the current issues are resolved.
> >
> > Which are: These changes make 5250-based machines (snow and arndale)
> > break. Lots of i2c timeouts on SATA and hdmi-phy. Looks like arndale
> > might be missing pinctrl setups for it?
> >
> > Tushar, Kukjin, any chance you can investigate from your end? I'd like
> > to get this change in since it allows for better multiplatform
> > coverage, but the Exynos breakage must be fixed...
> 
> This is still broken on 5250:
> http://arm-soc.lixom.net/bootlogs/misc/v3.16-10143-gccefc7a/ is with
> this patch applied on top of current mainline and the few fixes we
> have queued up.
> 
> I2C_S3C2410 is enabled with that config now.
> 
> Tushar is no longer on a Linaro landing team, so he's not looking
> after Arndale. Kukjin?

I'm not responsible for Arndale but I took a look at the issue and
managed to fix it on my setup.

Please see:

  https://lkml.org/lkml/2014/8/27/116

for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
