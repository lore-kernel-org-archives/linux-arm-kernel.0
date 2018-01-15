From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Jan 2018 13:57:58 +0100
Subject: [PATCH] ARM: lpc3250: fix uda1380 gpio numbers
In-Reply-To: <20180110162220.224945-1-arnd@arndb.de>
References: <20180110162220.224945-1-arnd@arndb.de>
Message-ID: <CAK8P3a0q+UM_7wY_rdbkJOzLfoS4HYCXSXodpqtHHY=h-7_mpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> dtc warns about obviously incorrect GPIO numbers for the audio codec
> on both lpc32xx boards:
>
> arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
> arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
> arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): reset-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
> arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property): power-gpio property size (12) too small for cell size 3 in /ahb/apb/i2c at 400A0000/uda1380 at 18
>
> It looks like the nodes are written for a different binding that combines
> the GPIO number into a single number rather than a bank/number pair.
> I found the right numbers on stackexchange.com, so this patch fixes
> the warning and has a reasonable chance of getting things to actually
> work.
>
> Link: https://unix.stackexchange.com/questions/59497/alsa-asoc-how-to-correctly-load-devices-drivers/62217#62217
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've applied this to the next/dt branch now.

       Arnd
