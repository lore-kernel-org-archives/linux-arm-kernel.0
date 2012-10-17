From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 17 Oct 2012 17:23:21 +0900
Subject: [PATCH] ARM: SAMSUNG: Add naming of s3c64xx-spi devices
In-Reply-To: <507C3845.1030003@inov.pt>
References: <201210021443.54897.heiko@sntech.de> <507C2492.8010408@samsung.com>
 <507C3845.1030003@inov.pt>
Message-ID: <003b01cdac40$acec1590$06c440b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jos? Miguel Gon?alves wrote:
> 
> On 15-10-2012 15:58, Sylwester Nawrocki wrote:
> > Hi Heiko,
> >
> > On 10/02/2012 02:43 PM, Heiko St?bner wrote:
> >> Commit a5238e360b71 (spi: s3c64xx: move controller information into
> driver
> >> data) introduced separate device names for the different subtypes of
> the
> >> spi controller but forgot to set these in the relevant machines.
> >>
> >> To fix this introduce a s3c64xx_spi_setname function and populate all
> >> Samsung arches with the correct names. The function resides in a new
> >> header, as the s3c64xx-spi.h contains driver platform data and should
> >> therefore at some later point move out of the Samsung include dir.
> >>
> >> Tested on a s3c2416-based machine.
> >>
> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> Cc: stable at vger.kernel.org
> > This patch looks good to me. I've tested it on Exynos4412 SoC based
> > board. And it fixes quite serious problem - broken SPI support on
> > a all Samsung machs (non-dt) except s3c64xx in mainline v3.6 kernel.
> >
> >
> > Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > (mach-exynos only)
> >
> > Jos? Miguel, can you confirm it solves the problem for you ?
> 
> The driver initialization problem is solved by this patch on my S3C2416
> based
> board. Nevertheless, I didn?t have the time yet to test an actual SPI
> device
> connected to the bus.
> 
> BTW, I think the two debug messages at the end of the s3c64xx_spi_probe()
> routine
> should be promoted from dev_dbg to dev_info in order to be shown on a
> normal
> kernel boot.
> 
You guys, thanks for fixing and testing.

Looks good to me, applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
