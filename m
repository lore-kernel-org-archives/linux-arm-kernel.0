From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Jan 2013 23:12:03 -0800
Subject: [PATCHv1 for soc 1/5] arm: socfpga: Add new device tree source
 for actual socfpga HW
In-Reply-To: <1359075633-13502-2-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-2-git-send-email-dinguyen@altera.com>
Message-ID: <20130128071203.GH25723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nit below.

On Thu, Jan 24, 2013 at 07:00:29PM -0600, dinguyen at altera.com wrote:
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> new file mode 100644
> index 0000000..df3551f
> --- /dev/null
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -0,0 +1,60 @@
> +/*
> + *  Copyright (C) 2013 Altera Corporation <www.altera.com>
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/dts-v1/;
> +/include/ "socfpga.dtsi"
> +
> +/ {
> +	model = "Altera SOCFPGA VT";
> +	compatible = "altr,socfpga-vt";
> +
[...]
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index 6732924..198f491 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -99,6 +99,7 @@ static void __init socfpga_cyclone5_init(void)
>  static const char *altera_dt_match[] = {
>  	"altr,socfpga",
>  	"altr,socfpga-cyclone5",
> +	"altr,socfpga-vt",
>  	NULL
>  };

If you add "altr,socfpga" as a second compatible field in the dts for
the board, then you won't have to update the board C file every time you
add a new board dts (as long as you don't need to do something special
with that board).


-Olof
