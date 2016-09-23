From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 08:39:49 -0500
Subject: [PATCH 2/3] firmware: dt: document lpc1850 boot ROM bindings
In-Reply-To: <20160913195117.2887-3-manabian@gmail.com>
References: <20160913195117.2887-1-manabian@gmail.com>
 <20160913195117.2887-3-manabian@gmail.com>
Message-ID: <20160923133949.GA24505@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 09:51:16PM +0200, Joachim Eastwood wrote:
> Binding documentation for the NXP LPC boot ROM.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../devicetree/bindings/firmware/nxp,boot-rom.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt b/Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt
> new file mode 100644
> index 0000000..5f3a044
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt
> @@ -0,0 +1,21 @@
> +* NXP LPC boot ROM
> +
> +NXP LPC microcontrollers contains a boot ROM used to retrieve part information
> +and access internal Flash memory and OTP memory. Note that the Flash API is
> +not available on Flashless devices.

Is this determined at run-time? If not flashless devices should have a 
different compatible string to determine this then.

> +
> +Required properties:
> +- compatible: must contain the following: "nxp,lpc1850-boot-rom".
> +- reg: physical base address of the ROM and length of memory mapped region.
> +- syscon: handle to NXP CREG (Configuration Registers) syscon block.
> +- nvmem-cells: = handle to OTP memory cell which contain the part ID.
> +- nvmem-cell-names: must contain "PartID".
> +
> +Example:
> +boot_rom: firmware at 10400000 {
> +	compatible = "nxp,lpc1850-boot-rom";
> +	reg = <0x10400000 0x10000>;
> +	syscon = <&creg>;
> +	nvmem-cells = <&part_id>;
> +	nvmem-cell-names = "PartID";
> +};
> -- 
> 2.9.3
> 
