From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 13 Nov 2013 16:30:12 +0100
Subject: [PATCH 2/2] Revert "ARM: ux500: Stop passing MMC's platform data
 for Device Tree boots"
In-Reply-To: <1384332012-14857-1-git-send-email-linus.walleij@linaro.org>
References: <1384332012-14857-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAPDyKFqUNrmZRN4V8rUeFUtJHXBGGAMbePDoMpZfb3338jAX+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2013 09:40, Linus Walleij <linus.walleij@linaro.org> wrote:
> This reverts commit 49c129519a7a8840767321c38d2eaf84a263529b.
>
> The special settings for the SD/MMC card parameters that are not
> yet fully agreed upon how to encode into the device tree went missing
> with this commit. We need to first put it into the device tree,
> and then remove the platform data.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  arch/arm/mach-ux500/cpu-db8500.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
> index 8e7e60d2a429..12c7e5c03ea4 100644
> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
> @@ -140,10 +140,10 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
>         /* Requires call-back bindings. */
>         OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
>         /* Requires DMA bindings. */
> -       OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  NULL),
> -       OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  NULL),
> -       OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  NULL),
> -       OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  NULL),
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  &mop500_sdi0_data),
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  &mop500_sdi1_data),
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  &mop500_sdi2_data),
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  &mop500_sdi4_data),
>         OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80123000,
>                        "ux500-msp-i2s.0", &msp0_platform_data),
>         OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80124000,
> --
> 1.8.3.1
>
