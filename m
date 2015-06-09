From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jun 2015 00:36:18 +0100
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <3551826.dyCjorKhLA@diego>
References: <4184159.j0iXe39dFB@phil>
 <20150608163420.GZ7557@n2100.arm.linux.org.uk>
 <20150609075331.GA28198@ulmo> <3551826.dyCjorKhLA@diego>
Message-ID: <20150609233618.GK7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 01:29:43AM +0200, Heiko St?bner wrote:
> Allthough from the discussion and explanations I've now also got the "don't 
> make it worse" feeling, so am somehow reluctant to add supplies that also 
> might describe this inadequately.
> 
> The Rockchip-specific documentation only lists the two supplies as AVDD_1V0, 
> AVDD_1V8 with a description of "DC supply voltage for Analog part of HDMI".
> The supplies aren't mentioned otherwise at all, so I guess I'll ponder this a 
> bit more at first.

Are they controllable from software at all?  If they aren't, then
I'd suggest leaving them out until we have a distinction between
the Tx and Phy - much as we do for iMX6.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
