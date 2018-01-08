From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 08 Jan 2018 09:56:42 +0100
Subject: [PATCH v2 2/5] ARM64: dts: meson-axg: uart: drop legacy
 compatible name from EE UART
In-Reply-To: <20180106001044.108163-3-yixun.lan@amlogic.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
 <20180106001044.108163-3-yixun.lan@amlogic.com>
Message-ID: <1515401802.5048.71.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-01-06 at 08:10 +0800, Yixun Lan wrote:
> When update the clock info for the UART controller in the EE domain,
> the driver explicitly require 'pclk' in order to work properly.
> 
> With current logic of the code, the driver will go for the legacy clock probe
> routine[1] if it find current compatible string match to 'amlogic,meson-uart',
> which result in not requesting the 'pclk' clock, thus break the driver in the end.
> 
> [1] drivers/tty/serial/meson_uart.c:685
> 
>         /* Use legacy way until all platforms switch to new bindings */
>         if (of_device_is_compatible(pdev->dev.of_node, "amlogic,meson-uart"))
>                 ret = meson_uart_probe_clocks_legacy(pdev, port);
>         else
>                 ret = meson_uart_probe_clocks(pdev, port);

I don't think you should add this code snip here. Anybody can look at the driver
code to see that

> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
