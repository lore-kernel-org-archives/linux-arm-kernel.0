From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:48:12 +0200
Subject: [PATCH 04/39] ARM: ux500: Stop passing UART's platform data for
 Device Tree boots
In-Reply-To: <1368611522-9984-5-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbMVQWQpgiG+PcMUY789i+OgRObtH-toDYKdkbn9VtQ5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> It was required to pass DMA channel configuration information to the
> UART driver before the new DMA API was in place. Now that it is, and
> is fully compatible with Device Tree we can stop doing that.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/cpu-db8500.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
> index 38ebf2b..9b26fe2 100644
> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
> @@ -230,9 +230,9 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
>         /* Requires call-back bindings. */
>         OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
>         /* Requires DMA bindings. */
> -       OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
> -       OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
> -       OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),
> +       OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", NULL),
> +       OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", NULL),
> +       OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", NULL),
>         OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
>         OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  &mop500_sdi0_data),
>         OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  &mop500_sdi1_data),

OK dma_request_slave_channel() is upstream in the PL011 driver,
so applied!

Yours,
Linus Walleij
