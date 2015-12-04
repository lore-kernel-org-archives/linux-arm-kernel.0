From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 4 Dec 2015 10:20:48 +0000
Subject: [PATCH v4 0/4] drm: Add support for the ARM HDLCD display
 controller
In-Reply-To: <20151203165606.GS8644@n2100.arm.linux.org.uk>
References: <1449139249-9171-1-git-send-email-Liviu.Dudau@arm.com>
 <20151203165606.GS8644@n2100.arm.linux.org.uk>
Message-ID: <20151204102048.GH972@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:56:07PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 03, 2015 at 10:40:45AM +0000, Liviu Dudau wrote:
> > This series depends on Sudeep Holla's SCPI driver (now in mainline) and on
> > the tda998x patches that have been queued on Russell's patch system here [1].
> 
> Now merged into my tree.

Thanks!

Are you planning to send those for 4.5 or are they going to be patches for 4.4?

> 
> Can I ask a fairly obvious question...
> 
> >  drivers/gpu/drm/Kconfig                            |   2 +
> >  drivers/gpu/drm/Makefile                           |   1 +
> >  drivers/gpu/drm/arm/Kconfig                        |  29 ++
> >  drivers/gpu/drm/arm/Makefile                       |   2 +
> >  drivers/gpu/drm/arm/hdlcd_crtc.c                   | 327 ++++++++++++
> >  drivers/gpu/drm/arm/hdlcd_drv.c                    | 555 +++++++++++++++++++++
> >  drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
> >  drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
> 
> Why is the subdirectory called "arm" and not "hdlcd" ?

Because I plan to add the Mali DP driver to the same directory. The HDLCD
files are prefixed with the hdlcd_ string, so it should be fairly simple
to distinguish the relevant files.

> 
> ARM Ltd have more than one display controller (they have the AMBA PL110
> and PL111 in addition to this), and (afaics) this doesn't drive these.
> HDLCD probably won't be the last display hardware which ARM Ltd comes
> out with either.

There was a PL111 DRM driver submitted at some moment, it doesn't look
like it has been merged, but the plan was to have it inside the arm
directory as well. I am following the amd/amdgpu|radeon idea of having
a vendor directory in display/gpu/drm and then subdirectories (if it
makes sense) or appropriately named files in there.

> 
> So, I think naming the subdirectory after the vendor is probably a
> mistake.

It might turn out that way, but at the moment I'm not seeing too many
downsides.

Best regards,
Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
