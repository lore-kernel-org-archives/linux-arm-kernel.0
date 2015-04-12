From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 12 Apr 2015 13:38:18 +0200
Subject: [PATCH v2 2/2] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <1428837944-28150-3-git-send-email-andrew@ncrmnt.org>
References: <1428837944-28150-1-git-send-email-andrew@ncrmnt.org>
 <1428837944-28150-3-git-send-email-andrew@ncrmnt.org>
Message-ID: <552A592A.4050906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.04.2015 13:25, Andrew Andrianov wrote:
> Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>

Andrew,

Hmm, I was hoping to reply before you respin, my comments still apply
for v2. One more below.

> ---
>   arch/arm/boot/dts/Makefile                     |    1 +
>   arch/arm/boot/dts/armada-370-dlink-dns327l.dts |  344 ++++++++++++++++++++++++
>   2 files changed, 345 insertions(+)
>   create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts
[...]
> diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> new file mode 100644
> index 0000000..c58806c
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> @@ -0,0 +1,344 @@
> +/*
> + * Device Tree file for DLINK DNS-327L
> + *
> + * Copyright (C) 2014, Andrew Andrianov <andrew@ncrmnt.org>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/* Remaining mysteries:
> + *
> + * There's still something unknown on i2c address 0x13
> + * CONFIG_ARM_MVEBU_V7_CPUIDLE=y causes hard freezes every 1-8 hours
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-370.dtsi"
> +
> +/ {
> +	model = "DLINK DNS-327L";
> +	compatible = "dlink,dns327l",
> +		"marvell,armada370",
> +		"marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +		stdout-path = &uart0;

With stdout-path you can also pass 115200 option, also please
remove the bootargs line completely.

Sebastian
