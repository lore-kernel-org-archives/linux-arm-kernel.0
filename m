From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 21 Sep 2014 00:30:22 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBCQ001MzAxWDogc2VsZWN0IEdQSU9MSUIgYXMg?=
 =?UTF-8?B?b3B0aW9uYWw=?=
In-Reply-To: <CACna6rzf6mVVWHs=6diuCsAAdPsnDpfUL4z6Bv-WChSJC5N3Cg@mail.gmail.com>
References: <1411231282-7180-1-git-send-email-zajec5@gmail.com>
 <1411244081.659348996@f383.i.mail.ru>
 <CACna6rzf6mVVWHs=6diuCsAAdPsnDpfUL4z6Bv-WChSJC5N3Cg@mail.gmail.com>
Message-ID: <1411245022.509392841@f140.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 20 Sep 2014 22:23:00 +0200 ?? Rafa? Mi?ecki <zajec5@gmail.com>:
> On 20 September 2014 22:14, Alexander Shiyan <shc_work@mail.ru> wrote:
> > Sat, 20 Sep 2014 22:00:37 +0200 ?? Rafa? Mi?ecki <zajec5@gmail.com>:
> >> On 20 September 2014 19:00, Alexander Shiyan <shc_work@mail.ru> wrote:
> >> > Sat, 20 Sep 2014 18:41:22 +0200 ?? Rafa? Mi?ecki <zajec5@gmail.com>:
> >> >> All routers (or 99% of them) based on BCM5301X use GPIOs to control LEDs
> >> >> and buttons.
> >> >>
> >> >> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> >> >> ---
> >> >>  arch/arm/mach-bcm/Kconfig | 2 ++
> >> >>  1 file changed, 2 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> >> >> index fc93800..d967c98 100644
> >> >> --- a/arch/arm/mach-bcm/Kconfig
> >> >> +++ b/arch/arm/mach-bcm/Kconfig
> >> >> @@ -80,8 +80,10 @@ config ARCH_BCM2835
> >> >>
> >> >>  config ARCH_BCM_5301X
> >> >>       bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
> >> >> +     select ARCH_WANT_OPTIONAL_GPIOLIB
> >> >>       select ARM_GIC
> >> >>       select CACHE_L2X0
> >> >> +     select GPIOLIB
> >> > ...
> >> >
> >> > GPIOLIB is selected automatically by ARCH_WANT_OPTIONAL_GPIOLIB.
> >>
> >> I don't think so, I believe selecting is done by ARCH_REQUIRE_GPIOLIB only.
> >>
> >> Reading drivers/gpio/Kconfig confuses me a bit. I believe I should
> >> select ARCH_WANT_OPTIONAL_GPIOLIB, because the board can boot without
> >> GPIOs, they are needed for LEDs and buttons only. Also most users will
> >> want LEDs and buttons, so I "select GPIOLIB".
> >
> > Yes, my bad :)
> >
> > ARCH_REQUIRE_GPIOLIB selects GPIOLIB.
> > ARCH_WANT_OPTIONAL_GPIOLIB make GPIOLIB user selectable, so, in any
> > case you need to add ARCH_WANT_OPTIONAL_GPIOLIB only.
> 
> So is there any way to make GPIOLIB optional (by using
> ARCH_WANT_OPTIONAL_GPIOLIB) and make it enabled by default? I wish
> GPIOLIB to be enabled by default as 99% users will want it.

Not so elegant, but you can select GPIOLIB for particular boards, which contain GPIO
functionality. I add Linus Walleij to CC for possible comments on this.

---
