From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Nov 2014 18:05:17 +0100
Subject: [PATCH 01/17] Documentation: dt-bindings: minimal documentation
 for MVEBU SDRAM controller
In-Reply-To: <1414151970-6626-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5457B5CD.1050706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

This binding looks coorect for me

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> The suspend/resume code for Armada XP has to modify certain registers
> of the SDRAM controller. Therefore, we need to define a Device Tree
> binding for this hardware block.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../memory-controllers/mvebu-sdram-controller.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> new file mode 100644
> index 0000000..89657d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> @@ -0,0 +1,21 @@
> +Device Tree bindings for MVEBU SDRAM controllers
> +
> +The Marvell EBU SoCs all have a SDRAM controller. The SDRAM controller
> +differs from one SoC variant to another, but they also share a number
> +of commonalities.
> +
> +For now, this Device Tree binding documentation only documents the
> +Armada XP SDRAM controller.
> +
> +Required properties:
> +
> + - compatible: for Armada XP, "marvell,armada-xp-sdram-controller"
> + - reg: a resource specifier for the register space, which should
> +   include all SDRAM controller registers as per the datasheet.
> +
> +Example:
> +
> +sdramc at 1400 {
> +	compatible = "marvell,armada-xp-sdram-controller";
> +	reg = <0x1400 0x500>;
> +};
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
