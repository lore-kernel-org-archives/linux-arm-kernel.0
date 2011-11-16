From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 16 Nov 2011 22:52:09 +0800
Subject: [PATCH] ARM: pxa: fix missing linux/gpio.h include
In-Reply-To: <1321454103-26596-1-git-send-email-zonque@gmail.com>
References: <1321454103-26596-1-git-send-email-zonque@gmail.com>
Message-ID: <CAMPhdO87XqTNKaEiDWp2iC7MfQPvJRexiwu0jH_0PJ82V4S6FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 10:35 PM, Daniel Mack <zonque@gmail.com> wrote:
> Fixes the following compile error:
>
> ?arch/arm/mach-pxa/pxa3xx.c: In function 'pxa3xx_cpu_pm_suspend':
> ?arch/arm/mach-pxa/pxa3xx.c:156: error: implicit declaration of function 'gpio_get_value'
> ?make[1]: *** [arch/arm/mach-pxa/pxa3xx.o] Error 1
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Applied.

> ---
>
> ?I didn't closely follow all recent patches around PXA, so it might be that
> ?this has already been cared for. Haojian?
>
> ?arch/arm/mach-pxa/pxa3xx.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index 3866d52..7cddd11 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -19,6 +19,7 @@
> ?#include <linux/platform_device.h>
> ?#include <linux/irq.h>
> ?#include <linux/io.h>
> +#include <linux/gpio.h>
> ?#include <linux/syscore_ops.h>
> ?#include <linux/i2c/pxa-i2c.h>
>
> --
> 1.7.7.1
>
>
