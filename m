From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 May 2016 20:05:50 +0200
Subject: [PATCH] drm: sun4i: fix probe error handling
In-Reply-To: <1462479061-893414-1-git-send-email-arnd@arndb.de>
References: <1462479061-893414-1-git-send-email-arnd@arndb.de>
Message-ID: <20160508180550.GB6167@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 10:10:52PM +0200, Arnd Bergmann wrote:
> gcc points out a possible uninitialized variable use in
> sun4i_dclk_create():
> 
> drivers/gpu/drm/sun4i/sun4i_dotclock.c: In function 'sun4i_dclk_create':
> drivers/gpu/drm/sun4i/sun4i_dotclock.c:139:12: error: 'clk_name' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   init.name = clk_name;
> 
> The warning only shows up when CONFIG_OF is disabled, and the
> property is never filled, but the same bug can show up even
> when CONFIG_OF is enabled but of_property_read_string_index
> returns another error.
> 
> To fix it, this ensures that sun4i_dclk_create propagates
> any error from of_property_read_string_index.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160508/7d6efac6/attachment.sig>
