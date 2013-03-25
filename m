From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 12:37:38 +0000
Subject: EXYNOS will support only DT from v3.10
In-Reply-To: <20130325120256.GM18316@opensource.wolfsonmicro.com>
References: <17a501ce2948$17037610$450a6230$%kim@samsung.com>
 <20130325120256.GM18316@opensource.wolfsonmicro.com>
Message-ID: <201303251237.38782.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Mark Brown wrote:
> On Mon, Mar 25, 2013 at 08:01:23PM +0900, Kukjin Kim wrote:
> 
> > As we discussed before, it's time to decide to support non-DT for EXYNOS
> > SoCs.
> 
> > If everybody else agrees to drop non-DT support from v3.10, I will. Feel
> > free to talk your opinion about that.
> 
> No problem for me on Exynos, though it would be a bit of an issue to
> loose it for s3c64xx right now.

We don't have any DT support for S3C and S5P upstream yet, so I would
certainly agree on that. I think we should plan at least one release of
supporting both simultaneously in order to find bugs with the DT
implementation before we can consider removing ATAGS support for any
major platform.

However, I also really want to see all ARMv6 and ARMv7 platforms
get moved over to use ARCH_MULTIPLATFORM, and it probably makes sense
to eventually move over all platforms that support ARCH_MULTIPLATFORM
to be DT-only. I hope we do both for EXYNOS in 3.10, and then do at
least MULTIPLATFORM support for S5P* in 3.11, possibly also for S3C64xx,
in order to convert all ARMv6 and ARMv7 platforms to MULTIPLATFORM.

For the ARMv5 platforms (S3C24xx and others), we can be much more flexible
with the timing, plus we can keep S3C and S5P in a state where they are
DT-only in multiplatform configurations but allow ATAGS when configured
as standalone like we do today, at least for a couple of releases after
introducing multiplatform support, until we are comfortable with the DT
support and don't break any working platforms.

	Arnd
