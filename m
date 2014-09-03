From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 03 Sep 2014 15:49:47 +0200
Subject: [PATCH v2 3/9] ARM: zynq: DT: Add DDRC node
In-Reply-To: <1409692754-13437-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
 <1409692754-13437-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <54071C7B.4090805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2014 11:19 PM, Soren Brinkmann wrote:
> Add the DDR controller to the Zynq devicetree.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/boot/dts/zynq-7000.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 6cc83d4c6c76..587cadcf7001 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -146,6 +146,11 @@
>   			cache-level = <2>;
>   		};
>
> +		memory-controller at f8006000 {
> +			compatible = "xlnx,zynq-ddrc-a05";
> +			reg = <0xf8006000 0x1000>;
> +		} ;
> +
>   		uart0: serial at e0000000 {
>   			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
>   			status = "disabled";
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
