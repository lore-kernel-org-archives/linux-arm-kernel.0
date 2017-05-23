From: robh@kernel.org (Rob Herring)
Date: Mon, 22 May 2017 19:45:30 -0500
Subject: [PATCH 08/12] arm64: dts: hikey960: add WL1837 Bluetooth device
 node
In-Reply-To: <20170517083745.24479-9-guodong.xu@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-9-guodong.xu@linaro.org>
Message-ID: <20170523004530.c3yyjbws55hvnlc4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 04:37:41PM +0800, Guodong Xu wrote:
> This adds the serial slave device for the WL1837 Bluetooth interface.
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 513c496..69aa207 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -9,6 +9,7 @@
>  
>  #include "hi3660.dtsi"
>  #include "hikey960-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "HiKey960";
> @@ -55,6 +56,16 @@
>  	status = "okay";
>  };
>  
> +&uart4 {
> +	status = "okay";
> +	max-speed = <921600>;

This goes in the bluetooth node.

> +
> +	bluetooth {
> +		compatible = "ti,wl1837-st";
> +		enable-gpios = <&gpio15 6 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
>  &uart6 {
>  	status = "okay";
>  };
> -- 
> 2.10.2
> 
