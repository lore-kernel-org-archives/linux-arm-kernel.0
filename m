From: robdclark@gmail.com (Rob Clark)
Date: Wed, 9 Jul 2014 06:56:14 -0400
Subject: [GIT PULL] msm drm update for component changes
In-Reply-To: <20140709093458.GA17540@rmk-PC.arm.linux.org.uk>
References: <20140709093458.GA17540@rmk-PC.arm.linux.org.uk>
Message-ID: <CAF6AEGv+hzSKuD2mRDbz-hqN1H09tW5C4a2EYuZ5sN44RABe8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 5:34 AM, Russell King <rmk@arm.linux.org.uk> wrote:
> David,
>
> Please incorporate the latest msm drm update for component changes, which can be found at:
>
>   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git component-for-drm
>
> with SHA1 84448288546d13d7e06fd6638fb78ddff559b399.
>
> This updates the MSM's DRM driver for the updates merged in Greg's
> driver-core tree, converting MSM to use the pre-declared array of
> matches rather than walking the device tree each time we try to bind.

Hey Russell, do you want me to take this for my v3.17 pull req?  I
expect there will be some minor conflicts with the DT support I'm
working on at the moment.

Or does this need to be applied together with the rest of the series?
In which case, maybe it should go first, and then I'd rebase msm-next
on top.

BR,
-R


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
