From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Oct 2013 11:30:14 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131021102448.GD21518@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <20131021095757.GY25034@n2100.arm.linux.org.uk>
 <20131021102448.GD21518@ulmo.nvidia.com>
Message-ID: <20131021103014.GZ25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 12:24:49PM +0200, Thierry Reding wrote:
> Multi-driver with DRM has worked pretty well for Tegra. Essentially what
> I created was a sort of abstraction layer between DRM and the individual
> drivers so that each driver can register itself with that layer. Once it
> has been determined that all drivers have been probed, that glue layer
> can load the DRM driver and call back into the sub-drivers to register
> their respective components with DRM.
> 
> That even works fairly nicely with deferred probing. Note that the code
> currently in Linus' tree has some issues, but I've reworked it since in
> linux-next and the final result isn't all that bad. I've even attempted
> to make it somewhat generic so that it could potentially be reused by
> other drivers. It's not reusable as-is, but perhaps it can be further
> improved.
> 
> I agree that hotpluggability within DRM might have made things easier,
> but it would likely also have made the core more complex. Furthermore
> there simply was no need for DRM to provide that kind of flexibility,
> simple because no driver has had that need so far. Quite a few ARM SoC
> drivers have appeared lately, and hopefully that'll provide more of an
> incentive to evolve DRM as needed, but I don't think we can hold it
> against anyone that they haven't provided us with the ideal subsystem.

Right, so how do you feel about rewriting it again so that everyone
can benefit from it instead of it being specific to just Tegra? :)
