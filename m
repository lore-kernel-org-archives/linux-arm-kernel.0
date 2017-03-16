From: robh@kernel.org (Rob Herring)
Date: Thu, 16 Mar 2017 16:12:26 -0500
Subject: [PATCH v4 1/3] usb: orion-echi: Add support for the Armada 3700
In-Reply-To: <20170309175258.20076-2-gregory.clement@free-electrons.com>
References: <20170309175258.20076-1-gregory.clement@free-electrons.com>
 <20170309175258.20076-2-gregory.clement@free-electrons.com>
Message-ID: <20170316211226.krnhlrwk3gd3qpce@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 06:52:56PM +0100, Gregory CLEMENT wrote:
> From: Hua Jing <jinghua@marvell.com>

s/echi/ehci/ in the subject.

> 
> - Add a new compatible string for the Armada 3700 SoCs
> 
> - add sbuscfg support for orion usb controller driver. For the SoCs
>   without hlock, need to program BAWR/BARD/AHBBRST fields in the sbuscfg
>   register to guarantee the AHB master's burst would not overrun or
>   underrun the FIFO.
> 
> - the sbuscfg register has to be set after the usb controller reset,
>   otherwise the value would be overridden to 0. In order to do this, the
>   reset callback is registered.
> 
> [gregory.clement at free-electrons.com: - reword commit and comments
> 				     - fix error path in ehci_orion_drv_reset()
> 				     - fix checkpatch warning]
> Signed-off-by: Hua Jing <jinghua@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/usb/ehci-orion.txt         |  4 ++-

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/usb/host/ehci-orion.c                      | 36 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
