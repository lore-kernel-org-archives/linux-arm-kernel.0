From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 18 Mar 2012 13:43:32 +0800
Subject: [RFC/PATCH 4/4] pxa: convert to common clock framework
In-Reply-To: <1331919483.31118.23.camel@flow>
References: <1331919483.31118.23.camel@flow>
Message-ID: <20120318054329.GA29638@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Your patch #2 is trying to avoid the layering violation by separating
static clock definitions and from clk_ops implementations into
different files.  But ...

On Fri, Mar 16, 2012 at 06:38:03PM +0100, Philipp Zabel wrote:
...
> diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
> index a3585a2..7c04f9b 100644
> --- a/arch/arm/mach-pxa/clock.h
> +++ b/arch/arm/mach-pxa/clock.h
> @@ -1,80 +1,106 @@
>  #include <linux/clkdev.h>
> +#include <linux/clk-private.h>

... This is what I read from clk-private.h.

/*
 * WARNING: Do not include clk-private.h from any file that implements struct
 * clk_ops.  Doing so is a layering violation!
 *
 * ...
 */

And you include it in arch/arm/mach-pxa/clock.h which in turn is being
included by the pxa clock files implementing clk_ops.

> +#include <linux/clk-provider.h>
>  #include <linux/syscore_ops.h>

Regards,
Shawn
