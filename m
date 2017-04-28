From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 15:53:58 -0500
Subject: [PATCH v3 1/2] ASoC: stm32: add bindings for SAI
In-Reply-To: <1491837596-2924-2-git-send-email-olivier.moysan@st.com>
References: <1491837596-2924-1-git-send-email-olivier.moysan@st.com>
 <1491837596-2924-2-git-send-email-olivier.moysan@st.com>
Message-ID: <20170428205358.fxjqaki44xqim4ta@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 05:19:55PM +0200, olivier moysan wrote:
> This patch adds documentation of device tree bindings for the
> STM32 SAI ASoC driver.
> 
> Signed-off-by: olivier moysan <olivier.moysan@st.com>
> ---
>  .../devicetree/bindings/sound/st,stm32-sai.txt     | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> new file mode 100644
> index 0000000..c59a3d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> @@ -0,0 +1,89 @@
> +STMicroelectronics STM32 Serial Audio Interface (SAI).

[...]

> +	sai1b: audio-controller at 40015824 {
> +		#sound-dai-cells = <0>;
> +		compatible = "st,stm32-sai-sub-b";
> +		reg = <0x40015824 0x1C>;
> +		clocks = <&rcc 1 CLK_SAI2>;
> +		clock-names = "sai_ck";
> +		dmas = <&dma2 5 0 0x400 0x0>;
> +		dma-names = "tx";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sai1b>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			sai1b_port: port at 0 {
> +				reg = <0>;
> +				cpu_endpoint: endpoint {
> +					remote-endpoint = <&codec_endpoint>;
> +					audio-graph-card,format = "i2s";
> +					audio-graph-card,bitclock-master = <&codec_endpoint>;
> +					audio-graph-card,frame-master = <&codec_endpoint>;

These property names are wrong.

> +				};
> +			};
> +		};
> +	};
> +};
> +
> +audio-codec {
> +	codec_port: port {
> +		codec_endpoint: endpoint {
> +			remote-endpoint = <&cpu_endpoint>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
