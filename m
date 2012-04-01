From: cjb@laptop.org (Chris Ball)
Date: Sun, 01 Apr 2012 00:32:32 -0400
Subject: [PATCH 07/11] gpio: tegra: Hide tegra_gpio_enable/disable()
In-Reply-To: <1333148404-17691-8-git-send-email-swarren@wwwdotorg.org>
 (Stephen Warren's message of "Fri, 30 Mar 2012 17:00:00 -0600")
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-8-git-send-email-swarren@wwwdotorg.org>
Message-ID: <87mx6wkr6n.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Mar 30 2012, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Recent pinctrl discussions concluded that gpiolib APIs should in fact do
> whatever is required to mux a GPIO onto pins, by calling pinctrl APIs if
> required. This change implements this for the Tegra GPIO driver, and removes
> calls to the Tegra-specific APIs from drivers and board files.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2: Adjusted per changes to latest version of Documentation/gpio.txt.
> Fixed tegra_board_pinmux_bus_notify() to still check the device name,
> so it waits for the pinmux device to be registered, not just /any/ device.
> ---
>  arch/arm/mach-tegra/board-dt-tegra20.c        |    1 -
>  arch/arm/mach-tegra/board-harmony-pinmux.c    |   17 -----------
>  arch/arm/mach-tegra/board-paz00-pinmux.c      |   14 ---------
>  arch/arm/mach-tegra/board-pinmux.c            |   33 +++--------------------
>  arch/arm/mach-tegra/board-pinmux.h            |    5 ---
>  arch/arm/mach-tegra/board-seaboard-pinmux.c   |   32 ----------------------
>  arch/arm/mach-tegra/board-seaboard.c          |    1 -
>  arch/arm/mach-tegra/board-trimslice-pinmux.c  |   12 --------
>  arch/arm/mach-tegra/include/mach/gpio-tegra.h |    9 ------
>  arch/arm/mach-tegra/usb_phy.c                 |    1 -
>  drivers/gpio/gpio-tegra.c                     |   36 ++++++++++++------------

For this hunk:

>  drivers/mmc/host/sdhci-tegra.c                |   24 +++-------------

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
