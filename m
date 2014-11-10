From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Mon, 10 Nov 2014 20:05:42 +0100
Subject: [PATCH v2 2/2] arm64: Add Juno SoC device tree.
In-Reply-To: <1415618875-8469-3-git-send-email-Liviu.Dudau@arm.com>
References: <1415618875-8469-1-git-send-email-Liviu.Dudau@arm.com>
 <1415618875-8469-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <54610C86.9090002@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 10.11.2014 um 12:27 schrieb Liviu Dudau:
> diff --git a/arch/arm64/boot/dts/juno.dts b/arch/arm64/boot/dts/juno.dts
> new file mode 100644
> index 0000000..7f998de
> --- /dev/null
> +++ b/arch/arm64/boot/dts/juno.dts
> @@ -0,0 +1,374 @@
> +/*
> + * ARM Ltd. Juno Plaform

"Platform"

> + *

Shouldn't this mention a license, ideally dual-licensed?

> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "Juno";
> +	compatible = "arm,juno", "arm,vexpress";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &soc_uart0;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		A53_0:cpu at 100 {
[snip]

Can you please add a space after colon, like you did for non-CPU nodes?

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
