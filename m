From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 23:56:07 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAF6AEGu-e+cZW-1F6L+epE11oonFucreEY_KH+awRx7j5pScpA@mail.gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <20130610200839.GY18614@n2100.arm.linux.org.uk>
 <CAF6AEGsfzvdiGXqAu56rc-G_ZhhE_vnNbC6kpBmRtd-8Sh_uOQ@mail.gmail.com>
 <20130610211516.GZ18614@n2100.arm.linux.org.uk>
 <CAF6AEGu-e+cZW-1F6L+epE11oonFucreEY_KH+awRx7j5pScpA@mail.gmail.com>
Message-ID: <20130610225607.GE18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 06:49:06PM -0400, Rob Clark wrote:
> I guess in the short term, the best I can think is keep those phys
> ioctls as a small patch on top of the upstream driver.  It is ok to
> leave place-holder ioctl #'s in the upstream driver so that the ioctl
> #'s don't shift when you rebase.  And then try to get the vendor to
> add support for dmabuf so that the patch on top of upstream can
> eventually be dropped.  Maybe someone else has a better suggestion,
> but I don't think we can merge those phys ioctls upstream, and I'd
> really hate to 'throw the baby out with the bathwater' in this case
> and not at least get the modesetting part of the driver merged.

What you're saying is basically:

1. Throw out DRM_ARMADA_GEM_CREATE_PHYS, which cripples video playback
   on existing gstreamer, xbmc and other implementations without someone
   rewriting all that code.

2. Throw out DRM_ARMADA_GEM_PROP, which prevents any form of passing
   the GEM objects to the GPU libraries in userspace, thereby preventing
   any kind of GPU based acceleration.

That makes the driver just be a dumb scanout only driver.  Sorry,
that *really* does not interest me one bit, because the CPU doing
framebuffer accesses is pig slow.

There's really no point in such a driver; people might as well just
use the standard fbdev driver instead.
