From: gaowanlong@cn.fujitsu.com (Wanlong Gao)
Date: Mon, 25 Jul 2011 15:12:01 +0800
Subject: [PATCH v6 0/6] mc13783: add pwr button support
In-Reply-To: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <4E2D1741.6020502@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2011 10:17 PM, Philippe R?tornaz wrote:
> Hello
>
> This add button handling for the MC13783 PMIC.
>
> Patch 1&  2 modify the mc13xxx MFD driver to use the platform data to
> resgister the led subdevice and unconditionally register the regulator
> subdevice (as suggested by Mark and Uwe).
>
> Patch 3 remove the use of the *_USE_REGULATOR and *_USE_LED macros in
> the platform files.
>
> Patch 4 must be applied after patch 1,2,3 to remove the obsolete define.
>
> Patch 5 modify the mc13xxx MFD driver to add a button subdevice and
> also adds the mc13783-pwrbutton driver using a misc input device.
>
> The last patch adds the power on button support to the mx31moboard boards.
>
> v2: first patch modified according to comments by Dmitry Torokhov
> v3: Implement review by Uwe
> v4: Implement comments by Uwe and Mark
> v5: Reorder patchset
> v6: Minor corrections
>
> Philippe R?tornaz (6):
>    mc13xxx: Unconditionally register regulator subdevice
>    mc13xxx: implicitly register led subdevice
>    mc13xxx: remove obsolete leds and regulators flags
>    mc13xxx: remove unused define
>    mc13783: add power button support
>    mx31moboard: Add MC13783 power button support
>
>   arch/arm/mach-imx/mach-mx27_3ds.c      |    1 -
>   arch/arm/mach-imx/mach-mx31_3ds.c      |    2 +-
>   arch/arm/mach-imx/mach-mx31lite.c      |    3 +-
>   arch/arm/mach-imx/mach-mx31moboard.c   |   11 +-
>   arch/arm/mach-imx/mach-pcm038.c        |    3 +-
>   arch/arm/mach-mx5/mx51_efika.c         |    2 +-
>   drivers/input/misc/Kconfig             |   10 +
>   drivers/input/misc/Makefile            |    1 +
>   drivers/input/misc/mc13783-pwrbutton.c |  282 ++++++++++++++++++++++++++++++++
>   drivers/mfd/mc13xxx-core.c             |   17 ++-
>   include/linux/mfd/mc13783.h            |    3 +-
>   include/linux/mfd/mc13xxx.h            |   19 ++-
>   12 files changed, 336 insertions(+), 18 deletions(-)
>   create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
>
Seems good now, cheers.


-- 
Thanks
Best Regards
Wanlong Gao
