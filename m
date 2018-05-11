From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 May 2018 09:44:25 +0100
Subject: [RFC 1/2] documentation: Add nvmem bindings documentation
In-Reply-To: <20180324174638.12621-1-chinnikishore369@gmail.com>
References: <20180324174638.12621-1-chinnikishore369@gmail.com>
Message-ID: <4c6115db-2272-6d35-e220-be0f61b37cb0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




On 24/03/18 17:46, chinnikishore369 at gmail.com wrote:
> From: Nava kishore Manne <navam@xilinx.com>
> 
> This patch add the bindings document of zynqmp silicon id driver.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>

I see that you have not included DT maintainers in to/cc list, I can not 
accept new drivers whose bindings are not Acked/Reviewed by DT maintainers.

Overall the driver looks fine for me.


thanks,
srini


> ---
>   .../devicetree/bindings/nvmem/zynqmp_nvmem.txt     | 32 ++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
> new file mode 100644
> index 000000000000..94332f160a92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
> @@ -0,0 +1,32 @@
> +=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
> +
> +Required properties:
> +- compatible: should be "xlnx,zynqmp-nvmem-fw"
> +
> += Data cells =
> +Are child nodes of silicon id, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +	nvmem_firmware {
> +		compatible = "xlnx,zynqmp-nvmem-fw";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		 /* Data cells */
> +		soc_revision: soc_revision at 0 {
> +			reg = <0x0 0x4>;
> +		};
> +	};
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	pcap {
> +		...
> +		nvmem-cells = <&soc_revision>;
> +		nvmem-cell-names = "soc_revision";
> +	};
> 
