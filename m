From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 2 Aug 2013 13:08:42 -0700
Subject: [PATCH v2 2/2] ARM: bcm281xx: DT changes for reboot code
In-Reply-To: <1374708923-11956-3-git-send-email-markus.mayer@linaro.org>
References: <1374708923-11956-1-git-send-email-markus.mayer@linaro.org>
 <1374708923-11956-3-git-send-email-markus.mayer@linaro.org>
Message-ID: <CAPdLdq=8EAVpbi9uGEV+AfYFgpK768mnMtphqz=55bP24FiKKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some minor changes necessary for this patch.

> This patch adds the device tree bindings for the bcm281xx reboot code.

> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm,kona-wdt.txt b/Documentation/devicetree/bindings/arm/bcm/bcm,kona-wdt.txt
> new file mode 100644
> index 0000000..bb7be64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/bcm,kona-wdt.txt

Name changed to brcm,kona-wdt.txt.

> @@ -0,0 +1,15 @@
> +Broadcom Kona Family Watchdog Timer
> +-----------------------------------
> +
> +This watchdog timer is used in the following Broadcom SoCs:
> +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> +
> +Required properties:
> +  - compatible = "brcm,kona-wdt";

Change to:  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";

> +  - reg: memory range
> +
> +Example:
> +       watchdog at 35002f40 {
> +               compatible = "brcm,kona-wdt";

Change to: compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";

> +               reg = <0x35002f40 0x6c>;
> +       };
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index c0cdf66..a1c1881 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2012 Broadcom Corporation
> + * Copyright (C) 2012-2013 Broadcom Corporation
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> @@ -56,6 +56,11 @@
>                 cache-level = <2>;
>         };
>
> +       watchdog at 35002f40 {
> +               compatible = "bcm,kona-wdt";

Change to: compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";

> +               reg = <0x35002f40 0x6c>;
> +       };
> +
>         timer at 35006000 {
>                 compatible = "bcm,kona-timer";
>                 reg = <0x35006000 0x1000>;
> --
> 1.7.9.5
>
>

-- 
Markus Mayer
Broadcom Landing Team
