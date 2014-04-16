From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Apr 2014 13:49:34 +0200
Subject: [PATCHv3 2/2] iio: devicetree: Add DT binding documentation for
 Exynos3250 ADC
In-Reply-To: <1397643118-6934-3-git-send-email-cw00.choi@samsung.com>
References: <1397643118-6934-1-git-send-email-cw00.choi@samsung.com>
 <1397643118-6934-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <534E6E4E.4020807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 16.04.2014 12:11, Chanwoo Choi wrote:
> This patch add DT binding documentation for Exynos3250 ADC IP. Exynos3250 has
> special clock ('sclk_tsadc') for ADC which provide clock to internal ADC.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   .../devicetree/bindings/arm/samsung/exynos-adc.txt   | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> index 5d49f2b..7532ec3 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> @@ -14,6 +14,8 @@ Required properties:
>   				for exynos4412/5250 controllers.
>   			Must be "samsung,exynos-adc-v2" for
>   				future controllers.
> +			Must be "samsung,exynos-adc-v3" for
> +				for exynos3250 controllers.

I don't think adc-v3 is correct here. It looks like a normal V2 with 
additional special clock input. Possibly "samsung,exynos3250-adc-v2" or 
"samsung,exynos-adc-v2-sclk" would be better choices.

>   - reg:			Contains ADC register address range (base address and
>   			length) and the address of the phy enable register.
>   - interrupts: 		Contains the interrupt information for the timer. The
> @@ -21,7 +23,11 @@ Required properties:
>   			the Samsung device uses.
>   - #io-channel-cells = <1>; As ADC has multiple outputs
>   - clocks		From common clock binding: handle to adc clock.
> +			From common clock binding: handle to sclk_tsadc clock
> +			if using Exynos3250.
>   - clock-names		From common clock binding: Shall be "adc".
> +			From common clock binding: Shall be "sclk_tsadc"
> +			if using Exynos3250.
>   - vdd-supply		VDD input supply.
>
>   Note: child nodes can be added for auto probing from device tree.
> @@ -41,6 +47,20 @@ adc: adc at 12D10000 {
>   	vdd-supply = <&buck5_reg>;
>   };
>
> +If Exynos3250 uses ADC,

Please keep proper formatting:

Example: Node for ADC of Exynos3250 with additional special clock

Best regards,
Tomasz
