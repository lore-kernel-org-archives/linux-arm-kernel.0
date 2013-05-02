From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 2 May 2013 18:42:39 +0300
Subject: [PATCH, RFC 08/22] OMAPDSS: DPI needs DSI
In-Reply-To: <1367507786-505303-9-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-9-git-send-email-arnd@arndb.de>
Message-ID: <5182896F.90807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 05/02/2013 06:16 PM, Arnd Bergmann wrote:
> The dpi.c file cannot be build correctly when the dsi.c file is
> disabled in Kconfig. This clarifies the dependency in Kconfig
> to avoid build errors:
> 
> drivers/video/omap2/dss/dpi.c: In function 'dpi_calc_pll_cb':
> drivers/video/omap2/dss/dpi.c:181:2: error: implicit declaration of function 'dsi_hsdiv_calc' [-Werror=implicit-function-declaration]
> drivers/video/omap2/dss/dpi.c: In function 'dpi_dsi_clk_calc':
> drivers/video/omap2/dss/dpi.c:201:2: error: implicit declaration of function 'dsi_get_pll_clkin' [-Werror=implicit-function-declaration]

I've sent a patch for this to DRM maintainer, hopefully merged soon.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130502/f6683893/attachment.sig>
