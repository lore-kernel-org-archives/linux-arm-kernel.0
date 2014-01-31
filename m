From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 31 Jan 2014 12:51:22 +0000
Subject: [PATCH 4/4] ARM: dts: add B2112 board support
In-Reply-To: <1391093744-19905-5-git-send-email-patrice.chotard@st.com>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
 <1391093744-19905-5-git-send-email-patrice.chotard@st.com>
Message-ID: <52EB9C4A.7040105@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/14 14:55, Patrice CHOTARD wrote:
> From: Alexandre TORGUE <alexandre.torgue@st.com>
> 
> Add support for B2112  board based on STiD127 SoC.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  arch/arm/boot/dts/Makefile          |    3 ++-
>  arch/arm/boot/dts/stid127-b2112.dts |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/stid127-b2112.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d57c1a6..7173dca 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -247,7 +247,8 @@ dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
>  dtb-$(CONFIG_ARCH_STI)+= stih415-b2000.dtb \
>  	stih416-b2000.dtb \
>  	stih415-b2020.dtb \
> -	stih416-b2020.dtb
> +	stih416-b2020.dtb \
> +	stid127-b2112.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += \
>  	sun4i-a10-a1000.dtb \
>  	sun4i-a10-cubieboard.dtb \
> diff --git a/arch/arm/boot/dts/stid127-b2112.dts b/arch/arm/boot/dts/stid127-b2112.dts
> new file mode 100644
> index 0000000..b4507e3
> --- /dev/null
> +++ b/arch/arm/boot/dts/stid127-b2112.dts
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright (C) 2013 STMicroelectronics Limited.

2014

> + * Author: Alexandre Torgue <alexandre.torgue@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.

s/publishhed/published/

> + */
> +/dts-v1/;
> +#include "stid127.dtsi"
> +
> +/ {
> +	model = "STiD127 B2112 Board";
> +	compatible = "st,stid127", "st,stid127-b2112";
> +
> +	memory{
> +		device_type = "memory";
> +		reg = <0x40000000 0x10000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyAS0,115200";
> +		linux,stdout-path = &uart2;
> +	};
> +
> +	aliases {
> +		ttyAS0 = &uart2;
> +	};
> +
> +	soc {
> +		uart2: serial at fe532000{
> +			status = "okay";
> +		};
> +	};
> +};
> 
