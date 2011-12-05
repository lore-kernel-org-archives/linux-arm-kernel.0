From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 5 Dec 2011 12:29:25 +0800
Subject: [PATCH 2/2] gpio/tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <1323058550-13368-9-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
 <1323058550-13368-9-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111205042924.GB2980@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, this one should not be in the series.  Please ignore.

Regards,
Shawn

On Mon, Dec 05, 2011 at 12:15:50PM +0800, Shawn Guo wrote:
> Enhance  the driver to dynamically allocate the base IRQ number, and
> create an IRQ domain for itself. The use of an IRQ domain ensures that
> any device tree node interrupts properties are correctly parsed.
> 
> Fix the DT binding documentation to describe interrupt-related properties,
> and the contents of "child" node interrupts property.
> 
> Update tegra20.dtsi to specify the required interrupt-related properties.
> 
> Finally, remove the definition of TEGRA_GPIO_TO_IRQ; this macro no longer
> gives correct results since the IRQ numbers for GPIOs are dynamically
> allocated.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../devicetree/bindings/gpio/gpio_nvidia.txt       |   10 ++++++
>  arch/arm/boot/dts/tegra20.dtsi                     |    2 +
>  arch/arm/mach-tegra/include/mach/gpio-tegra.h      |    2 -
>  drivers/gpio/gpio-tegra.c                          |   32 +++++++++++++++----
>  4 files changed, 37 insertions(+), 9 deletions(-)
