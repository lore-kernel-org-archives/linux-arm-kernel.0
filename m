From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 11 Apr 2017 12:33:25 +0530
Subject: [PATCH 3/5] cpufreq: dt: Add support for some new Allwinner SoCs
In-Reply-To: <20170408185025.53841-4-icenowy@aosc.io>
References: <20170408185025.53841-1-icenowy@aosc.io>
 <20170408185025.53841-4-icenowy@aosc.io>
Message-ID: <CAOh2x=kQE3fb0b-rD6-E0XJ0Xjm-c1PsnPFfGyLPhJur=urwLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 9, 2017 at 12:20 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Some new Allwinner SoCs get supported in the kernel after the
> compatibles are added to cpufreq-dt-platdev driver.
>
> Add their compatible strings in the cpufreq-dt-platdev driver.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 921b4a6c3d16..2180e509e383 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -24,7 +24,12 @@ static const struct of_device_id machines[] __initconst = {
>         { .compatible = "allwinner,sun8i-a23", },
>         { .compatible = "allwinner,sun8i-a33", },
>         { .compatible = "allwinner,sun8i-a83t", },
> +       { .compatible = "allwinner,sun8i-h2-plus", },
>         { .compatible = "allwinner,sun8i-h3", },
> +       { .compatible = "allwinner,sun8i-v3s", },
> +       { .compatible = "allwinner,sun50i-a64", },
> +       { .compatible = "allwinner,sun50i-h5", },
> +       { .compatible = "nextthing,gr8", },


This needs to be in alphabetical order and please cc cpufreq
maintainers next time.
