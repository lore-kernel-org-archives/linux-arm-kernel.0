From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 15 Sep 2014 15:26:55 +0200
Subject: [PATCH] ARM: zynq: Add ISL9305 regulator on Parallella board
In-Reply-To: <1410003616-32077-1-git-send-email-broonie@kernel.org>
References: <1410003616-32077-1-git-send-email-broonie@kernel.org>
Message-ID: <5999bc23-b615-4b76-acec-ba2ee5675a03@BN1AFFO11FD035.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2014 01:40 PM, Mark Brown wrote:
> There is an ISL9305 regulator on the Parallella board, add it to the DT
> along with descriptions of all the supplies.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm/boot/dts/zynq-parallella.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
> index 41afd9da6876..43ca89fb92e4 100644
> --- a/arch/arm/boot/dts/zynq-parallella.dts
> +++ b/arch/arm/boot/dts/zynq-parallella.dts
> @@ -53,6 +53,29 @@
>  
>  &i2c0 {
>  	status = "okay";
> +
> +	isl9305: isl9305 at 68 {
> +		compatible = "isl,isl9305";
> +		reg = <0x68>;
> +
> +		regulators {
> +			dcd1 {
> +				regulator-name = "VDD_DSP";
> +				regulator-always-on;
> +			};
> +			dcd2 {
> +				regulator-name = "1P35V";
> +				regulator-always-on;
> +			};
> +			ldo1 {
> +				regulator-name = "VDD_ADJ";
> +			};
> +			ldo2 {
> +				regulator-name = "VDD_GPIO";
> +				regulator-always-on;
> +			};
> +		};
> +	};
>  };
>  
>  &sdhci1 {
> 

Applied.

Thanks,
Michal


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/e6fab1ba/attachment.sig>
