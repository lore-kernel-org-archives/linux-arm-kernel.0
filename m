From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 23:36:21 +0000
Subject: [PATCH 17/20] ARM: mach-s3c64xx: properly disable CPU idle call
In-Reply-To: <alpine.LFD.2.02.1112201348430.2907@xanadu.home>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-18-git-send-email-nico@fluxnic.net>
 <20111220150302.GE29727@sirena.org.uk>
 <alpine.LFD.2.02.1112201348430.2907@xanadu.home>
Message-ID: <20111220233621.GB6551@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 01:54:00PM -0500, Nicolas Pitre wrote:

> So if you can confirm the kernel works fine with that disable_hlt() 
> commented out (while still including the rest of the patch) then I can 
> change the patch.  And if you can measure a difference in power 
> consumption when the system is idle then that would be even better.

Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

with and without the disable_hlt() call.  I don't have equipment with me
to measure power but I don't expect much effect without additional code
to enable power saving in WFI as for some reason the default behaviour
isn't to save power.
