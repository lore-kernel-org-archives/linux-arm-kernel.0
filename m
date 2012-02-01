From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jan 2012 23:26:17 -0800
Subject: [PATCH v2 2/8] ARM: tegra: functions to access the flowcontroller
In-Reply-To: <1328028051-24271-3-git-send-email-pdeschrijver@nvidia.com>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
 <1328028051-24271-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120201072617.GC7399@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 06:40:40PM +0200, Peter De Schrijver wrote:
> Introduce some functions to write to the flowcontroller registers.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  arch/arm/mach-tegra/Makefile   |    1 +
>  arch/arm/mach-tegra/flowctrl.c |   62 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-tegra/flowctrl.h |    5 +++
>  3 files changed, 68 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-tegra/flowctrl.c
> 
> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> index b78bda8..60c286e 100644
> --- a/arch/arm/mach-tegra/Makefile
> +++ b/arch/arm/mach-tegra/Makefile
> @@ -6,6 +6,7 @@ obj-y                                   += irq.o
>  obj-y                                   += clock.o
>  obj-y                                   += timer.o
>  obj-y					+= fuse.o
> +obj-y					+= flowctrl.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= powergate.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
> diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
> new file mode 100644
> index 0000000..fef66a7
> --- /dev/null
> +++ b/arch/arm/mach-tegra/flowctrl.c
> @@ -0,0 +1,62 @@
> +/*
> + * arch/arm/mach-tegra/flowctrl.c
> + *
> + * functions and macros to control the flowcontroller

Nit:

It would be more useful here to get one or two sentences about what the flow
controller unit is used for, etc.


-Olof
