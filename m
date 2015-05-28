From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 May 2015 07:30:22 +0200
Subject: [PATCHv2 1/2] dts: Adding docs for Xilinx LogiCORE IP mailbox
 driver.
In-Reply-To: <1432751745-17473-2-git-send-email-moritz.fischer@ettus.com>
References: <1432751745-17473-1-git-send-email-moritz.fischer@ettus.com>
 <1432751745-17473-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <5566A7EE.9020304@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2015 08:35 PM, Moritz Fischer wrote:
> Changes from v1:
> - Added common clock framework support
> 
> Changes from v0:
> - Fixed example bindings
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  .../bindings/mailbox/xilinx-mailbox.txt         | 44 ++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> new file mode 100644
> index 0000000..50d0e5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> @@ -0,0 +1,44 @@
> +Xilinx Mailbox Driver
> +=====================
> +
> +Required properties:
> +- compatible       : "xlnx,mailbox-2.1".
> +- reg              :  physical base address of the mailbox and length of
> +                      memory mapped region.

remove dot at the end - it is not a sentence.

> +- #mbox-cells      :  Common mailbox binding property to identify the number
> +                      of cells required for the mailbox specifier. Should be 1.

use small letters as you use in the whole description and remove dots.

> +- clocks           :  phandle to clock provider
> +- clock-names      :  must be 'mbox'
> +
> +Optional properties:
> +- interrupt-parent : interrupt source phandle.
> +- interrupts       : interrupt number. The interrupt specifier format
> +                     depends on the interrupt controller parent.
> +
> +Example:
> +	mbox: mailbox at 40400000 {
> +		compatible = "xlnx,axi-mailbox-2.1";
> +		reg = <0x40400000 0x3c>;

It is just example but I don't think that you can select in vivado size
only 0x3c. That's actual size of regs right?

Thanks,
Michal
