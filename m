From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Mar 2015 10:22:09 +0000
Subject: [PATCH] clk: provide clk_is_match() dummy for non-common clk
In-Reply-To: <8682755.oK0Ae34OOP@wuerfel>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
Message-ID: <20150311102208.GX8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 10:05:29PM +0100, Arnd Bergmann wrote:
> ARM randconfig build tests found a new error for configurations
> with COMMON_CLK disabled but HAS_CLK selected by the platform:
> 
> ERROR: "clk_is_match" [sound/soc/fsl/snd-soc-fsl-spdif.ko] undefined!
> 
> This moves the declaration around, so this case is covered
> by the existing static inline helper function.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c69e182e51d89 ("clk: introduce clk_is_match")
> ----
> BTW, we have a preexisting problem in clk_get_parent,
> clk_round_rate and clk_set_parent, which I've worked around in
> my randconfig builds so far. Should we do that the same way?

NAK, as Uwe points out, you didn't address my comment.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
