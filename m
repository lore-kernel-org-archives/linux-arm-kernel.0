From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Oct 2014 13:50:34 +0100
Subject: [PATCH v2 2/5] Documentation: DT: Add bindings for Spreadtrum
 Sharkl Platform
In-Reply-To: <1413539665-11484-3-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sprd-1017-v2>
 <1413539665-11484-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1413539665-11484-3-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20141017125033.GA5587@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 10:54:22AM +0100, Chunyan Zhang wrote:
> Adds Spreadtrum's prefix "sprd" to vendor-prefixes file.
> Adds the devicetree binding documentation for Spreadtrum's serial
> and Sharkl3 SoC based on the Sharkl Platform which is the 64-bit
> SoC Platform of Spreadtrum.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  Documentation/devicetree/bindings/arm/sprd.txt     |   11 +++++++++++
>  .../devicetree/bindings/serial/sprd-serial.txt     |    6 ++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  3 files changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/sprd-serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
> new file mode 100644
> index 0000000..40b40d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sprd.txt
> @@ -0,0 +1,11 @@
> +Spreadtrum Sharkl Platforms Device Tree Bindings
> +----------------------------------------------------
> +
> +Sharkl is a Spreadtrum's SoC Platform which is based
> +on ARM 64-bit processor.
> +
> +Sharkl3 FPGA board with Sharkl3 SoC based on the
> +Sharkl Platform shall have the following properties.
> +
> +Required root node properties:
> +        - compatible = "sprd,sharkl3-fpga", "sprd,sharkl3";
> diff --git a/Documentation/devicetree/bindings/serial/sprd-serial.txt b/Documentation/devicetree/bindings/serial/sprd-serial.txt
> new file mode 100644
> index 0000000..c97b0a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sprd-serial.txt
> @@ -0,0 +1,6 @@
> +* Spreadtrum serial UART
> +
> +Required properties:
> +- compatible: must be "sprd,serial"
> +- reg: offset and length of the register set for the device
> +- interrupts: exactly one interrupt specifier

I'm still a little wary of then name "sprd,serial". What was the first
device to feature this UART, if it doesn't have a specific name of its
own?

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..5dbf7db 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -129,6 +129,7 @@ smsc	Standard Microsystems Corporation
>  snps 	Synopsys, Inc.
>  solidrun	SolidRun
>  spansion	Spansion Inc.
> +sprd	Spreadtrum Communications Inc.
>  st	STMicroelectronics
>  ste	ST-Ericsson
>  stericsson	ST-Ericsson

The vendor prefix addition looks fine to me.

Thanks,
Mark.
