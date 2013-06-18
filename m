From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Jun 2013 14:22:35 +0100
Subject: [PATCH 2/3] ARM: ux500: Correct the EN_3v3 regulator's on/off GPIO
In-Reply-To: <201306181512.58546.arnd@arndb.de>
References: <1371545519-27119-1-git-send-email-lee.jones@linaro.org>
 <1371545519-27119-3-git-send-email-lee.jones@linaro.org>
 <201306181512.58546.arnd@arndb.de>
Message-ID: <20130618132235.GB31320@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Arnd Bergmann wrote:

> On Tuesday 18 June 2013, Lee Jones wrote:
> > -                gpios = <&gpio0 26  0x4>; // 26
> > -                startup-delay-us = <5000>;
> > -                enable-active-high;
> > +               regulator-name = "en-3v3-fixed-supply";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               /* AB8500 GPIOs start from 1 - offset 25 is GPIO26. */
> > +               gpio = <&ab8500_gpio 25 0x4>;
> 
> Is it intentional that you had "gpios" before and "gpio" after the change
> as the property name?

Yes, it's intentional. See: drivers/regulator/fixed.c

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
