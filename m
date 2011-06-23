From: banajit.goswami@gmail.com (Banajit Goswami)
Date: Thu, 23 Jun 2011 15:42:09 +0530
Subject: [PATCH] ARM: EXYNOS4: Add PWM backlight support on Samsung
	SMDKV310
In-Reply-To: <BANLkTi=SqB7NHQ7vStegFgQjihoQRmzVCw@mail.gmail.com>
References: <22693111.118621308725759945.JavaMail.weblogic@epv6ml03>
	<BANLkTi=SqB7NHQ7vStegFgQjihoQRmzVCw@mail.gmail.com>
Message-ID: <BANLkTikb33PCQtiVmcVm38-ptZPMXMk60g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: JinGoo Han <jg1.han@samsung.com>
>
> Hi, Banajit.
Hi Jingoo,

>>
>> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
>> ---
...
<snip>
...
>> + ? ? .pwm_period_ns ?= 78770,
> Please use 1000 as pwm_period_ns instead of 78770 as follows:
> - ? ? ? .pwm_period_ns ?= 78770,
> + ? ? ? .pwm_period_ns ?= 1000,
>
Yes, I will modify the period value and send updated patch

> The value '78770' makes noise related to resonance at LCD board.
>
> I will explain how I get the value of PWM period.
>
> The SMDK boards use LT3591 as backlight LED driver of LTE480WV LCD
> According to the LT3591 datasheet, the switching frequency should
> be 1MHz. So, PWM period is calculated by following formula:
> ? ? ? ?PWM period = 1/switching frequency
> ? ? ? ? ? ? ? ? ? ? ? = 1/1MHz
> ? ? ? ? ? ? ? ? ? ? ? = 1000 ns
>
Thanks for the explanation.

> You can find LT3591 datasheet easily on the Internet. Please refer to it
> for more information.
> Good luck.
Thanks you.

>> + ? ? .init ? ? ? ? ? = smdkv310_backlight_init,
...
<snip>
...
>

Regards,
Banajit
