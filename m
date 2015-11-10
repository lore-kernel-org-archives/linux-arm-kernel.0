From: robh@kernel.org (Rob Herring)
Date: Tue, 10 Nov 2015 08:15:02 -0600
Subject: [PATCH v3 2/3] Documentation: mailbox: Add APM X-Gene SLIMpro
 mailbox dts documentation
In-Reply-To: <6be192528afbcc604653a318994ee30fa05a0e05.1447091626.git.dhdang@apm.com>
References: <1429863912.2927.43.camel@x220>
 <cover.1447091625.git.dhdang@apm.com>
 <6be192528afbcc604653a318994ee30fa05a0e05.1447091626.git.dhdang@apm.com>
Message-ID: <20151110141502.GA14092@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 10:05:44AM -0800, Duc Dang wrote:
> This adds the APM X-Gene SLIMpro mailbox device tree
> node documentation.
> 
> [dhdang: rebase over 4.3-rc5]
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> ---
>  .../bindings/mailbox/xgene-slimpro-mailbox.txt     | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
> new file mode 100644
> index 0000000..d02a3d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
> @@ -0,0 +1,34 @@
> +The APM X-Gene SLIMpro mailbox is used to communicate messages between
> +the ARM64 processors and the Cortex M3 (dubbed SLIMpro). It uses a simple
> +interrupt based door bell mechanism and can exchange simple messages using the
> +internal registers.
> +
> +There are total of 7 interrupts in this mailbox. Each used for an individual
> +door bell (or mailbox channel).
> +
> +Required properties:
> +- compatible:	Should be as "apm, xgene-slimpro-mbox".
                                          ^
remove the space

> +
> +- reg:		Contain the mailbox register address range.

s/Contain/Contains/

> +
> +- interrupts:	7 interrupts must start from 0 to 6, interrupt 0 define the
> +		the interrupt for mailbox channel 0 and interrupt 1 for
> +		mailbox channel 1 and so likewise for the reminder.

s/start/be/

> +
> +- #mbox-cells:	only one to specify the mailbox channel number.
> +
> +Example:
> +
> +Mailbox Node:
> +		slimpro-mbox: slimpro-mbox at 10540000 {
> +			compatible = "apm,xgene-slimpro-mbox";
> +			reg = <0x0 0x10540000 0x0 0xa000>;
> +			#mbox-cells = <1>;
> +			interrupts =  	<0x0 0x0 0x4>,
> +					<0x0 0x1 0x4>,
> +					<0x0 0x2 0x4>,
> +					<0x0 0x3 0x4>,
> +					<0x0 0x4 0x4>,
> +					<0x0 0x5 0x4>,
> +					<0x0 0x6 0x4>,
> +		};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
