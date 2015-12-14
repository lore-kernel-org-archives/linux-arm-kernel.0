From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 14 Dec 2015 07:56:29 -0600
Subject: [PATCH v1 02/10] clockevents/drivers: add MPS2 Timer driver
In-Reply-To: <1449048790-25859-3-git-send-email-vladimir.murzin@arm.com>
References: <1449048790-25859-1-git-send-email-vladimir.murzin@arm.com>
 <1449048790-25859-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CAL_Jsq+MhvV5BFw+x3TWTDheSpgWHjHjO02+D4V4swr493HXrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 2, 2015 at 3:33 AM, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> MPS2 platform has simple 32 bits general purpose countdown timers.
>
> The driver uses the first detected timer as a clocksource and the rest
> of the timers as a clockevent
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  drivers/clocksource/Kconfig      |    5 +
>  drivers/clocksource/Makefile     |    1 +
>  drivers/clocksource/mps2-timer.c |  277 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 283 insertions(+)
>  create mode 100644 drivers/clocksource/mps2-timer.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 2eb5f0e..8bca09c 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -137,6 +137,11 @@ config CLKSRC_STM32
>         depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
>         select CLKSRC_MMIO
>
> +config CLKSRC_MPS2
> +       bool "Clocksource for MPS2 SoCs" if COMPILE_TEST
> +       depends on OF && ARM

Does this really depend on both of these for COMPILE_TEST?

You need to select CLKSRC_OF rather than CLKSRC_MMIO as well.

Rob
