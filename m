From: liu.h.jason@gmail.com (Jason Liu)
Date: Fri, 12 Aug 2011 17:36:32 +0800
Subject: [PATCH 1/6] arm/cpuimx51: gpio_to_irq() should be used to get irq
	from gpio number
In-Reply-To: <1313135701-22456-2-git-send-email-shawn.guo@linaro.org>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
	<1313135701-22456-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAB4PhKdAgasG3wJ2JvS_Ds0ReGjDCgZh_prepNGF=FqG6fRx7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/12 Shawn Guo <shawn.guo@linaro.org>:
> Instead of irq_to_gpio(), gpio_to_irq() should be used to get irq
> from gpio number.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ?arch/arm/mach-mx5/board-cpuimx51.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> index 7c893fa..68934ea 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> @@ -81,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
> ? ? ? ? ? ? ? ?.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
> - ? ? ? ? ? ? ? .irq = irq_to_gpio(CPUIMX51_QUARTD_GPIO),
> + ? ? ? ? ? ? ? .irq = gpio_to_irq(CPUIMX51_QUARTD_GPIO),
> ? ? ? ? ? ? ? ?.irqflags = IRQF_TRIGGER_HIGH,
> ? ? ? ? ? ? ? ?.uartclk = CPUIMX51_QUART_XTAL,
> ? ? ? ? ? ? ? ?.regshift = CPUIMX51_QUART_REGSHIFT,
> --

The fix has already in Sascah's tree:

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Thu Aug 4 16:47:35 2011 +0100

    ARM: mx5: board-cpuimx51.c fixup irq_to_gpio() usage

    irq_to_gpio() is being called on a GPIO so change to using
    gpio_to_irq() instead.

    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Jason

> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
