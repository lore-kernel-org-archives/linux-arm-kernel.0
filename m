From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 16:02:56 +0530
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2014 15:45, Lucas Stach <l.stach@pengutronix.de> wrote:
> SoC specific driver to be able to handle PLL reprogramming
> for exact OPP frequencies and additional power saving.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-imx5.txt   |  43 +++
>  drivers/cpufreq/Kconfig.arm                        |   8 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/imx5-cpufreq.c                     | 302 +++++++++++++++++++++
>  4 files changed, 354 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx5.txt
>  create mode 100644 drivers/cpufreq/imx5-cpufreq.c

What stops you to use cpufreq-cpu0 driver with a CPU clock
driver? Its highly discouraged to add a new driver here if you
can reuse it.. Which is more or less confirmed from a broad look..
