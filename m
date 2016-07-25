From: slash.tmp@free.fr (Mason)
Date: Mon, 25 Jul 2016 11:48:47 +0200
Subject: [PATCH v3] thermal: tango: add resume support
In-Reply-To: <4062048.3qHsMMf8fO@wuerfel>
References: <57726196.5060909@free.fr> <m2wpkd1gfg.fsf@baylibre.com>
 <5795CB4E.4000909@free.fr> <4062048.3qHsMMf8fO@wuerfel>
Message-ID: <5795E07F.6010506@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/2016 10:52, Arnd Bergmann wrote:

> On Monday, July 25, 2016 10:18:22 AM CEST Mason wrote:
> 
>> Moving the SIMPLE_DEV_PM_OPS macro outside the CONFIG_PM_SLEEP guard
>> would unconditionally define a struct dev_pm_ops, which just wastes
>> space when CONFIG_PM_SLEEP is undefined (if I'm not mistaken).
>>
>> That's why I put SIMPLE_DEV_PM_OPS inside the CONFIG_PM_SLEEP guard.
> 
> If you want to avoid the extra few bytes, just use the trick I
> suggested:
> 
> 	.pm = IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm : NULL,

This would achieve the same result as the solution I proposed
in my v2 patch, right?

So you're saying you prefer the IS_ENABLED macro over using
#ifdef ... #else define stuff as NULL #endif

Did I get that right?

Eduardo, Zhang, what do thermal maintainers prefer?

> You should basically never have that #ifdef inside of the
> platform_driver definition.

Except when the fields don't exist, like the bug I introduced
in struct smp_operations (which you fixed).

Regards.
