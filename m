From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 11 Feb 2012 11:27:22 +0000
Subject: [PATCH] OMAP: serial: Release the claimed memory region in remove
In-Reply-To: <1328945607-4025-1-git-send-email-shubhrajyoti@ti.com>
References: <1328945607-4025-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120211112721.GA21453@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 01:03:27PM +0530, Shubhrajyoti D wrote:
> Currently the memory region is not released the folowing error is
> observed.

> /testsuites # insmod omap-serial.ko
> [  130.746917] omap_uart omap_uart.0: memory region already claimed
> [  130.753143] omap_uart: probe of omap_uart.0 failed with error -16

It'd be better yet to use the devm_ functions to prevent such issues
recurring in future.
