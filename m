From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Jun 2016 08:22:57 -0500
Subject: [PATCH 1/2] Documentation: bindings: Add DT bindings for ARM's
 FVP models.
In-Reply-To: <1466424796-13769-1-git-send-email-tixy@linaro.org>
References: <1466424796-13769-1-git-send-email-tixy@linaro.org>
Message-ID: <20160621132257.GA2263@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 01:13:15PM +0100, Jon Medhurst wrote:
> List the required properties used to describe ARM's FVP models.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/arm-boards | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
> index ab318a5..4639a9b 100644
> --- a/Documentation/devicetree/bindings/arm/arm-boards
> +++ b/Documentation/devicetree/bindings/arm/arm-boards
> @@ -234,3 +234,24 @@ Example:
>  	};
>  
>  };
> +
> +ARM Fixed Virtual Platforms (FVP)
> +---------------------------------
> +FVPs are simulated platforms produced by ARM to aid software development without
> +the requirement for actual hardware. They come in several families, each of
> +which (usually) contain variants for different configurations of simulated
> +hardware. These are documented in the Fixed Virtual Platforms FVP Reference
> +Guide (reference number ARM DUI0837H).
> +
> +Required properties (in root node):
> +- compatible value:
> +	compatible = "arm,<family>,<variant>", "arm,<family>";
> +  where <family> is one of:
> +  - "fvp-base" for the Base FVP
> +  - "fvp-ve" for the VE FVP
> +  and <variant> is the part of the model's executable filename with the family
> +  name omitted, converted to lower case, and with non-alphanumeric characters
> +  replaced with '-'. E.g. the Base FVP that has two AEMv8 CPU clusters has an
> +  executable file called FVP_Base_AEMv8A-AEMv8A, so the compatible value for

Naming conventions of the exe aren't going to change?

> +  this would be:
> +	compatible = "arm,fvp-base,aemv8a-aemv8a", "arm,fvp-base";
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
