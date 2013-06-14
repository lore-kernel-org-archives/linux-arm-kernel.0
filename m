From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jun 2013 23:15:39 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAKMK7uEzC8rCaAB_8VCwyox2Be9JZ=+OWSk0+BLyfug7G5=18A@mail.gmail.com>
References: <20130612164914.GT18614@n2100.arm.linux.org.uk>
 <20130612170512.GU18614@n2100.arm.linux.org.uk>
 <20130612194021.GX18614@n2100.arm.linux.org.uk>
 <20130612230057.GY18614@n2100.arm.linux.org.uk>
 <20130613111903.GA18614@n2100.arm.linux.org.uk>
 <20130613115016.GB18614@n2100.arm.linux.org.uk>
 <20130613130339.GD18614@n2100.arm.linux.org.uk>
 <CAKMK7uHgAe=05RFLxqSTz5R+myU9-nvuk=RMZym2k-tjzbC+2w@mail.gmail.com>
 <20130614144251.GN18614@n2100.arm.linux.org.uk>
 <CAKMK7uEzC8rCaAB_8VCwyox2Be9JZ=+OWSk0+BLyfug7G5=18A@mail.gmail.com>
Message-ID: <20130614221539.GO18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 09:50:22PM +0200, Daniel Vetter wrote:
> On Fri, Jun 14, 2013 at 4:42 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > If you're happy with the patch I supplied, that's probably the minimal fix
> > which should go to stable kernels (I'm using 3.9 here) - this also counts
> > as a "user visible bug".  It's something I've tripped over which causes
> > exhausts memory and can prevent the X server from starting up.
> >
> > If you want me to package the patch up with a commit message and sign-off..
> 
> Your patch doesn't fix drm/i915 (since we don't use the crtc helpers
> any more). And I don't think it's good to have the refcounting
> partially in the drm core and partially in drivers.

Let me check what you mean by that.  I hope you mean that the drm core,
drm helpers and drivers are individually responsible for dropping any
refcount that they obtain on any object.

In other words, if the drm core takes a refcount on object X, then the
DRM core must be the code base which drops that refcount.
