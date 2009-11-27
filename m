From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 27 Nov 2009 09:07:32 +0100
Subject: [patch] spitz: better voltage-to-percentage conversion
In-Reply-To: <20091127073119.GB1405@ucw.cz>
References: <20091127073119.GB1405@ucw.cz>
Message-ID: <4B0F88C4.9010206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek a ?crit :
> Old code has two huge tables... unfortunately those tables are simple
> linear relationships and wrong: li-ions do not behave like that.
> 
> Convert physical values to mV,mA,mOhm, add computation that makes
> sense for physical point of view, and provide tables based on
> measurements.
> 
> To get even better results, we should provide better battery_current
> estimate (taking backlight into account), and adjust adjust
> battery_resistance according to its age and temperature. 
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> 
> --- a/arch/arm/mach-pxa/corgi_pm.c	2009-11-23 20:48:26.000000000 +0100

> +typedef int miliamp_t;
> +typedef int miliohm_t;
> +typedef int milivolt_t;

milliamp, milliohm, millivolt ?
