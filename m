From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 31 Aug 2015 12:59:26 +0000
Subject: [PATCH 2/3] ARM: mvebu: add DT support for Seagate Personal Cloud
In-Reply-To: <1440866805-31731-3-git-send-email-simon.guinot@sequanux.org>
References: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
 <1440866805-31731-3-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150831125926.GL3684@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 29, 2015 at 06:46:44PM +0200, Simon Guinot wrote:
> This patch adds DT support for the Seagate Personal Cloud 1 and 2-Bay
> (n090103 and n090203).
> 
> Chipset list:
> - SoC Marvell Armada 370 88F6707, CPU @1GHz
> - SDRAM memory: 512MB DDR3 667MHz (16-bits bandwidth)
> - SPI flash 1MB (Macronix MX25L8006E)
> - 1 or 2 SATA internal ports
> - 1 Ethernet Gigabit port (PHY Marvell 88E1518)
> - 1 USB3 host port (PCIe controller ASM1042)
> - 1 USB2 host port (SoC)
> - 2 push buttons (power and reset)
> - 1 SATA LED (bi-color, white and red)

Do you have long term URLs for these products?  It would be nice to add
those.  The best I could find is:

  http://www.seagate.com/www-content/product-content/personal-cloud/en-us/doc/personal-cloud-ds1838-1-1501us.pdf

But none of the model numbers match what you've used in this patch
series.  I imagine this will make it harder for newcomers to find the
relevant code.

> Note that support for the white SATA LED is missing. A dedicated LED
> driver is needed.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  arch/arm/boot/dts/Makefile                |   2 +
>  arch/arm/boot/dts/armada-370-n090103.dts  |  28 +++++
>  arch/arm/boot/dts/armada-370-n090203.dts  |  42 ++++++++
>  arch/arm/boot/dts/armada-370-n090x03.dtsi | 174 ++++++++++++++++++++++++++++++
>  4 files changed, 246 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-370-n090103.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-n090203.dts
>  create mode 100644 arch/arm/boot/dts/armada-370-n090x03.dtsi
> 

...

> diff --git a/arch/arm/boot/dts/armada-370-n090103.dts b/arch/arm/boot/dts/armada-370-n090103.dts
> new file mode 100644
> index 000000000000..c94bed449050
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-n090103.dts
> @@ -0,0 +1,28 @@
> +/*
> + * Device Tree file for Seagate Personal Cloud NAS (n090103).
> + *
> + * Copyright (C) 2015 Seagate
> + *
> + * Author: Simon Guinot <simon.guinot@sequanux.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */

Based on previous discussions, I'm pretty sure I know what the answer
is, but I have to at least ask in case it was accidental.  All other
armada-* files are dual licensed, GPLv2/X11.  Was it intentional to
license these as GPLv2 only?

> +
> +/dts-v1/;
> +#include "armada-370-n090x03.dtsi"
> +
> +/ {
> +	model = "Seagate Personal Cloud";
> +	compatible = "seagate,n090103", "marvell,armada370", "marvell,armada-370-xp";

In line with my previous comment, can we add a compatible string here?

	compatible = "seagate,n090103", "seagate,personalcloud", "marvell,armada370", "marvell,armada-370-xp";

> diff --git a/arch/arm/boot/dts/armada-370-n090203.dts b/arch/arm/boot/dts/armada-370-n090203.dts
> new file mode 100644
> index 000000000000..3bc62b9f0b0c
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-n090203.dts
> @@ -0,0 +1,42 @@
> +/*
> + * Device Tree file for Seagate Personnal Cloud 2-Bay NAS (n090203).
> + *
> + * Copyright (C) 2015 Seagate
> + *
> + * Author: Simon Guinot <simon.guinot@sequanux.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "armada-370-n090x03.dtsi"
> +
> +/ {
> +	model = "Seagate Personnal Cloud 2-Bay";
> +	compatible = "seagate,n090203", "marvell,armada370", "marvell,armada-370-xp";

And then here:

	compatible = "seagate,n090103", "seagate,personalcloud2", "marvell,armada370", "marvell,armada-370-xp";

or similar.

The same comments apply to the NAS versions as well.

thx,

Jason.
