From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 7 Sep 2012 10:39:04 +0530
Subject: [GIT PULL] ARM: OMAP2+: PRCM/hwmod: some fixes for 3.6-rc
In-Reply-To: <alpine.DEB.2.00.1209051613580.11516@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209051613580.11516@utopia.booyaka.com>
Message-ID: <50498170.3010600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/5/2012 9:45 PM, Paul Walmsley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Tony,
> 
> The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:
> 
>   Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-3.6rc
> 
> for you to fetch changes up to 8a94febc21743fe121bdaf1d1470d98b1135acc2:
> 
>   Merge branches 'clkdev_fixes_3.6rc', 'clkdm_fixes_3.6rc' and 'hwmod_data_fixes_a_3.6rc' into omap_fixes_a_3.6rc (2012-09-03 11:52:02 -0600)
> 

Paul,

Isn't below patch good for -rc candidate (so as part of this 'fixes')?

ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check for common functions

https://patchwork.kernel.org/patch/1371611/


Thanks,
Vaibhav

> - ----------------------------------------------------------------
> 
> Some hwmod, clockdomain, am335x fixes against v3.6-rc4.
> 
> Test logs can be found here:
> 
>    http://www.pwsan.com/omap/testlogs/omap_fixes_a_3.6rc/20120904110254/
> 
> - ----------------------------------------------------------------
> Misael Lopez Cruz (1):
>       ARM: OMAP: hwmod code: Disable module when hwmod enable fails
> 
> Paul Walmsley (2):
>       ARM: OMAP3xxx: clockdomain: fix software supervised wakeup/sleep
>       Merge branches 'clkdev_fixes_3.6rc', 'clkdm_fixes_3.6rc' and 'hwmod_data_fixes_a_3.6rc' into omap_fixes_a_3.6rc
> 
> Tero Kristo (2):
>       ARM: OMAP3: hwmod data: fix iva2 reset info
>       ARM: OMAP4: hwmod data: temporarily comment out data for the sl2if IP block
> 
> Vaibhav Hiremath (1):
>       ARM: OMAP2+: am33xx: Fix the timer fck clock naming convention
> 
>  arch/arm/mach-omap2/clock33xx_data.c       |   14 ++++----
>  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   50 ++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/cm-regbits-34xx.h      |    1 +
>  arch/arm/mach-omap2/omap_hwmod.c           |    1 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   15 +++++++--
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 +++----
>  6 files changed, 75 insertions(+), 18 deletions(-)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> 
> iQIcBAEBAgAGBQJQR3ooAAoJEMePsQ0LvSpLQ94P/1DzifcEU/R0YFLZF+20XPd5
> hOrUk2EWn7SlPAxZJMG1K+In7EZ3K4r7IYaROIbwUWJTO/hQdx6zwyAOec/qnutV
> WYRnQ+KN+x7gd8EYZPnS1voiqeH0SnP/wI2ri9UcMTV+tpAtO6ibD10iAUmBxSfX
> x9HaYb65cYA+ulMsQXX2g1oejV2+4eR+fWWI0+bGfOxIHPGQcEhSGSvNkDs9W/bE
> QfBKmTWeizx2jlRlXBG8pxV8MtEIDtwRZitcgTnyStw8LMqR/YnCOLIRoU2OHVcP
> UtQwIxtNqGaoqm3i6IXGM1BLI4ZT/EN0kr+1LZVl1WoFqL1tDrn39dSvSVfxfGje
> CjhkTk9XVzbV4GV+1yTt6JlfD3AimLwYqihKDs21a2OleAsQAu8a+gftsJtSp8Xu
> fscJcjr1c5JKyjE5CzbH7mbDgX+LTveZV3b6pT1m599UidP/NZ4yzUYrmkTmoSkk
> JdqQlTgahLxjBoBBDfNhavuCzA4cYNh6q0Pt6GhmWc1ZC7aR3+7xU4wUNXAvbKoe
> mUksJmjROwk4MlswLqpIkgt8iiEGa2LzHcyL7eVD2+oCun0FFlolqa1R3gTF9x8y
> Hr8iNv4b0OeX55oSZ53ijIDY4WwgmBVvnVjiWEiAkBuwqsghRLii5eemX572szGU
> lTSzo95e8x7kAaO6moNI
> =wc/t
> -----END PGP SIGNATURE-----
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
