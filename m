From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 27 Oct 2017 13:08:24 +0300
Subject: [PATCH] [media] rockchip/rga: annotate PM functions as
 __maybe_unused
In-Reply-To: <20171019093044.531871-1-arnd@arndb.de>
References: <20171019093044.531871-1-arnd@arndb.de>
Message-ID: <20171027100823.ao3hytbe4kdfossy@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 11:30:34AM +0200, Arnd Bergmann wrote:
> The newly added driver has incorrect #ifdef annotations on its
> PM functions, leading to a harmless compile-time warning when
> CONFIG_PM is disabled:
> 
> drivers/media/platform/rockchip/rga/rga.c:760:13: error: 'rga_disable_clocks' defined but not used [-Werror=unused-function]
>  static void rga_disable_clocks(struct rockchip_rga *rga)
>              ^~~~~~~~~~~~~~~~~~
> drivers/media/platform/rockchip/rga/rga.c:728:12: error: 'rga_enable_clocks' defined but not used [-Werror=unused-function]
> 
> This removes the #ifdef and marks the functions as __maybe_unused,
> so gcc can silently drop all the unused code.
> 
> Fixes: f7e7b48e6d79 ("[media] rockchip/rga: v4l2 m2m support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
