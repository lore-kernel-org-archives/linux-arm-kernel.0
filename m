From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 5 Jul 2013 11:55:19 -0300
Subject: [PATCH v3 6/6] ARM: rockchip: add smp bringup code
In-Reply-To: <201307051443.27172.heiko@sntech.de>
References: <201307051440.19428.heiko@sntech.de>
 <201307051443.27172.heiko@sntech.de>
Message-ID: <CAOMZO5Af=iSZMLEQOrxGfMCSTbfs2K=7QoCvEpkHNMna1V0FfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 5, 2013 at 9:43 AM, Heiko St?bner <heiko@sntech.de> wrote:

> --- /dev/null
> +++ b/arch/arm/mach-rockchip/headsmp.S
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2013 MundoReader S.L.
> + * Author: Heiko Stuebner <heiko@sntech.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +       __CPUINIT

This should go away after this commit:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next-history.git/commit/arch/arm/common/mcpm_platsmp.c?id=c508abae89c3fa861c806ec00366d3b2f8d394cb
