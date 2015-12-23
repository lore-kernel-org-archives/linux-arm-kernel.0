From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 23 Dec 2015 11:27:01 +0100
Subject: [PATCH 1/5] iio:adc:at91_adc8xx: introduce new atmel adc driver
In-Reply-To: <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
 <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151223102701.GH8623@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/12/2015 at 10:24:08 +0100, Ludovic Desroches wrote :
> +++ b/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> @@ -0,0 +1,27 @@
> +* AT91 SAMA5D2 Analog to Digital Converter (ADC)
> +
> +Required properties:
> +  - compatible: Should be "atmel,sama5d2-adc".
> +  - reg: Should contain ADC registers location and length.
> +  - interrupts: Should contain the IRQ line for the ADC.
> +  - clocks: phandles to clocks.
> +  - clock-names: tuple listing clock names.
> +      Required elements: "adc_clk", "adc_op_clk". "adc_clk" is the peripheral
> +      clock, "adc_clk" is the sampling clock.

I think we should not have adc_op_clk but rather have a property like
vf610 has fsl,adck-max-frequency.
Even better, would be the ability to change it with
/sys/bus/iio/devices/iio:deviceX/sampling_frequency


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
