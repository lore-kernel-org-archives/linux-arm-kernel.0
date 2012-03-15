From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 17:53:25 +0000
Subject: [PATCH 5/5] MMC: mmci: Add required documentation for Device Tree
 bindings
In-Reply-To: <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
Message-ID: <201203151753.25774.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Lee Jones wrote:

Some more comments about the individual properties

> +Required properties:
> +- compatible             : contains "arm,pl18x", "arm,primecell".

Better use the exact number for 'x' here.

> +- reg                    : contains pl18x registers and length.
> +- interrupts             : contains the device IRQ(s).

You should document what the first and second interrupts are,
respectively, if there is more than one.

> +- arm,primecell-periphid : contains the PrimeCell Peripheral ID.

This one should be optional.

> +
> +Optional properties:
> +- ocr_mask               : contains the regulator oscillator mask

Not sure about this one. If it's for the regulators, we should be
using the regulator bindings.

> +- wp-gpios               : contains any write protect (ro) gpios
> +- cd-gpios               : contains any card detection gpios
> +- cd-invert              : indicates whether the cd gpio is inverted 
> +- clock_frequency        : contains the maximum operating frequency

The name should be 'clock-frequency', not 'clock_frequency'.

> +- mmc_cap_4_bit_data     : indicates whether device is 4 bit capable
> +- mmc_cap_8_bit_data     : indicates whether device is 8 bit capable
> +- mmc_cap_mmc_highspeed  : indicates whether MMC is high speed capable
> +- mmc_cap_sd_highspeed   : indicates whether SD is high speed capable

I would strongly recommend using the same naming as sdhci here. I think
tegra has set a precedent.

> +ux500 variant specific properties:
> +- gpio-en                : contains the level-shifter enable gpio
> +- gpio-vsel              : contains the level-shifter voltage select gpio

I think these need to be 'en-gpios' and 'vsel-gpios', in order for the
gpio binding to work.

> +- tx_dst_dev_type        : contains the tx destination device (DMA) 
> +- rx_src_dev_type        : contains the rx source device (DMA)

As Russell commented already, these should not be here.

	Arnd
