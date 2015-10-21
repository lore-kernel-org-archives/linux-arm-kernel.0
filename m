From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 10:07:59 +0100
Subject: [PATCH v3 2/2] ARM: dts: bcm5301x: Add BCM SVK DT files
In-Reply-To: <1444947856-26246-2-git-send-email-jonmason@broadcom.com>
References: <1444947856-26246-1-git-send-email-jonmason@broadcom.com>
 <1444947856-26246-2-git-send-email-jonmason@broadcom.com>
Message-ID: <562755EF.5000803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/10/15 23:24, Jon Mason wrote:
> Add device tree files for Broadcom Northstar based SVKs.  Since the
> bcm5301x.dtsi already exists, all that is necessary is the dts files to
> enable the UARTs.  With these files, the SVKs are able to boot to shell.
>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>

[..]

> diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/bcm94708.dts
> new file mode 100644
> index 0000000..49682d6
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm94708.dts
> @@ -0,0 +1,56 @@

[..]

> +/dts-v1/;
> +
> +#include "bcm4708.dtsi"
> +
> +/ {
> +	model = "NorthStar SVK (BCM94708)";
> +	compatible = "brcm,bcm94708", "brcm,bcm4708";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";

You can set stdout-path instead which even works for earlycon

-- 
Regards,
Sudeep
