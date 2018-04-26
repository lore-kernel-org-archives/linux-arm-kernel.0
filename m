From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Apr 2018 16:57:18 +0200
Subject: [PATCH v2] ARM: defconfig: Update Gemini defconfig
In-Reply-To: <20180420090044.17036-1-linus.walleij@linaro.org>
References: <20180420090044.17036-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a1X_hKLo3o1YmkxayncUGbTuTR+HKftmvbCtwQegO7zHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 11:00 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This updates the Gemini defconfig with a config that will bring
> up most of the recently merged and updated devices to some
> functional level:
>
> - We enable high resolution timers (the right thing to do)
> - Enable CMA for the framebuffer, and the new TVE200
>   framebuffer driver and the Ilitek ILI9322 driver for
>   graphics on the D-Link DIR-685. HIGHMEM support comes in
>   as part of this.
> - Enable networking and the new Cortina Gemini ethernet
>   driver.
> - Enable MDIO over GPIO and the Realtek PHY devices used on
>   several of these systems.
> - Enable I2C over GPIO and SPI over GPIO which is used on
>   several of these devices.
> - Enable the Thermal framework, GPIO fan control and LM75 sensor
>   adding cooling on the D-Link DNS-313 with no userspace
>   involved even if only the kernel is working, rock solid
>   thermal for this platform.
> - Enable JEDEC flash probing to support the Eon flash chip in
>   D-Link DNS-313.
> - Enable LED disk triggers for the NAS type devices.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - This update didn't get applied for v4.16 so we gained even
>   more stuff in v4.17
> - Drop the wireless devices: it is better if people configure
>   those in themselves, and it is also what OpenWRT does.
> - Drop UHCI and EHCI configs as these may conflict with the
>   SoC intrinsic FTOTG adapter.
>
> ARM SoC folks: please apply this for fixes.

I've applied it to the fixes branch now, but I don't see why I didn't
get the patch before the merge window when you already
had a version for the v4.16 window.

       Arnd
