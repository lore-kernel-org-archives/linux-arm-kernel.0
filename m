From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 15 Oct 2012 16:58:26 +0200
Subject: [PATCH] ARM: SAMSUNG: Add naming of s3c64xx-spi devices
In-Reply-To: <201210021443.54897.heiko@sntech.de>
References: <201210021443.54897.heiko@sntech.de>
Message-ID: <507C2492.8010408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 10/02/2012 02:43 PM, Heiko St?bner wrote:
> Commit a5238e360b71 (spi: s3c64xx: move controller information into driver
> data) introduced separate device names for the different subtypes of the
> spi controller but forgot to set these in the relevant machines.
> 
> To fix this introduce a s3c64xx_spi_setname function and populate all
> Samsung arches with the correct names. The function resides in a new
> header, as the s3c64xx-spi.h contains driver platform data and should
> therefore at some later point move out of the Samsung include dir.
> 
> Tested on a s3c2416-based machine.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: stable at vger.kernel.org

This patch looks good to me. I've tested it on Exynos4412 SoC based
board. And it fixes quite serious problem - broken SPI support on
a all Samsung machs (non-dt) except s3c64xx in mainline v3.6 kernel.


Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
(mach-exynos only)

Jos? Miguel, can you confirm it solves the problem for you ?

--
Regards,
Sylwester
