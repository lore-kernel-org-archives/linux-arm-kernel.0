From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 16 Feb 2016 17:22:36 -0800
Subject: [PATCH 1/4] arm64: Broadcom Vulcan support
In-Reply-To: <1455389195-31870-2-git-send-email-jchandra@broadcom.com>
References: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
 <1455389195-31870-2-git-send-email-jchandra@broadcom.com>
Message-ID: <56C3CB5C.7080609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/16 10:46, Jayachandran C wrote:
> From: Zi Shen Lim <zlim@broadcom.com>
> 
> Add a configuration option and a device tree for Broadcom's Vulcan
> ARM64 processor. brcm-vulcan.dtsi has the on-chip blocks like the
> PCIe controller, GICv3 with ITS, PMU, system timer and pl011 UART.
> brcm-vulcan-eval.dts has definitions for a basic evaluation board.
> The firmware supports PSCI 0.2 for cpu wakeup.
> 
> Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
> [ updated and split dts - jchandra at broadcom.com ]
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/arm64/Kconfig.platforms                      |   5 +
>  arch/arm64/boot/dts/broadcom/Makefile             |   1 +
>  arch/arm64/boot/dts/broadcom/brcm-vulcan-eval.dts |  33 +++++
>  arch/arm64/boot/dts/broadcom/brcm-vulcan.dtsi     | 146 ++++++++++++++++++++++
>  4 files changed, 185 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/brcm-vulcan-eval.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/brcm-vulcan.dtsi

You might want a MAINTAINERS entry too for these new files?

[snip]

> +++ b/arch/arm64/boot/dts/broadcom/brcm-vulcan-eval.dts
> @@ -0,0 +1,33 @@
> +/*
> + * dts file for Broadcom (BRCM) Vulcan Eval Platform
> + *
> + * Copyright (C) 2013-2016, Broadcom Corporation.

My little finger tells me we should be using a plain
Broadcom now and drop the Corporation in the license header.
-- 
Florian
