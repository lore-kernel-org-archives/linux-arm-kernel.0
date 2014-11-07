From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Nov 2014 13:10:05 +0100
Subject: [PATCH 11/13] ARM: STi: DT: STih407: Abstract common dt nodes
 into shared files.
In-Reply-To: <1415361475-6218-12-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-12-git-send-email-peter.griffin@linaro.org>
Message-ID: <3301013.ouyFbjlpZY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 November 2014 11:57:53 Peter Griffin wrote:
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> new file mode 100644
> index 0000000..862bb2f
> --- /dev/null
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
> + * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/ {
> +       chosen {
> +               bootargs = "console=ttyAS0,115200";
> +               linux,stdout-path = &sbc_serial0;
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x40000000 0x80000000>;
> +       };
> +
> +       aliases {
> +               ttyAS0 = &sbc_serial0;
> +       };
> +
> 

Please leave these in the per-board file, each board would have different
values, so it makes no sense to have them in the shared file.

	Arnd
