From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Mar 2017 14:18:31 +0100
Subject: [PATCH v2] drm: hdlcd: Fix the calculation of the scanout start
 address
In-Reply-To: <20170331094937.GO7909@n2100.armlinux.org.uk>
References: <20170222153036.GI31595@intel.com>
 <20170308163025.31098-1-Liviu.Dudau@arm.com>
 <20170331094937.GO7909@n2100.armlinux.org.uk>
Message-ID: <20170331131830.GK13355@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 10:49:38AM +0100, Russell King - ARM Linux wrote:
> On Wed, Mar 08, 2017 at 04:30:25PM +0000, Liviu Dudau wrote:
> > The calculation of the framebuffer's start address was wrongly using
> > the CRTC's x and y position rather than the one of the source
> > framebuffer. To fix that we need to update the plane_check code to
> > call drm_plane_helper_check_state() to clip the src and dst coordinates.
> > While there so some minor cleanup of redundant freeing of
> > devm_alloc-ated memory.
> 
> The following series is what I came up with, although I've had no time
> to test it.

I'm afraid I'm going to NAK this series. It would've been nicer for you to
comment on the v2 patch that I have sent rather than going around and coming
back with effectively the same thing but split into 2 patches. I'm having
trouble applying your series to the v4.11-rc4 (specially 2/3). Also 3/3 is
superfluous, as we don't expose the DRM_ROTATE property to userspace.

Best regards,
Liviu

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
