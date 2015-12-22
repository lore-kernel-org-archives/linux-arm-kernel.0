From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 22 Dec 2015 17:38:00 +0000
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20151222173800.GU960@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 02:22:03PM +0000, Liviu Dudau wrote:
> Hello,
> 
> This is v2 of the patchset trying to make drm_of_component_probe() cope with finding
> both local crtc ports and remote encoder ones. Heiko St?bner was nice enough to test
> an earlier version that was patched following Russell's suggestions on rk3288, but
> I haven't seen any reports from iMX or Armada users.
> 
> Changelog:
>  v2: Updated the drm_of_component_probe() comment to explain why the reference count
>      is not dropped. Fixed the compare_port() function for rockchip as described by
>      Russell.
>  v1: Original submission. http://lists.freedesktop.org/archives/dri-devel/2015-November/094546.html

Gentle ping, this has now been tested by Rockchip people and fixes the earlier version
that had to be reverted in mainline. Can it be included in the -next somewhere?

Many thanks,
Liviu

> 
> Liviu Dudau (2):
>   drm: Improve drm_of_component_probe() to correctly handle ports and remote ports.
>   drm/rockchip: Convert the probe function to the generic drm_of_component_probe()
> 
>  drivers/gpu/drm/armada/armada_drv.c         |  3 +-
>  drivers/gpu/drm/drm_of.c                    | 19 ++++--
>  drivers/gpu/drm/imx/imx-drm-core.c          |  3 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 98 ++++++-----------------------
>  include/drm/drm_of.h                        |  6 +-
>  5 files changed, 40 insertions(+), 89 deletions(-)
> 
> -- 
> 2.6.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
