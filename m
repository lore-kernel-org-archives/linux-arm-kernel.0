From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 15 Aug 2018 10:08:24 -0500
Subject: [PATCH] arm64: dts: stratix10: i2c clock running out of spec
In-Reply-To: <20180808154241.3760-1-atull@kernel.org>
References: <20180808154241.3760-1-atull@kernel.org>
Message-ID: <dd109cc6-00a8-244b-07e9-97e29739d804@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/08/2018 10:42 AM, Alan Tull wrote:
> DesignWare I2C controller was observed running at 105.93kHz rather
> than the specified 100kHz.  Adjust device tree settings to bring it
> within spec (a slightly conservative 98 MHz).
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 6edc4fa..53cf195 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -124,6 +124,8 @@
>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <100000>;
> +	i2c-sda-falling-time-ns = <890>;  /* hcnt */
> +	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
>  
>  	adc at 14 {
>  		compatible = "lltc,ltc2497";
> 

Applied!

Thanks,
Dinh
