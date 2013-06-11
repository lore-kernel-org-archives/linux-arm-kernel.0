From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Tue, 11 Jun 2013 11:08:04 +0300
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAKMK7uHSCigrTvKENjZRgEsgtA0BeaORcj15n7JFW_uQoNp37Q@mail.gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <CAKMK7uHSCigrTvKENjZRgEsgtA0BeaORcj15n7JFW_uQoNp37Q@mail.gmail.com>
Message-ID: <20130611080804.GI5004@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 12:01:59AM +0200, Daniel Vetter wrote:
> On Mon, Jun 10, 2013 at 9:59 PM, Rob Clark <robdclark@gmail.com> wrote:
> > On Mon, Jun 10, 2013 at 1:06 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Mon, Jun 10, 2013 at 11:57:32AM -0400, Rob Clark wrote:
> >>> On Sun, Jun 9, 2013 at 3:29 PM, Russell King
> >>> <rmk+kernel@arm.linux.org.uk> wrote:
> >>> > This patch adds support for the pair of LCD controllers on the Marvell
> >>> > Armada 510 SoCs.  This driver supports:
> >>> > - multiple contiguous scanout buffers for video and graphics
> >>> > - shm backed cacheable buffer objects for X pixmaps for Vivante GPU
> >>> >   acceleration
> >>> > - dual lcd0 and lcd1 crt operation
> >>> > - video overlay on each LCD crt
> >>>
> >>> Any particular reason for not exposing the overlays as drm_plane's?
> >>> That is probably something that should change before merging the
> >>> driver.
> >>
> >> Only through not understanding much of DRM when I started this.
> >> Provided DRM planes can do everything that I'm already doing with
> >> the overlay support, then yes.  Otherwise, I want to stick with this
> >> which is modelled after the i915 overlay interface.
> 
> Oh i915 overlays aren't a good reason ;-) I've done those way back
> when drm didn't have any plane infrastructure and pretty much as my
> very contribution. So totally lacked any clue.
> 
> If I can scrap together a bit of time I want to port the legacy
> overlay code over to drm planes (and remap the current ioctl interface
> to the drm plane interface for backwards compat). But atm that's
> crushed under a giant pile of other todo items.

I hope you remember the mdfld overlay code I posted a long time ago:
http://lists.freedesktop.org/archives/intel-gfx/2012-September/020479.html

I don't think it's too far from being operational on gen.

-- 
Ville Syrj?l?
Intel OTC
