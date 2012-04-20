From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Apr 2012 15:58:48 +0000
Subject: [PATCH RESEND v3] iio: Add device tree support to LPC32xx ADC
In-Reply-To: <4F91824A.10207@antcom.de>
References: <1334932713-19231-1-git-send-email-stigge@antcom.de>
 <4F917AE3.7050808@metafoo.de> <4F91824A.10207@antcom.de>
Message-ID: <201204201558.48987.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2012, Roland Stigge wrote:
> In the above case, the situation is as follows:
> 
> * NXP has LPC3220, LPC3230, LPC3240 and LPC3250 (differing in SRAM size
>   and in the existence of its Ethernet and LCD controllers)
> * The ADC controller is present in every single one of those
> * We already have "lpc32xx" in the kernel everywhere
> * Current state is that NXP isn't planning to issue LPC32xx without ADC
> * I'm providing a lpc32xx.dtsi file to be used by all LPC32xx variants.
>   This one is referencing the above "compatible" string. Splitting up
>   in all possible numbers (see below) doesn't help much, here.
> 
> What would you prefer?
> 
> +static const struct of_device_id lpc32xx_adc_match[] = {
> +       { .compatible = "nxp,lpc3220-adc" },
> +       { .compatible = "nxp,lpc3230-adc" },
> +       { .compatible = "nxp,lpc3240-adc" },
> +       { .compatible = "nxp,lpc3250-adc" },
> +       {},
> +};

This looks ok to me.

> What is a better strategy here?

One way we sometimes do these things is to match only the earliest
model, e.g. nxp,lpc3220-adc, and put that one and the new model
into the device tree, to state the the device is compatible with
both the original implementation and the new one.

	Arnd
