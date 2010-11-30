From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 30 Nov 2010 16:33:04 +0200
Subject: [PATCH RESEND v3] ARM: s3c2442: Setup gpio {set,
	get}_pull callbacks
In-Reply-To: <4CF4F845.7010207@metafoo.de>
References: <000201cb8fae$4d61fd20$e825f760$%kim@samsung.com>
	<201011301401.44973.anarsoul@gmail.com>
	<4CF4F845.7010207@metafoo.de>
Message-ID: <201011301633.05545.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 November 2010 15:12:37 Lars-Peter Clausen wrote:

> Hi
> 
> While this might work for setting the pullup, what to you want to return in
> get_pull?

Some custom value like S3C_GPIO_PULL_ENABLED?
 
> The reason why s3c24xx_gpiocfg_default needs to have {get,set}_pull set at
> compile time is that the board init code is called before the cpu init
> code. Which is in my opinion a bit odd and should be fixed instead.

That's because cpu init code is arch_initcall. Kernel calls mdesc-
>init_machine before any arch_initcall function, not sure if it can be fixed 
without massive rework of existing code.

> If it is not fixed for whatever reason we could fallback to using some sort
> of "cpu_is_s3c2442() ? S3C_GPIO_PULL_UP : S3C_GPIO_PULL_DOWN"

AFAIK, Ben does not like runtime CPUtype checks

Regards
Vasily
