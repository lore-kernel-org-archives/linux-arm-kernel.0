From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 20:36:54 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <1406052070-6207-1-git-send-email-olof@lixom.net>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
Message-ID: <12165027.MHmNZOI7jc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014 11:01:10 Olof Johansson wrote:
> This is a major refresh of the multi_v7_defconfig:
> 
> - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
>  * Enable big.LITTLE
>  * MCPM
>  * CYAPA touchpad
>  * Samsung-related MTD/regulator/clk/pinmux drivers
>  * Add some of the CrOS EC drivers
> - Turn on TPM, HW_RANDOM
> - OMAP_USB3 -> TI_PIPE3 option rename
> - Enable MCPM/b.L for VEXPRESS
> - Add new CONFIG_MTD_SPI_NOR since it otherwise masks off SPI NOR drivers
> - CONFIG_LOGO, because penguins.
> 
> I took care to keep the new options that have been added for whose the
> drivers are not yet in our for-next branch. This was pretty awkward so
> we should sort out how to handle those better in the future.

Since you've already done all those, how about enabling THUMB2_KERNEL?
For the multi_v7_defconfig, it should actually give some benefits,
since it's rather large, and it would be good to have some more testing
with this option enabled.

I guess the first step would be to enable it and just see if your
boot farm survives the change.

	Arnd
