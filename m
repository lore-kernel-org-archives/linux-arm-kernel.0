From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 28 Mar 2014 16:35:24 -0500
Subject: [PATCH 1/2] dt/bindings: add binding for ARM Versatile
 character LCD
In-Reply-To: <1396041629-28820-1-git-send-email-robherring2@gmail.com>
References: <1396041629-28820-1-git-send-email-robherring2@gmail.com>
Message-ID: <1396042524.27583.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-03-28 at 16:20 -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Add binding doc for Versatile platforms character LCD controller
> interface.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/misc/arm-charlcd.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/arm-charlcd.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/arm-charlcd.txt b/Documentation/devicetree/bindings/misc/arm-charlcd.txt
> new file mode 100644
> index 0000000..e28e2aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/arm-charlcd.txt
> @@ -0,0 +1,18 @@
> +ARM Versatile Character LCD
> +-----------------------------------------------------
> +This binding defines the character LCD interface found on ARM Versatile AB
> +and PB reference platforms.
> +
> +Required properties:
> +- compatible : "arm,versatile-clcd"

Should this be "arm,versatile-lcd"?

Dinh
> +- reg : Location and size of character LCD registers
> +
> +Optional properties:
> +- interrupts - single interrupt for character LCD. The character LCD can
> +  operate in polled mode without an interrupt.
> +
> +Example:
> +	lcd at 10008000 {
> +		compatible = "arm,versatile-lcd";
> +		reg = <0x10008000 0x1000>;
> +	};
