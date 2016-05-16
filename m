From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 09:59:22 -0500
Subject: [PATCH v8 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <1462961588-23004-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1462961588-23004-1-git-send-email-boris.brezillon@free-electrons.com>
 <1462961588-23004-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160516145922.GA2133@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 12:13:08PM +0200, Boris Brezillon wrote:
> The EBI (External Bus Interface) is used to access external peripherals
> (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> Each device is assigned a CS line and an address range and can have its
> own configuration (timings, access mode, bus width, ...).
> This driver provides a generic DT binding to configure a device according
> to its requirements.
> For specific device controllers (like the NAND one) the SMC timings
> should be configured by the controller driver through the matrix and smc
> syscon regmaps.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../bindings/memory-controllers/atmel,ebi.txt      | 136 +++++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> new file mode 100644
> index 0000000..2fe9b5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> @@ -0,0 +1,136 @@

[...]

> +Children device nodes are representing device connected to the EBI bus.
> +
> +Required device node properties:
> +
> +- #reg:			Contains the chip-select id, the offset and the length

Still need to fix #reg.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
