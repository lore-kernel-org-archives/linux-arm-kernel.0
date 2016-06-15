From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jun 2016 21:05:39 +0100
Subject: [PATCH v5 2/3] drm/arm: Add support for Mali Display Processors
In-Reply-To: <CAKMK7uGFTmQERWcDeQ=V-ntbgQv6K1avGx1LKCGLcAWacmHKnA@mail.gmail.com>
References: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
 <1466002295-24813-3-git-send-email-Liviu.Dudau@arm.com>
 <20160615152309.GI1338@phenom.ffwll.local>
 <20160615161758.GF9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
 <20160615172104.GI9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uGFTmQERWcDeQ=V-ntbgQv6K1avGx1LKCGLcAWacmHKnA@mail.gmail.com>
Message-ID: <20160615200539.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 09:29:38PM +0200, Daniel Vetter wrote:
> On Wed, Jun 15, 2016 at 7:21 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > Could be the tda998x_drv fault, but I'm getting this splat:
> 
> Yeah, tda9998x needs to be fixed to _not_ register it's connector
> before the overall (componentized) driver is ready. We need to make
> sure first ofc that all users of that driver do register connectors,
> but Chris' patch series will take care of that. But tda9998x needs to
> be fixed either way.

Componentised drivers only get one bind callback, they don't get a
two-stage initialisation at bind time.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
