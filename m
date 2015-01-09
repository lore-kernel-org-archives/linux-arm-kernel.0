From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 9 Jan 2015 12:49:25 +0900
Subject: [PATCH v2 3/3] soc/tegra: fuse: Add Tegra132 support
In-Reply-To: <1420707308-6974-1-git-send-email-thierry.reding@gmail.com>
References: <1420701887-1465-3-git-send-email-thierry.reding@gmail.com>
 <1420707308-6974-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <CAAVeFuKbnquF0iBp4L8Sv4tp-F3YevKjaSkVtyT2LJnDDvXCbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 8, 2015 at 5:55 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Tegra132 is very similar to Tegra124 from a peripheral point of view and
> uses the same fuse controller.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add missing break in Tegra132 case for legacy fuse init (Vince Hsu)
>
>  drivers/soc/tegra/fuse/fuse-tegra.c   | 1 +
>  drivers/soc/tegra/fuse/fuse-tegra30.c | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
> index 011a3363c265..c0d660f1aaac 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
> @@ -81,6 +81,7 @@ static const struct of_device_id car_match[] __initconst = {
>         { .compatible = "nvidia,tegra30-car", },
>         { .compatible = "nvidia,tegra114-car", },
>         { .compatible = "nvidia,tegra124-car", },
> +       { .compatible = "nvidia,tegra132-car", },
>         {},
>  };
>
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
> index d1a4290cda5c..9e3679594259 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra30.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
> @@ -184,6 +184,9 @@ static void __init legacy_fuse_init(void)
>         case TEGRA124:
>                 fuse_info = &tegra124_info;
>                 break;
> +       case TEGRA132:
> +               fuse_info = &tegra124_info;
> +               break;

Nit, but why not

        case TEGRA124:
+       case TEGRA132:
                fuse_info = &tegra124_info;
                break;

?
