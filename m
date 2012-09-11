From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 12:43:11 -0600
Subject: [PATCH v2] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <1347386932-29930-1-git-send-email-robherring2@gmail.com>
References: <1347386932-29930-1-git-send-email-robherring2@gmail.com>
Message-ID: <504F863F.7070104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 12:08 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In preparation to support multi-platform kernels, move all the dtb targets
> out of the mach Makefile.boot and into the arch/arm/boot/dts/Makefile
> which is closer to the sources.
> 
> DTBs are only built when CONFIG_OF is enabled and now use top level
> CONFIG_ARCH_xxx instead of chip or board specific config options.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

... although I'm still not 100% how the conflicts are going to be
resolved; Arnd made a suggestion - is that what's happening?

> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile

> +dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
> +	tegra20-paz00.dtb \
> +	tegra20-seaboard.dtb \
> +	tegra20-trimslice.dtb \
> +	tegra20-ventana.dtb \
> +	tegra20-whistler.dtb \
> +	tegra30-cardhu.dtb

It seems like the following format would keep the lines 100% independent:

dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb
dtb-$(CONFIG_ARCH_TEGRA) += tegra20-paz00.dtb
dtb-$(CONFIG_ARCH_TEGRA) += tegra20-seaboard.dtb

But, what you have in the patch is probably just fine too.
