From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Oct 2012 14:36:10 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
 <20121001154451.GI4840@atomide.com>
 <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
Message-ID: <CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2012 at 12:52 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> On Tue, Oct 02, 2012 at 01:29:37, Linus Walleij wrote:

>> This is what we're doing for ux500 and should be a good model.
>
> I have looked into this, but not seen any named modes.

OK maybe it's not easy to find. If you look into:
arch/arm/mach-ux500/board-mop500-pins.c
you find our work in progress. Note that this is not (yet)
using device tree. (We want to migrate all our pinctrl
stuff first, then do DT.)

So for example this macro:

#define DB8500_PIN(pin,conf,dev) \
        PIN_MAP_CONFIGS_PIN_DEFAULT(dev, "pinctrl-db8500", pin, conf)

Will define a config for the "default" mode for a certain
pin.

This:

#define DB8500_PIN_SLEEP(pin, conf, dev) \
        PIN_MAP_CONFIGS_PIN(dev, PINCTRL_STATE_SLEEP, "pinctrl-db8500", \
                            pin, conf)

Will mutatis mutandis define a "sleep" mode for a pin.

Sorry for the macros. We'll get rid of them in the DT.
(Now that Stephen has patched in preprocessing it will
even look good.)

Yours,
Linus Walleij
