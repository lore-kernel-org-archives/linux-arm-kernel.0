From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Apr 2016 09:03:38 -0500
Subject: [PATCH] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <1460360506-14692-1-git-send-email-navam@xilinx.com>
References: <1460360506-14692-1-git-send-email-navam@xilinx.com>
Message-ID: <20160412140338.GA19311@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 01:11:46PM +0530, Nava kishore Manne wrote:
> This patch updates the driver to support 64-bit DMA
> addressing.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>  .../devicetree/bindings/usb/udc-xilinx.txt         |  3 +-
>  drivers/usb/gadget/udc/udc-xilinx.c                | 38 ++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> index 47b4e39..d417872 100644
> --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> @@ -7,12 +7,13 @@ Required properties:
>  - interrupts		: Should contain single irq line of USB2 device
>  			  controller
>  - xlnx,has-builtin-dma	: if DMA is included
> -
> +- xlnx,addrwidth       : Should be the dma addressing size in bits(ex: 40 bits).

Now this property shows up in a 2nd device. Now I'm more convinced this 
is the wrong approach and should use dma-ranges.

Rob
