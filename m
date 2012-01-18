From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2012 13:13:29 +0100
Subject: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
In-Reply-To: <20120117231314.GA1068@n2100.arm.linux.org.uk>
References: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
 <20120117231314.GA1068@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 12:13 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Please don't delete the above definitions.

OK don't want to break anything...

> The SSP interface is more than just SPI (it's microwire and TI format,
> and I have a working ASoC driver for the Assabet.)

We usually merge drivers for microwire, TI, Motorola ... etc into
drivers/spi as well. It's a good enough fit, the differences are very
small. This is how we configure mode from the PL022 driver platform data:

/**
 * enum ssp_interface - interfaces allowed for this SSP Controller
 * @SSP_INTERFACE_MOTOROLA_SPI: Motorola Interface
 * @SSP_INTERFACE_TI_SYNC_SERIAL: Texas Instrument Synchronous Serial
 * interface
 * @SSP_INTERFACE_NATIONAL_MICROWIRE: National Semiconductor Microwire
 * interface
 * @SSP_INTERFACE_UNIDIRECTIONAL: Unidirectional interface (STn8810
 * &STn8815 only)
 */
enum ssp_interface {
        SSP_INTERFACE_MOTOROLA_SPI,
        SSP_INTERFACE_TI_SYNC_SERIAL,
        SSP_INTERFACE_NATIONAL_MICROWIRE,
        SSP_INTERFACE_UNIDIRECTIONAL
};

> In addition, I also have a DMA engine driver for the DMA stuff on SA1100,
> which couples into a generic DMA engine ASoC platform driver (though only
> for playback).
>
> Oh, and a SA1100 IrDA driver converted to use the DMA engine stuff...

That's pretty cool :-)

> Patches will be posted after the merge window closes.

I think it's better if something like this is based on top of your patch
stack so as not to disrupt addition of new functionality. It'd be nice
if you could make the branch available once you push that stuff
to -next.

Yours,
Linus Walleij
