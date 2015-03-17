From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Mar 2015 11:36:20 +0100
Subject: [PATCH 3/5] leds: syscon: instantiate from platform device
In-Reply-To: <1425375148-4369-4-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbV_cS2_FVRQU5yd553aPaqyiYqs5gKOSz3ATcaq0+5BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 10:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Currently syscon LEDs will traverse the device tree looking for syscon devices
> and if found, traverse any subnodes of these to identify matching children
> and from there instantiate LED class devices.
>
> This is not a good use of the Linux device model. Instead we have converted the
> device trees to add the "simple-mfd" property to the MFD nexi spawning syscon
> LEDs so that these will appear as platform devices in the system and we can
> use the proper device probing mechanism.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Bryan: if you're OK with it, please ACK this patch so we can funnel it through
> ARM SoC with the rest of the patches in this series.

Bryan, ping.

Yours,
Linus Walleij
