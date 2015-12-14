From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Dec 2015 10:05:51 +0000
Subject: [PATCH v4 3/4] ARM: dts: lpc18xx: add EEPROM memory node
In-Reply-To: <1447790576-29410-4-git-send-email-ariel@vanguardiasur.com.ar>
References: <1447790576-29410-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1447790576-29410-4-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <566E947F.2030805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

Could you take this DT patches via your tree, I picked up the nvmem patches.

thanks,
srini


On 17/11/15 20:02, Ariel D'Alessandro wrote:
> Add node for the NXP LPC18xx EEPROM memory which can be found in
> NXP LPC185x/3x and LPC435x/3x/2x/1x devices.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> ---
>   arch/arm/boot/dts/lpc18xx.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
> index 52591d8..43e99cf 100644
> --- a/arch/arm/boot/dts/lpc18xx.dtsi
> +++ b/arch/arm/boot/dts/lpc18xx.dtsi
> @@ -166,6 +166,18 @@
>   			status = "disabled";
>   		};
>
> +		eeprom: eeprom at 4000e000 {
> +			compatible = "nxp,lpc1857-eeprom";
> +			reg =	<0x4000e000 0x1000>,
> +				<0x20040000 0x4000>;
> +			reg-names = "reg", "mem";
> +			clocks = <&ccu1 CLK_CPU_EEPROM>;
> +			clock-names = "eeprom";
> +			resets = <&rgu 27>;
> +			interrupts = <4>;
> +			status = "disabled";
> +		};
> +
>   		mac: ethernet at 40010000 {
>   			compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
>   			reg = <0x40010000 0x2000>;
>
