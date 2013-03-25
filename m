From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Mar 2013 13:09:52 +0000
Subject: EXYNOS will support only DT from v3.10
In-Reply-To: <201303251237.38782.arnd@arndb.de>
References: <17a501ce2948$17037610$450a6230$%kim@samsung.com>
 <20130325120256.GM18316@opensource.wolfsonmicro.com>
 <201303251237.38782.arnd@arndb.de>
Message-ID: <20130325130951.GQ18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 12:37:38PM +0000, Arnd Bergmann wrote:

> We don't have any DT support for S3C and S5P upstream yet, so I would
> certainly agree on that. I think we should plan at least one release of
> supporting both simultaneously in order to find bugs with the DT
> implementation before we can consider removing ATAGS support for any
> major platform.

We really ought to look into fixing the bootloader protocol to allow
ATAGS and DT simultaneously BTW, the current situation is a pain
especially if you need uImage.

> However, I also really want to see all ARMv6 and ARMv7 platforms
> get moved over to use ARCH_MULTIPLATFORM, and it probably makes sense
> to eventually move over all platforms that support ARCH_MULTIPLATFORM
> to be DT-only. I hope we do both for EXYNOS in 3.10, and then do at
> least MULTIPLATFORM support for S5P* in 3.11, possibly also for S3C64xx,
> in order to convert all ARMv6 and ARMv7 platforms to MULTIPLATFORM.

The pluggable modules on Cragganmore are going to be a problem for that,
I have some ideas for a subsystem to handle the remapping generically
but not had the time to actually do it yet.  The stuff the BeagleBone
guys were pushing wasn't suitable as it seemed like it was basically
just a wrapper around DT which excludes non-DT platofrms.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130325/db192a62/attachment.sig>
