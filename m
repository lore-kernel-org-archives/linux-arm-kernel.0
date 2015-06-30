From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 30 Jun 2015 22:42:55 +0900
Subject: [PATCH] ARM: tegra: paz00: set gpiod_lookup table conn_id's
In-Reply-To: <1435520160-16862-1-git-send-email-digetx@gmail.com>
References: <1435520160-16862-1-git-send-email-digetx@gmail.com>
Message-ID: <CAAVeFuKcaz1C9OV26+8A+LypScqDcufR+X99KDJwVui39Nq7xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 4:34 AM, Dmitry Osipenko <digetx@gmail.com> wrote:
> Commit 72daceb9a10a ("net: rfkill: gpio: Add default GPIO driver mappings
> for ACPI") removed possibility to request GPIO by table index for non-ACPI
> platforms without changing it users. As result "shutdown" GPIO request
> will fail if request for "reset" GPIO succeeded or "reset" will be
> requested instead of "shutdown" if "reset" wasn't defined. Fix it by
> setting conn_id's in gpiod_lookup_table.

Yep, and using con_ids is a good idea anyway.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: 72daceb (net: rfkill: gpio: Add default GPIO driver mappings for ACPI)
> Cc: <stable@vger.kernel.org> # v3.19+
> ---
>  arch/arm/mach-tegra/board-paz00.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> index fbe74c6..67024f3 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -39,8 +39,8 @@ static struct platform_device wifi_rfkill_device = {
>  static struct gpiod_lookup_table wifi_gpio_lookup = {
>         .dev_id = "rfkill_gpio",
>         .table = {
> -               GPIO_LOOKUP_IDX("tegra-gpio", 25, NULL, 0, 0),
> -               GPIO_LOOKUP_IDX("tegra-gpio", 85, NULL, 1, 0),
> +               GPIO_LOOKUP_IDX("tegra-gpio", 25, "reset", 0, 0),
> +               GPIO_LOOKUP_IDX("tegra-gpio", 85, "shutdown", 1, 0),
>                 { },
>         },
>  };
> --
> 2.4.4
>
