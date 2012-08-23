From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Aug 2012 10:10:20 +0800
Subject: [PATCH 4/6] ARM: imx: fix ksz9021rn_phy_fixup
In-Reply-To: <1345648390-4234-5-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
 <1345648390-4234-5-git-send-email-arnd@arndb.de>
Message-ID: <20120823021017.GB24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 05:13:08PM +0200, Arnd Bergmann wrote:
> The ksz9021rn_phy_fixup and mx6q_sabrelite functions try to
> set up an ethernet phy if they can. They do check whether
> phylib is enabled, but unfortunately the functions can only
> be called from platform code if phylib is builtin, not
> if it is a module
> 
> Without this patch, building with a modular phylib results in:
> 
> arch/arm/mach-imx/mach-imx6q.c: In function 'imx6q_sabrelite_init':
> arch/arm/mach-imx/mach-imx6q.c:120:5: error: 'ksz9021rn_phy_fixup' undeclared (first use in this function)
> arch/arm/mach-imx/mach-imx6q.c:120:5: note: each undeclared identifier is reported only once for each function it appears in
> 
> The bug was originally reported by Artem Bityutskiy but only
> partially fixed in ef441806 "ARM: imx6q: register phy fixup only when
> CONFIG_PHYLIB is enabled".
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
