From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 17:08:15 -0600
Subject: [PATCH] ARM: mvebu: add support for the Linksys WRT1900ACS
 (Shelby)
In-Reply-To: <20170214085919.3997-1-ralph.sennhauser@gmail.com>
References: <20170214085919.3997-1-ralph.sennhauser@gmail.com>
Message-ID: <CAL_JsqJsrparnm8wTL4L3W2cvfSuH=1VddUdBP295MAFfCccWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 2:59 AM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:
> The Linksys WRT1900ACS (Shelby) is another Armada 385 based router in
> the Linksys WRT AC Series which got released in October 2015.
>
> The file armada-385-linksys-shelby.dts is taken from OpenWrt as-is and
> originally authored by Imre Kaloz.
>
> URL: http://tinyurl.com/j8lz83a
> CC: Imre Kaloz <kaloz@openwrt.org>
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/armada-385-linksys-shelby.dts | 114 ++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-385-linksys-shelby.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0118084..16f1748 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -970,6 +970,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
>         armada-385-db-ap.dtb \
>         armada-385-linksys-caiman.dtb \
>         armada-385-linksys-cobra.dtb \
> +       armada-385-linksys-shelby.dtb \
>         armada-385-turris-omnia.dtb \
>         armada-388-clearfog.dtb \
>         armada-388-clearfog-base.dtb \
> diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
> new file mode 100644
> index 0000000..c7a8ddd
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
> @@ -0,0 +1,114 @@
> +/*
> + * Device Tree file for the Linksys WRT1900ACS (Shelby)
> + *
> + * Copyright (C) 2015 Imre Kaloz <kaloz@openwrt.org>
> + *
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is licensed under the terms of the GNU General Public
> + *     License version 2.  This program is licensed "as is" without
> + *     any warranty of any kind, whether express or implied.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Use SPDX tags here:

SPDX-License-Identifier: (GPL-2.0 OR MIT)

While it says X11, this is really MIT license text.
