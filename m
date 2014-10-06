From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 6 Oct 2014 09:04:57 -0700
Subject: [PATCH v3 1/2] ARM: zynq: Add OCM controller driver
In-Reply-To: <e65e39088e0f571ee4905172f2f6c84dbc037805.1412599051.git.michal.simek@xilinx.com>
References: <e65e39088e0f571ee4905172f2f6c84dbc037805.1412599051.git.michal.simek@xilinx.com>
Message-ID: <2819cd94109f4192a6f6d68e90bc7b2c@BL2FFO11FD039.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-06 at 02:38PM +0200, Michal Simek wrote:
> The driver provide memory allocator which can
> be used by others drivers to allocate memory inside OCM.
> All location for 64kB blocks are supported
> and driver is trying to allocate the largest continuous
> block of memory.
> 
> Checking mpcore addressing filterring is not done here
> but could be added in future.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
[...]
> diff --git a/Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt b/Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt
> new file mode 100644
> index 000000000000..8ddbd1e5ffc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt
> @@ -0,0 +1,17 @@
> +Device tree bindings for Zynq's OCM controller
> +
> +The OCM is divided to 4 64kB segments which can be separately configured
> +to low or high location. Location is controlled via SLCR.
> +
> +Required properties:
> + compatible: Compatibility string. Must be "xlnx,zynq-ocmc-1.0".
> + reg: Specify the base and size of the OCMC registers in the memory map.
> +      E.g.: reg = <0xf800c000 0x1000>;
> +
> +Example:
> +ocmc: ocmc at f800c000 {

memory-controller at ...

> +	compatible =  "xlnx,zynq-ocmc-1.0";
> +	interrupt-parent = <&intc>;
> +	interrupts = <0 3 4>;
> +	reg = <0xf800c000 0x1000>;
> +} ;

	S?ren
