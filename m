From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 07 Aug 2012 17:05:30 +0200
Subject: [PATCH V4 0/2] arm: samsung: Move FIMD headers to	include/video/
In-Reply-To: <20120807143342.GD18957@n2100.arm.linux.org.uk>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
 <20120807143342.GD18957@n2100.arm.linux.org.uk>
Message-ID: <50212EBA.5000600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2012 04:33 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 07, 2012 at 06:04:30PM +0530, Leela Krishna Amudala wrote:
>>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159 --------------------
>>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
>>  drivers/video/s3c-fb.c                             |    2 +-
>>  .../plat/regs-fb.h => include/video/samsung_fimd.h |  152 +++++++++++++++++--
> 
> Isn't include/video for framebuffer drivers?  Isn't this more a DRM thing?
> Wouldn't include/drm therefore be more appropriate?

Those headers are now used by both: framebuffer and Exynos DRM
driver. And probably the framebuffer driver has more users, as it
also covers older FIMD devices than those found on exynos4/5 SoCs.

So include/video seems equally right (or wrong) as include/drm.

There have been some efforts, or at least requirements raised, to
create some common low level API for framebuffer and DRM drivers,
but nothing has clarified yet AFAICS.
