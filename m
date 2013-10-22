From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Oct 2013 10:19:59 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131021102448.GD21518@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <20131021095757.GY25034@n2100.arm.linux.org.uk>
 <20131021102448.GD21518@ulmo.nvidia.com>
Message-ID: <20131022091959.GC20821@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 12:24:49PM +0200, Thierry Reding wrote:

> Multi-driver with DRM has worked pretty well for Tegra. Essentially what
> I created was a sort of abstraction layer between DRM and the individual
> drivers so that each driver can register itself with that layer. Once it
> has been determined that all drivers have been probed, that glue layer
> can load the DRM driver and call back into the sub-drivers to register
> their respective components with DRM.

This is pretty much what ASoC always did, it's been working out
reasonably well.

We do still don't really handle what happens if someone tries to unbind
one of the supporting devices while things are in use sensibly.  Since
generally this would involve someone manually removing the driver for
pracical purposes we're OK now but it's an issue and we probably will
have to deal with systems that trigger this for sensible reasons at some
point.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/ea081a26/attachment.sig>
