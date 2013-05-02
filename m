From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 18:26:41 +0200
Subject: [PATCH, RFC 08/22] OMAPDSS: DPI needs DSI
In-Reply-To: <5182896F.90807@ti.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-9-git-send-email-arnd@arndb.de> <5182896F.90807@ti.com>
Message-ID: <201305021826.41263.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Tomi Valkeinen wrote:
> On 05/02/2013 06:16 PM, Arnd Bergmann wrote:
> > The dpi.c file cannot be build correctly when the dsi.c file is
> > disabled in Kconfig. This clarifies the dependency in Kconfig
> > to avoid build errors:
> > 
> > drivers/video/omap2/dss/dpi.c: In function 'dpi_calc_pll_cb':
> > drivers/video/omap2/dss/dpi.c:181:2: error: implicit declaration of function 'dsi_hsdiv_calc' [-Werror=implicit-function-declaration]
> > drivers/video/omap2/dss/dpi.c: In function 'dpi_dsi_clk_calc':
> > drivers/video/omap2/dss/dpi.c:201:2: error: implicit declaration of function 'dsi_get_pll_clkin' [-Werror=implicit-function-declaration]
> 
> I've sent a patch for this to DRM maintainer, hopefully merged soon.
> 

Ok, thanks!

	Arnd
