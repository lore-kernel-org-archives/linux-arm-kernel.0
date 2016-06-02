From: robh@kernel.org (Rob Herring)
Date: Thu, 2 Jun 2016 17:58:15 -0500
Subject: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <1464626798-1334-1-git-send-email-navam@xilinx.com>
References: <1464626798-1334-1-git-send-email-navam@xilinx.com>
Message-ID: <20160602225815.GA5508@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 10:16:38PM +0530, Nava kishore Manne wrote:
> This patch updates the driver to support 64-bit DMA addressing.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
> Changes for v4:
> 		-Used boolen property insted of addrwith property in the DT
> 		 as suggested by Arnd Bergmann.
> 		-Adopt the DT relevant changes into the driver.
> 
> Changes for v3:
>                 -Added new compatable string for 5.00 IP version as suggested by
>                  Arnd Bergmann.
>                 -Used write_fn() insted of lo_hi_writeq() as suggested by
>                  Arnd Bergmann.
> 
> Changes for v2:
>                 -Added dma-ranges property in device tree as suggested by Arnd Bergmann.
>                 -Modified the driver code based on the xlnx,addrwidth.
> 
>  .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/usb/gadget/udc/udc-xilinx.c                | 52 +++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 3 deletions(-)
