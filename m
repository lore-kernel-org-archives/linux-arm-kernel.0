From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 30 Aug 2017 15:30:59 +0200
Subject: [RESENT PATCH v7 3/7] arm64: dts: rockchip: Update rt5514
 devices' compatible for Gru
In-Reply-To: <20170824045227.15504-4-jeffy.chen@rock-chips.com>
References: <20170824045227.15504-1-jeffy.chen@rock-chips.com>
 <20170824045227.15504-4-jeffy.chen@rock-chips.com>
Message-ID: <1649093.IvC24TsujL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Am Donnerstag, 24. August 2017, 12:52:23 CEST schrieb Jeffy Chen:
> Currently the rt5514 i2c driver and rt5514 spi driver are using the same
> compatible string.
> 
> Add additional unused compatible strings to identify them for Gru
> boards.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi index
> 5772c52fbfd3..50fb11ad9f17 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -611,7 +611,7 @@ ap_i2c_mic: &i2c1 {
>  	i2c-scl-rising-time-ns = <300>;
> 
>  	headsetcodec: rt5514 at 57 {
> -		compatible = "realtek,rt5514";
> +		compatible = "realtek,rt5514", "realtek,rt5514-i2c";

the rt5514-i2c and -spi compatibles should be documented in the binding-txt
of the chip, but I haven't found any mention of this.


Heiko
