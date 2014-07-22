From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 22 Jul 2014 09:51:20 +0100
Subject: [GIT PULL] msm drm update for component changes
In-Reply-To: <20140709093458.GA17540@rmk-PC.arm.linux.org.uk>
References: <20140709093458.GA17540@rmk-PC.arm.linux.org.uk>
Message-ID: <20140722085119.GA15250@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 10:34:58AM +0100, Russell King wrote:
> David,
> 
> Please incorporate the latest msm drm update for component changes, which can be found at:
> 
>   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git component-for-drm

Ping?

> 
> with SHA1 84448288546d13d7e06fd6638fb78ddff559b399.
> 
> This updates the MSM's DRM driver for the updates merged in Greg's
> driver-core tree, converting MSM to use the pre-declared array of
> matches rather than walking the device tree each time we try to bind.
> 
> This will update the following files:
> 
>  drivers/base/component.c      | 192 ++++++++++++++++++++++++++++++++++--------
>  drivers/gpu/drm/msm/msm_drv.c |  83 ++++++++----------
>  include/linux/component.h     |   7 ++
>  3 files changed, 199 insertions(+), 83 deletions(-)
> 
> through these changes:
> 
> Russell King (5):
>       component: fix missed cleanup in case of devres failure
>       component: ignore multiple additions of the same component
>       component: add support for component match array
>       component: fix bug with legacy API
>       drm: msm: update to use component match support
> 
> Many thanks.
