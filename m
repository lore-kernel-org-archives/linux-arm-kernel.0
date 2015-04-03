From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 11:12:17 -0700
Subject: [PATCH] arm64: dts: Add Qualcomm APQ8016 SBC evaluation board dts
In-Reply-To: <1427151065-29867-1-git-send-email-galak@codeaurora.org>
References: <1427151065-29867-1-git-send-email-galak@codeaurora.org>
Message-ID: <20150403181217.GM23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 05:51:05PM -0500, Kumar Gala wrote:
> Add initial device tree support for Qualcomm APQ8016 SBC Evaluation board.
> This board is also referred to as the DragonBoard 410c.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Hi,

Patch applied but see comment below.

> ---
>  arch/arm64/boot/dts/qcom/Makefile         |  2 +-
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts  | 22 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 33 +++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 360ec4c..8e94af6 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,4 +1,4 @@
> -dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb msm8916-mtp.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> new file mode 100644
> index 0000000..3c563e7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Your 32-bit DTS:es lack copyright headers alltogether, and this is GPLv2 only.
Given the movement to use dual GPL/X11 on DTS contents, it might be a good idea
to kick off that process with your legal team if you haven't already. Please
follow up with copyright revisions as appropriate, on both 32 and 64-bit.


-Olof
