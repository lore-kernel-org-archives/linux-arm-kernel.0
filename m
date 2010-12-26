From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 26 Dec 2010 16:38:31 +0100
Subject: [PATCH V3 36/63] ST SPEAr : FSMC (Flexible Static Memory
	Controller) NOR interface driver
In-Reply-To: <187ed7b3996c7f37ce782d847d3ecc761c3e52b8.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<187ed7b3996c7f37ce782d847d3ecc761c3e52b8.1292833228.git.viresh.kumar@st.com>
Message-ID: <AANLkTik_NXigwhRH3KMjV3qmu-GB7m+6hzzdGY8RjBof@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/20 Viresh Kumar <viresh.kumar@st.com>:

> SPEAr1300 SoC supports FSMC to interface with various memories
> (NOR/NAND/SRAM). This patch adds the support for FSMC over NOR interface.
>
> The driver being used is driver/mtd/maps/physmap.c

OK..

(...)
> diff --git a/arch/arm/mach-spear13xx/fsmc-nor.c b/arch/arm/mach-spear13xx/fsmc-nor.c
> new file mode 100644
> index 0000000..03234b6
> --- /dev/null
> +++ b/arch/arm/mach-spear13xx/fsmc-nor.c

What is this file doing in mach-spear13xx? Several other platforms
like U300 and Nomadik use the same NOR controller.

This should be in drivers/mtd/* somewhere I believe?

> @@ -0,0 +1,85 @@
> +/*
> + * arch/arm/mach-spear13xx/fsmc-nor.c
> + *
> + * FSMC (Flexible Static Memory Controller) interface for NOR
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar<vipin.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <plat/fsmc.h>

Use <linux/mtd/fsmc.h> as include file, get rid of plat/fsmc.h.
Extend that .h file with the stuff you need.

We need to keep definitions for MTD NOR, NAND and OneNAND using FSMC
in this file so as to keep things simple. One header file is enough, and it's
very generic too, FSMC is not for plat-spear/* but also U300, Nomadik and
Ux500.

Yours,
Linus Walleij
