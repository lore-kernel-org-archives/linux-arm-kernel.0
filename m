From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Aug 2015 15:57:59 +0100
Subject: [PATCH v8 4/4] nvmem: Add DT binding documentation for Vybrid
 OCOTP driver
In-Reply-To: <3149879671b1b1b0b6fc1fbe62e9f49333deb8ed.1439214648.git.maitysanchayan@gmail.com>
References: <cover.1439214648.git.maitysanchayan@gmail.com>
 <3149879671b1b1b0b6fc1fbe62e9f49333deb8ed.1439214648.git.maitysanchayan@gmail.com>
Message-ID: <55C8BBF7.30308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/15 15:11, Sanchayan Maity wrote:
> Add the devicetree bindings for the Freescale Vybrid On-Chip
> OTP driver.
>
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>   .../devicetree/bindings/nvmem/vf610-ocotp.txt       | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> diff --git a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> new file mode 100644
> index 0000000..b29f65f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> @@ -0,0 +1,21 @@
> +On-Chip OTP Memory for Freescale Vybrid
> +
> +Required Properties:
> +  compatible:
> +  - "fsl,vf610-ocotp" for VF5xx/VF6xx
> +  #address-cells : Should be 1
> +  #size-cells : Should be 1
> +  reg : Address and length of OTP controller and fuse map registers
> +  clocks : ipg clock we associate with the OCOTP peripheral
> +  clock-names : Must contain "ocotp" as matching entry
> +
> +Example for Vybrid VF5xx/VF6xx:
> +
> +	ocotp: ocotp at 400a5000 {
> +		compatible = "fsl,vf610-ocotp";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x400a5000 0xCF0>;
> +		clocks = <&clks VF610_CLK_OCOTP>;
> +		clock-names = "ocotp";
> +	};
>
