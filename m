From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 3 Jul 2018 09:21:07 +0200
Subject: [PATCH 2/3] clk: meson: add sub EMMC clock dt-bindings IDs
In-Reply-To: <20180703145716.31860-3-yixun.lan@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-3-yixun.lan@amlogic.com>
Message-ID: <20180703092107.51497a8f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2018 14:57:15 +0000
Yixun Lan <yixun.lan@amlogic.com> wrote:

> Add two clock bindings IDs which provided by the EMMC clock controller,
> These two clocks will be used by EMMC or NAND driver.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/emmc-clkc.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/clock/emmc-clkc.h
> 
> diff --git a/include/dt-bindings/clock/emmc-clkc.h b/include/dt-bindings/clock/emmc-clkc.h
> new file mode 100644
> index 000000000000..d9972c400e58
> --- /dev/null
> +++ b/include/dt-bindings/clock/emmc-clkc.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Meson EMMC sub clock tree IDs
> + *
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __EMMC_CLKC_H
> +#define __EMMC_CLKC_H
> +
> +#define CLKID_EMMC_C_MUX				0

Looks like the MUX clk is the parent of the DIV one, and I guess the clk
driver is able to select the best parent+div pair for a requested rate.
Do you really need to expose the MUX to users?

> +#define CLKID_EMMC_C_DIV				1
> +
> +#endif
