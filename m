From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 14 Sep 2018 14:25:53 +0200
Subject: [PATCH] ARM: dts: stm32: Fix SPI controller node names
In-Reply-To: <20180913181245.25484-11-robh@kernel.org>
References: <20180913181245.25484-11-robh@kernel.org>
Message-ID: <3b90da6c-e375-77e4-40c8-cfce68582c4a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/13/2018 08:12 PM, Rob Herring wrote:
> SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
> name enables dtc SPI bus checks.
> 
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but
> will for 4.20.

Thanks Rob. I will add it in my next PR for 4.20.

> 
>   arch/arm/boot/dts/stm32mp157c.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 661be948ab74..0e5a2f89f2d9 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -947,7 +947,7 @@
>   			dma-requests = <48>;
>   		};
>   
> -		qspi: qspi at 58003000 {
> +		qspi: spi at 58003000 {
>   			compatible = "st,stm32f469-qspi";
>   			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
>   			reg-names = "qspi", "qspi_mm";
> 
