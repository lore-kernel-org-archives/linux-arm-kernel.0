From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Dec 2016 12:01:32 -0600
Subject: [PATCH v2 2/2] dt-bindings: Add DT bindings info for FlexRM ring
 manager
In-Reply-To: <1480653536-5551-3-git-send-email-anup.patel@broadcom.com>
References: <1480653536-5551-1-git-send-email-anup.patel@broadcom.com>
 <1480653536-5551-3-git-send-email-anup.patel@broadcom.com>
Message-ID: <20161209180132.lnpvwybnij5uykuq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 10:08:56AM +0530, Anup Patel wrote:
> This patch adds device tree bindings document for the FlexRM
> ring manager found on Broadcom iProc SoCs.
> 
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
> new file mode 100644
> index 0000000..e81f116
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
> @@ -0,0 +1,60 @@

[...]

> +Example:
> +--------
> +crypto_mbox: mbox at 67000000 {
> +	compatible = "brcm,flexrm-mbox";
> +	reg = <0x67000000 0x200000>;
> +	msi-parent = <&gic_its 0x7f00>;
> +	#mbox-cells = <3>;
> +};
> +
> +crypto_client {
> +	...
> +	mboxes = <&crypto_mbox 0 0x1 0xffff>,
> +		 <&crypto_mbox 1 0x1 0xffff>,
> +		 <&crypto_mbox 16 0x1 0xffff>,
> +		 <&crypto_mbox 17 0x1 0xffff>,
> +		 <&crypto_mbox 30 0x1 0xffff>,
> +		 <&crypto_mbox 31 0x1 0xffff>;

The FlexRM part looks fine. I still don't understand what this node is. 
Is this a h/w block or just a list of mailboxes? What determines the 
mailbox channel numbers here? I need to see what the complete node looks 
like.

Rob
