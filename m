From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Apr 2011 23:26:05 +0800
Subject: [PATCH 5/7] ARM: pxa: align NR_BUILTIN_GPIO with GPIO interrupt
	number
In-Reply-To: <1302264944-2759-5-git-send-email-haojian.zhuang@marvell.com>
References: <1302264944-2759-1-git-send-email-haojian.zhuang@marvell.com>
	<1302264944-2759-2-git-send-email-haojian.zhuang@marvell.com>
	<1302264944-2759-3-git-send-email-haojian.zhuang@marvell.com>
	<1302264944-2759-4-git-send-email-haojian.zhuang@marvell.com>
	<1302264944-2759-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <BANLkTin52H82cCmpxT0YobvHSiyOJLRkJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 8, 2011 at 8:15 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Avoid to mismatch between NR_BUILTIN_GPIO and GPIO interrupt number
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Applied to 'fix'.

> ---
> ?arch/arm/mach-pxa/include/mach/gpio.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
> index b024a8b..48ef925 100644
> --- a/arch/arm/mach-pxa/include/mach/gpio.h
> +++ b/arch/arm/mach-pxa/include/mach/gpio.h
> @@ -99,7 +99,7 @@
> ?#define GAFR(x) ? ? ? ? ? ? ? ?GPIO_REG(0x54 + (((x) & 0x70) >> 2))
>
>
> -#define NR_BUILTIN_GPIO 128
> +#define NR_BUILTIN_GPIO ? ? ? ? ? ? ? ?PXA_GPIO_IRQ_NUM
>
> ?#define gpio_to_bank(gpio) ? ? ((gpio) >> 5)
> ?#define gpio_to_irq(gpio) ? ? ?IRQ_GPIO(gpio)
> --
> 1.5.6.5
>
>
