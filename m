From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 30 Aug 2018 10:13:42 +0200
Subject: [PATCH] drm/sun4i: Remove R40 display pipeline compatibles
In-Reply-To: <20180827083950.602-1-wens@csie.org>
References: <20180827083950.602-1-wens@csie.org>
Message-ID: <20180830081342.o6ovbkaumlzbhxwk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 04:39:50PM +0800, Chen-Yu Tsai wrote:
> Two patches from the R40 display pipeline support series weren't applied
> with the rest of the series. When they did get applied, the -rc6
> deadline for drm-misc-next had past, so they didn't get into 4.19-rc1
> with the rest of the series. However, the two patches are crucial in
> the parsing of the R40's display pipeline graph in the device tree.
> Without them, the driver crashes because it can't follow the odd graph
> structure.
> 
> This patch removes the R40 compatibles from the sun4i-drm driver,
> effectively disabling DRM support for the R40 for one release cycle.
> This will prevent the driver from crashing upon probing.
> 
> The compatibles should be reinstated for the next release.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> This is for 4.19-rc to fix the boot crash seen on the R40.
> 
> This should go in drm-misc-fixes and into Linus' tree ASAP.
> Once merged, the branch should also be merged into drm-misc-next,
> and then we can revert it.

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180830/c8ffe0df/attachment-0001.sig>
