From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 13 Nov 2013 16:27:02 +0100
Subject: [PATCH 1/2] Revert "ARM: ux500: Remove AUXDATA relating to SDI
 (MMC) clock-name bindings"
In-Reply-To: <1384331998-14818-1-git-send-email-linus.walleij@linaro.org>
References: <1384331998-14818-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAPDyKFoZACkgC2j3854=Jm7Cei6GqSa+nfJmbOz1_uAeUByD7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2013 09:39, Linus Walleij <linus.walleij@linaro.org> wrote:
> This reverts commit ce16feb8510cbbcd090c2320c35db2fbbffde210.
>
> This commit stopped tying down the name of the MMC/SD devices, but these
> names are used in the pin control table, so the MMC/SD cards stopped
> working.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  arch/arm/mach-ux500/cpu-db8500.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
> index 2e85c1e72535..8e7e60d2a429 100644
> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
> @@ -140,6 +140,10 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
>         /* Requires call-back bindings. */
>         OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
>         /* Requires DMA bindings. */
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0",  NULL),
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80118000, "sdi1",  NULL),
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80005000, "sdi2",  NULL),
> +       OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4",  NULL),
>         OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80123000,
>                        "ux500-msp-i2s.0", &msp0_platform_data),
>         OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80124000,
> --
> 1.8.3.1
>
