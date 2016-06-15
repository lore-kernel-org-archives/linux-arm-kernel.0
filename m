From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2016 21:11:16 +0100
Subject: [PATCH v5 2/3] drm/arm: Add support for Mali Display Processors
In-Reply-To: <20160615172104.GI9711@e106497-lin.cambridge.arm.com>
References: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
 <1466002295-24813-3-git-send-email-Liviu.Dudau@arm.com>
 <20160615152309.GI1338@phenom.ffwll.local>
 <20160615161758.GF9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
 <20160615172104.GI9711@e106497-lin.cambridge.arm.com>
Message-ID: <20160615201116.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 06:21:04PM +0100, Liviu Dudau wrote:
> Could be the tda998x_drv fault, but I'm getting this splat:
> 
> [    1.347687] kobject_add_internal failed for card0-HDMI-A-1 (error: -2 parent: card0)

Right, so this is -ENOENT - I expect that it's complaining that the
parent does not exist before a child is attempted to be added.

Hopefully, this isn't with -rc kernels, but is with -next.  I think
some folk need to Cc me with patches to tda998x, or at least talk to
me about what's changed in DRM so that tda998x can get fixed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
