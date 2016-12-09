From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Dec 2016 15:26:18 -0600
Subject: [PATCH v2 1/3] crypto: brcm: DT documentation for Broadcom SPU
 driver
In-Reply-To: <1480714499-1476-2-git-send-email-rob.rice@broadcom.com>
References: <1480714499-1476-1-git-send-email-rob.rice@broadcom.com>
 <1480714499-1476-2-git-send-email-rob.rice@broadcom.com>
Message-ID: <20161209212618.gvjdjhmryobrmwrp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 04:34:57PM -0500, Rob Rice wrote:
> Device tree documentation for Broadcom Secure Processing Unit
> (SPU) crypto driver.
> 
> Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
> Signed-off-by: Rob Rice <rob.rice@broadcom.com>
> ---
>  .../devicetree/bindings/crypto/brcm,spu-crypto.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt b/Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt
> new file mode 100644
> index 0000000..e5fe942
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt
> @@ -0,0 +1,25 @@
> +The Broadcom Secure Processing Unit (SPU) driver supports symmetric

Bindings describe h/w, not drivers.

> +cryptographic offload for Broadcom SoCs with SPU hardware. A SoC may have
> +multiple SPU hardware blocks.
> +
> +Required properties:
> +- compatible : Should be "brcm,spum-crypto" for devices with SPU-M hardware

Additionally, you should have SoC specific compatible here.

> +  (e.g., Northstar2) or "brcm,spum-nsp-crypto" for the Northstar Plus variant
> +  of the SPU-M hardware.
> +
> +- reg: Should contain SPU registers location and length.
> +- mboxes: A list of mailbox channels to be used by the kernel driver. Mailbox
> +channels correspond to DMA rings on the device.

What determines the mbox assignment?

Needs to specify how many.

> +
> +Example:
> +	spu-crypto at 612d0000 {

Just crypto at ...

Rob
