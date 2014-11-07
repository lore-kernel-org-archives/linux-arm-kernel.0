From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 06 Nov 2014 22:42:47 -0800
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <545C694D.1030204@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
 <545C694D.1030204@gmail.com>
Message-ID: <545C69E7.6010909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2014 10:40 PM, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
> 
> Update msm8974 dtsi for msm_serial to reflect msm_serial_probe()
> getting line id from the serial alias.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: b/arch/arm/boot/dts/qcom-msm8974.dtsi
> ===================================================================
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -9,6 +9,10 @@
>  	compatible = "qcom,msm8974";
>  	interrupt-parent = <&intc>;
>  
> +	aliases {
> +		serial0 = &serial0;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -189,7 +193,7 @@
>  			reg = <0xfd8c0000 0x6000>;
>  		};
>  
> -		serial at f991e000 {
> +		serial0: serial at f991e000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0xf991e000 0x1000>;
>  			interrupts = <0 108 0x0>;
> 

This same change is also needed in:

  qcom-ipq8064.dtsi
  qcom-msm8960.dtsi
  qcom-apq8084.dtsi
  qcom-apq8064.dtsi
  qcom-msm8660.dtsi

but I did not want to just blindly apply those changes without testing.

-Frank
