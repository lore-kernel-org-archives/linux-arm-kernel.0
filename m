From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Mar 2015 19:46:03 +0100
Subject: [patch 6/7] dt: dtb version: dtsi files
In-Reply-To: <550A44F9.9060504@gmail.com>
References: <550A42AC.8060104@gmail.com>
 <550A44F9.9060504@gmail.com>
Message-ID: <20150319184603.GA4946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 08:39:37PM -0700, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
> 
> Create a .dtsi file to contain the /chosen/dtb-info node and populate the
> properties in that node.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  arch/arm/boot/dts/skeleton.dtsi              |    2 
>  include/dt-bindings/version.dtsi             |   19 +++++
> 
> Index: b/include/dt-bindings/version.dtsi
> ===================================================================
> --- /dev/null
> +++ b/include/dt-bindings/version.dtsi
> @@ -0,0 +1,19 @@
> +
> +#include <utsrelease.h>
> +#include <compile.h>
> +#include <compile_dtb.h>
> +
> +/ {
> +	chosen {
> +		dtb-info {
> +			version = UTS_RELEASE, " ", DTB_VERSION;
> +			version-linux =
> +				UTS_RELEASE,
> +				" (", LINUX_COMPILE_BY, "@", LINUX_COMPILE_HOST, ") ",
> +				"(", LINUX_COMPILER, ") ",
> +				UTS_VERSION;
> +			dtb-path = ___DTB_DTB_PATH;
> +			dts-path = ___DTB_DTS_PATH;
> +		};
> +	};
> +};

People are working on reproducible builds to be able to build bit
identical packages for a whole Distribution [1]. While I don't know
how feasible this really is I think we should not actively work on making
that impossible. The people working on reproducible builds state that
timestamps in binaries are bad, because when you can reproduce it it
doesn't matter if it was build yesterday or a decade ago.

Like others already said for security reasons (and also for
reproducibility) I don't want to leak the pathes or machine names I use to
build dtbs into the binaries.

So all this should at least be configurable.

Sascha

[1] https://wiki.debian.org/ReproducibleBuilds

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
