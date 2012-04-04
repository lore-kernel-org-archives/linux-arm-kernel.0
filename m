From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 11:01:06 -0700
Subject: [PATCH 07/11] gpio: tegra: Hide tegra_gpio_enable/disable()
In-Reply-To: <1333148404-17691-8-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-8-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404180106.GG29919@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 05:00:00PM -0600, Stephen Warren wrote:
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

Acked-by: Olof Johansson <olof@lixom.net>

I'm quite glad to see this happen. Erik had the intention to keep pin setup
separate from gpio drivers, but in the end it just results in duplicate setup
of the same stuff in different places. In hindsight this does seem quite a bit
cleaner.


-Olof
