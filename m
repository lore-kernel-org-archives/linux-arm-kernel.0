From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Dec 2015 20:53:18 -0600
Subject: [PATCH v4 2/2] arm: pxa27x: support for ICP DAS LP-8x4x w/ DT
In-Reply-To: <1449700088-28076-3-git-send-email-ynvich@gmail.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1449700088-28076-1-git-send-email-ynvich@gmail.com>
 <1449700088-28076-3-git-send-email-ynvich@gmail.com>
Message-ID: <20151211025318.GA1000@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 01:28:08AM +0300, Sergei Ianovich wrote:
> ICP DAS calls LP-8x4x 'programmable automation controller'. It is
> an industrial computer based on PXA270 SoC. They ship it with a 2.6.19
> kernel and proprietary kernel module and userspace library to access
> its industrial IO.

2 comments, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> diff --git a/arch/arm/boot/dts/pxa27x-lp8x4x.dts b/arch/arm/boot/dts/pxa27x-lp8x4x.dts
> new file mode 100644
> index 0000000..bbb5b75
> --- /dev/null
> +++ b/arch/arm/boot/dts/pxa27x-lp8x4x.dts
> @@ -0,0 +1,260 @@
> +/* Device tree for ICP DAS LP-8x4x */
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

Pretty sure this does not have a GIC.

> +#include "pxa27x.dtsi"
> +
> +/ {
> +	model = "ICP DAS LP-8x4x programmable automation controller";
> +	compatible = "marvell,pxa270";

You should have a compatible string for this board.

Rob
