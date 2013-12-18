From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 17 Dec 2013 16:06:39 -0800
Subject: [PATCH v12 01/08] ARM: hi3xxx: add board support with device tree
In-Reply-To: <1386748497-11290-2-git-send-email-haojian.zhuang@gmail.com>
 (Haojian Zhuang's message of "Wed, 11 Dec 2013 15:54:50 +0800")
References: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
 <1386748497-11290-2-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <87haa7nhtc.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> From: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> Add board support with device tree for Hisilicon Hi3620 SoC platform.
>

This patch still has checkpatch problems:

ERROR: Use of const init definition must use __initconst
#166: FILE: arch/arm/mach-hi3xxx/hi3xxx.c:51:
+static const char *hi3xxx_compat[] __initdata = {

I know you're frustrated that it's taken a long time to get this stuff
merged, but these are the kinds of mistakes that make us have to take a
*very* close look at every detail, which greatly slows down the process.

I'll fix this up locally, but please be sure to run checkpatch on your
patches before submitting.

> Changelog:
> v11:
> 1. Add comments for iotable.
>
> v10:
> 1. Add .map_io() & debug_ll_io_init() back. Since debug_ll_io_init() is
> only called if .map_io() isn't assigned. Use .map_io() to setup static
> IO mapping that is used in clock driver.
>
> v3:
> 1. Remove .map_io() in DT machine descriptor. Since debug_ll_io_init()
> is called by default.
> 2. Remove .init_machine() in DT machine descriptor. Since
> of_platform_populate() is called by default in DT mode.
>
> v2:
> 1. Remove .init_irq() in DT machine descriptor. Since irqchip_init()
> is called by default in DT mode.

Also not a major deal, but typically the full changelog history goes
after the '---' since in most cases, it's not relevant to the permanent
git history.

Kevin
