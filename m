From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Mar 2017 09:15:37 +0000
Subject: outreachy/moving a driver out of staging
In-Reply-To: <1489909067.1536.14.camel@crowfest.net>
References: <alpine.DEB.2.20.1703092133340.2306@hadrien>
 <443f0143-aec1-2559-a2c2-73b245632948@broadcom.com>
 <2da12619-5fcb-9e0f-b6c1-c83cbf491e8d@wwwdotorg.org>
 <20170309212021.GA24433@kroah.com>
 <1489909067.1536.14.camel@crowfest.net>
Message-ID: <20170319091536.GO21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 19, 2017 at 12:37:47AM -0700, Michael Zoran wrote:
> I just noticed this e-mail.  What exactly is the requirement to get a
> driver or subsystem out of staging?

This is why each driver in staging is supposed to have a TODO file
listing each point that needs to be addressed, and when each point
is addressed, the TODO file should be updated.  The TODO file tells
people what the remaining faults are with the driver.

I see that there's a todo file here:

drivers/staging/vc04_services/interface/vchi/TODO

and the very first thing I looked at was:

  - Figure out an alternative to the dmac_map_area() hack.

$ grep -r dmac_map_area drivers/staging/vc04_services/interface/vchi
drivers/staging/vc04_services/interface/vchi/TODO:  - Figure out an alternative
to the dmac_map_area() hack.

So that one looks like it's resolved, so the TODO file is out of date.
The first step, therefore, is to get the TODO files updated with the
work that has been done, so it's possible to know what work remains.

I notice also that drivers/staging/vc04_services/interface/vchiq_arm
does not have a TODO file, so that needs reviewing and a TODO file
generated.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
