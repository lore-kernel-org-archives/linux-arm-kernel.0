From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 09 Jun 2016 20:04:20 +0200
Subject: [PATCH v2 00/13] regulator: pwm: various improvements
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <2819222.JTKrccvLNL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Am Mittwoch, 8. Juni 2016, 18:34:35 schrieb Boris Brezillon:
> This patch series series aims at adding two important features to the
> pwm-regulator driver.
> 
> The first one is the support for 'smooth handover' between the
> bootloader and the kernel. This is mainly solving problems we have when
> the PWM is controlling a critical regulator (like the one powering the
> DDR chip). Currently, when the PWM regulator acquire the PWM device it
> assumes it was off and it's safe to change the configuration before
> enabling it, which can generate glitches on the PWM signal which in turn
> generated glitches on the output voltage.
> To solve that we've introduced support for hardware readout to the
> PWM framework, so that the PWM regulator driver can adjust the PWM
> a probe time and avoid glitches.
> Atomic update is also helping in this regard.

[...]

> The second feature we add to the driver is the capability of using
> a sub duty_cycle range in continuous mode. By default the regulator
> is assuming that min_uV is achieved with a 0% dutycyle and max_uV
> with a 100% dutycycle, but this is not necessarily true.
> Moreover, in some cases (when the PWM device does not support
> polarity inversion), we might have min_uV at 100% and max_uV at 0%.
> Hence the addition of new properties to the existing DT bindings.
> The feature is added in patch 12 and 13.

I've tested this series on a rk3288-veyron chromebook and both the backlight-
pwm as well as the pwm-regulator still work as expected, so for everything 
except the STI parts:

Tested-by: Heiko Stuebner <heiko@sntech.de>
