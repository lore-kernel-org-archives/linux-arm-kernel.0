From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 18 Aug 2015 14:16:00 +0800
Subject: [PATCH v5 4/4] arm64, dt, thunderx: Add initial dts for Cavium
 Thunder SoC in 2 Node topology.
In-Reply-To: <1439570374-4079-5-git-send-email-gkulkarni@caviumnetworks.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-5-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20150818141600.70076adc@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ganapatrao,

On Fri, 14 Aug 2015 22:09:34 +0530
Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com> wrote:

> adding dt file for Cavium's Thunder SoC in 2 Node topology
> using arm,associativity device node property.
> 
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>  arch/arm64/boot/dts/cavium/Makefile             |   2 +-
>  arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts  |  78 +++
>  arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi | 790 ++++++++++++++++++++++++
>  3 files changed, 869 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts
>  create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi
> 
> diff --git a/arch/arm64/boot/dts/cavium/Makefile b/arch/arm64/boot/dts/cavium/Makefile
> index e34f89d..7fe7067 100644
> --- a/arch/arm64/boot/dts/cavium/Makefile
> +++ b/arch/arm64/boot/dts/cavium/Makefile
> @@ -1,4 +1,4 @@
> -dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
> +dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb thunder-88xx-2n.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts b/arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts
> new file mode 100644
> index 0000000..adbd3a9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts
> @@ -0,0 +1,78 @@
> +/*
> + * Cavium Thunder DTS file - Thunder board description
> + *
> + * Copyright (C) 2014, Cavium Inc.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this library; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA

>From the kernel logs, seems this FSF mailing address isn't valid.
It's better to remove this paragraph about writing to FSF

I also submitted a patch to remove this paragraph from existing thunder-88xx dts:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358225.html

Thanks,
Jisheng
