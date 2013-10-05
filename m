From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 05 Oct 2013 08:38:44 -0700
Subject: [PATCH] wdt: sunxi: Fix section mismatch
In-Reply-To: <1380982817-10234-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380982817-10234-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <52503284.3090509@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2013 07:20 AM, Maxime Ripard wrote:
> This driver has a section mismatch, for probe and remove functions,
> leading to the following warning during the compilation.
>
> WARNING: drivers/watchdog/built-in.o(.data+0x24): Section mismatch in
> reference from the variable sunxi_wdt_driver to the function
> .init.text:sunxi_wdt_probe()
> The variable sunxi_wdt_driver references
> the function __init sunxi_wdt_probe()
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
