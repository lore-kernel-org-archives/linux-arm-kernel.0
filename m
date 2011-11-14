From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Nov 2011 10:33:27 +0000
Subject: [PATCH v7 00/11] change pxa gpio to platform driver
In-Reply-To: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111114103327.GC25150@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 10:47:20AM +0800, Haojian Zhuang wrote:
> Changelog
> v7:
>     1. add clk_prepare() support in gpio-pxa.c.
> v6:
>     1. fix build issue in pxa910 since building gpio failure is found in
>        mainline.
>     2. merge two dependant patches (original v5 0005 and 0006) together.
>     3. fix gpio bit issue in corgi and spitz.
>     4. replace printk() with dev_err in clk patch.
> v5:
>     1. use generic gpio driver. So clean gpio-pxa.h and gpio-pxa.c again.
> v4:
>     1. append one patch for clean gpio macros and use function instead.
> v3:
>     1. Rebase on Russell's for-next branch.
>     2. Add clock support.
>     3. Move gpio edge detection initiliaztion of arch-mmp into gpio driver.
> 
> v2:
>    1. Remove gpio.c from mach-pxa & mach-mmp that is introduced from v1.
>    2. Remove init function in gpio.c. Move the platfrom_device_register()
>       into platform driver.
>    3. Initialize pxa_gpio_regs in gpio-pxa.c
>    4. Simplify code of identifing pxa gpio series or mmp gpio series.
>    5. Use linux/io.h instead of asm/io.h.
> 

I think with the comments against patch 4 resolved, this can be merged
via Arnd's arm-soc tree - but Arnd will prefer them to be in a git tree
which he can pull rather than dealing with individual patches.
