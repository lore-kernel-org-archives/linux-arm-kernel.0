From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Jan 2013 14:48:41 +0000
Subject: [PATCH 5/6] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <1358039458-31960-6-git-send-email-tomasz.figa@gmail.com>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
 <1358039458-31960-6-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130114144841.GE7990@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This all looks good. I just have a couple of comments about the cpus node.

On Sun, Jan 13, 2013 at 01:10:57AM +0000, Tomasz Figa wrote:
> This patch adds basic device tree definitions for Samsung S3C64xx SoCs.
> 
> Since all the SoCs in the series are very similar, the files are created
> hierarchically - one file for the whole series and then separate files
> for particular SoCs including the common one.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

[...]

> diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
> new file mode 100644
> index 0000000..55d6e08
> --- /dev/null
> +++ b/arch/arm/boot/dts/s3c64xx.dtsi
> @@ -0,0 +1,97 @@
> +/*
> + * Samsung's S3C64xx SoC series common device tree source
> + *
> + * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
> + *
> + * Samsung's S3C64xx SoC series device nodes are listed in this file.
> + * Particular SoCs from S3C64xx series can include this file and provide
> + * values for SoCs specfic bindings.
> + *
> + * Note: This file does not include device nodes for all the controllers in
> + * S3C64xx SoCs. As device tree coverage for S3C64xx increases, additional
> + * nodes can be added to this file.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,arm1176jzf-s";
> +		};
> +	};

You can drop the unit address from the cpu node - it's meant to be there to
differentiate multiple nodes (and is supposed to match the reg property, which
the 1176jzf-s can't have, as it doesn't have an MPIDR).

Also, "arm,arm1176jzf-s" isn't listed in the binding doc. There was a question
about how to maintain this list [1], but I can't seem to find a conclusion, if
any were reached.  It might be worth appending "arm,arm1176" to the compatible
list for the cpu node in case we want to enable something via dt for all 1176
variations.

Dave, Lorenzo, any thoughts?

[...]

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/131362.html
