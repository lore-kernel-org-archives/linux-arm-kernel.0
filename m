From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 14 Jun 2016 15:42:15 +0100
Subject: [PATCH RESEND 1/3] dt-bindings: add bindings documentation for
 PDC driver.
In-Reply-To: <1465912965-35500-2-git-send-email-rob.rice@broadcom.com>
References: <1465912965-35500-1-git-send-email-rob.rice@broadcom.com>
 <1465912965-35500-2-git-send-email-rob.rice@broadcom.com>
Message-ID: <576017C7.50609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/06/16 15:02, Rob Rice wrote:
> From: Rob Rice <rrice@broadcom.com>
>
> Add the device tree binding documentation for the PDC hardware
> in Broadcom iProc SoCs.
>
> Signed-off-by: Rob Rice <rob.rice@broadcom.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       | 23 ++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
>
> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
> new file mode 100644
> index 0000000..411ccf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
> @@ -0,0 +1,23 @@
> +The PDC driver manages data transfer to and from various offload engines
> +on some Broadcom SoCs. An SoC may have multiple PDC hardware blocks. There is
> +one device tree entry per block.
> +
> +Required properties:
> +- compatible : Should be "brcm,iproc-pdc-mbox".
> +- reg: Should contain PDC registers location and length.
> +- interrupts: Should contain the IRQ line for the PDC.
> +- #mbox-cells: 1
> +- brcm,rx-status-len: Length of metadata preceding received frames, in bytes.
> +

Ideally the metadata is more associated with the software protocol built
on top of the mailbox controller.

Is this metadata added by the hardware ?

Otherwise it's better to make it part of the protocol rather than the
associating with the controller.

> +Optional properties:
> +- brcm,use-bcm-hdr:  present if a BCM header precedes each frame.
> +

Same here.

-- 
Regards,
Sudeep
