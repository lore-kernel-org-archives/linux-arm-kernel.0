From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 11:50:21 +0000
Subject: [PATCH 2/5] ARM: STi: DT: add keyscan for stih415
In-Reply-To: <1393990772-9567-3-git-send-email-gabriel.fernandez@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20140310115021.GP14976@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Giuseppe CONDORELLI <giuseppe.condorelli@st.com>
> 
> Add keyscan support for stih415.
> It is put disabled by default because it is not enabled on all boards
> Also there are PIOs conflict with already claimed lines.
> 
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stih415-pinctrl.dtsi | 16 ++++++++++++++++
>  arch/arm/boot/dts/stih415.dtsi         | 10 ++++++++++
>  2 files changed, 26 insertions(+)

<snip>

> +		keyscan: keyscan at fe4b0000 {
> +			compatible = "st,keypad";
> +			status = "disabled";
> +			reg = <0xfe4b0000 0x2000>;
> +			interrupts = <GIC_SPI 212 IRQ_TYPE_NONE>;
> +			clocks	= <&CLK_SYSIN>;
> +			pinctrl-names	= "default";

Small nit here, but otherwise:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> +			pinctrl-0 = <&pinctrl_keyscan>;
> +		};
>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
