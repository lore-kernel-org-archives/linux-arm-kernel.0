From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 11 Mar 2014 13:20:15 +0100
Subject: [PATCH 1/5] ARM: dts: exynos4x12: Add ADC's dt data to read raw
 data
In-Reply-To: <1394524494-30641-2-git-send-email-cw00.choi@samsung.com>
References: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
 <1394524494-30641-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <531EFF7F.9010405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 11.03.2014 08:54, Chanwoo Choi wrote:
> This patch add ADC(Analog to Digital Converter)'s dt data to get raw data
> with IIO subsystem. Usually, ADC is used to check temperature, jack type, and
> so on.
>

8< ---

> Register map
> - <0x126C0000 0x100> : ADC register's base address
> - <0x10020718 0x4> : ADC_PHY_CONTROL, TS-ADC control register address
>
> Clock
> - <&clock 326> : ADC clock (clock name :'tsadc')
>
> Interrupt
> - INTG10[3] : ADC for General ADC

--- >8

I don't think there is a need to include such data in commit message. A 
commit message should say what is done and why it's done (and sometimes 
how it's done, in case of some complex code being added) and I guess 
that's all.

>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4x12.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 5c412aa..5a3e551 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -80,6 +80,18 @@
>   		};
>   	};
>
> +	adc: adc at 126C0000 {
> +		compatible = "samsung,exynos-adc-v1";
> +		reg = <0x126C0000 0x100>, <0x10020718 0x4>;
> +		interrupt-parent = <&combiner>;
> +		interrupts = <10 3>;
> +		clocks = <&clock 326>;

Please use clock macros instead of numbers, as introduced by Andrzej 
Hajda's patches merged to Kgene's tree.

Best regards,
Tomasz
