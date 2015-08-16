From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Sun, 16 Aug 2015 09:56:33 +0100
Subject: [PATCH 2/4] drm: Add support for ARM's HDLCD controller.
In-Reply-To: <1438784892-27888-3-git-send-email-Liviu.Dudau@arm.com>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
 <1438784892-27888-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <CACvgo537C6SRfhMTNoE4cSLJukcXuKLvt1TRykynX--ybEhmaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 5 August 2015 at 15:28, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> The HDLCD controller is a display controller that supports resolutions
> up to 4096x4096 pixels. It is present on various development boards
> produced by ARM Ltd and emulated by the latest Fast Models from the
> company.
>
I believe there is a unofficial requirement(?) for new drm drivers to
use atomic modesetting. Not 100% sure on this one though. The
following drivers: tegra, msm, rcar-du, i915, and Daniel's blog [1]
[2] cat provide some information on the topic.

The driver seems to has has a bit of dead code guarded by
HDLCD_*_UNDERRUN. Perhaps these macros should become build or runtime
switch(es) ?

Most DRM drivers do not threat dma, bus_error, vsync and/or underrun
interrupts as debug functionality. They are of limited use in this
driver, presently, yet the CONFIG_DEBUG_FS guard seems a bit strange
imho.

Cheers,
Emil

[1] http://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
[2] http://blog.ffwll.ch/2015/01/update-for-atomic-display-updates.html
