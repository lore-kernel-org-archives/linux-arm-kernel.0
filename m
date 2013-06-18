From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 15:12:58 +0200
Subject: [PATCH 2/3] ARM: ux500: Correct the EN_3v3 regulator's on/off GPIO
In-Reply-To: <1371545519-27119-3-git-send-email-lee.jones@linaro.org>
References: <1371545519-27119-1-git-send-email-lee.jones@linaro.org>
 <1371545519-27119-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201306181512.58546.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Lee Jones wrote:
> -                gpios = <&gpio0 26  0x4>; // 26
> -                startup-delay-us = <5000>;
> -                enable-active-high;
> +               regulator-name = "en-3v3-fixed-supply";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               /* AB8500 GPIOs start from 1 - offset 25 is GPIO26. */
> +               gpio = <&ab8500_gpio 25 0x4>;

Is it intentional that you had "gpios" before and "gpio" after the change
as the property name?

	Arnd
