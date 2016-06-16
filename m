From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 16 Jun 2016 08:57:27 +0100
Subject: [PATCH v5 2/3] drm/arm: Add support for Mali Display Processors
In-Reply-To: <20160615201116.GI1041@n2100.armlinux.org.uk>
References: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
 <1466002295-24813-3-git-send-email-Liviu.Dudau@arm.com>
 <20160615152309.GI1338@phenom.ffwll.local>
 <20160615161758.GF9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
 <20160615172104.GI9711@e106497-lin.cambridge.arm.com>
 <20160615201116.GI1041@n2100.armlinux.org.uk>
Message-ID: <20160616075727.GK9711@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Jun 15, 2016 at 09:11:16PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 15, 2016 at 06:21:04PM +0100, Liviu Dudau wrote:
> > Could be the tda998x_drv fault, but I'm getting this splat:
> > 
> > [    1.347687] kobject_add_internal failed for card0-HDMI-A-1 (error: -2 parent: card0)
> 
> Right, so this is -ENOENT - I expect that it's complaining that the
> parent does not exist before a child is attempted to be added.
> 
> Hopefully, this isn't with -rc kernels, but is with -next.  I think
> some folk need to Cc me with patches to tda998x, or at least talk to
> me about what's changed in DRM so that tda998x can get fixed.

This is with a new driver that just went into -next and I was trying a suggestion
from Daniel to re-order the initialisation steps in preparation of the
series that Chris Wilson is working on to make init time less racy.
It is not a normal run splat and I will make sure that we work with
you to get tda998x changed when we get there.

Other than the ticlcd driver that is (I think) being converted to atomic, do you
use any other DRM driver with tda998x?

Best regards,
Liviu

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
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
