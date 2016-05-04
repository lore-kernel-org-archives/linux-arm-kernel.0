From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 May 2016 20:33:47 +0200
Subject: [PATCH] drm/sun4i: add COMMON_CLK dependency
In-Reply-To: <1462186805-2211918-1-git-send-email-arnd@arndb.de>
References: <1462186805-2211918-1-git-send-email-arnd@arndb.de>
Message-ID: <20160504183347.GE17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 02, 2016 at 12:59:48PM +0200, Arnd Bergmann wrote:
> The sun4i drm driver uses the clk-provider interfaces, which are not available
> when CONFIG_COMMON_CLK is disabled:
> 
> drivers/gpu/drm/sun4i/sun4i_dotclock.c:19:16: error: field 'hw' has incomplete type
>   struct clk_hw hw;
> In file included from ../include/asm-generic/bug.h:13:0,
>                  from ../arch/arm/include/asm/bug.h:59,
>                  from ../include/linux/bug.h:4,
>                  from ../include/linux/io.h:23,
>                  from ../include/linux/clk-provider.h:14,
>                  from ../drivers/gpu/drm/sun4i/sun4i_dotclock.c:13:
> drivers/gpu/drm/sun4i/sun4i_dotclock.c: In function 'hw_to_dclk':
> include/linux/kernel.h:831:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> ...
> 
> This adds a Kconfig dependency to prevent the driver from being enabled
> in this case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/4e0a095f/attachment.sig>
