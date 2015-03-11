From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Mar 2015 12:17:55 +0100
Subject: [PATCH] clk: provide clk_is_match() dummy for non-common clk
In-Reply-To: <20150311102208.GX8656@n2100.arm.linux.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
 <20150311102208.GX8656@n2100.arm.linux.org.uk>
Message-ID: <20150311111755.GI952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Russell,

On Wed, Mar 11, 2015 at 10:22:09AM +0000, Russell King - ARM Linux wrote:
> On Sun, Mar 08, 2015 at 10:05:29PM +0100, Arnd Bergmann wrote:
> > ARM randconfig build tests found a new error for configurations
> > with COMMON_CLK disabled but HAS_CLK selected by the platform:
> > 
> > ERROR: "clk_is_match" [sound/soc/fsl/snd-soc-fsl-spdif.ko] undefined!
> > 
> > This moves the declaration around, so this case is covered
> > by the existing static inline helper function.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: c69e182e51d89 ("clk: introduce clk_is_match")
> > ----
> > BTW, we have a preexisting problem in clk_get_parent,
> > clk_round_rate and clk_set_parent, which I've worked around in
> > my randconfig builds so far. Should we do that the same way?
> 
> NAK, as Uwe points out, you didn't address my comment.
You commented on the patch that is c69e182e51d8 ("clk: introduce
clk_is_match") now in next. Arnd just moved this around.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
