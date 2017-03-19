From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 19 Mar 2017 03:22:08 -0700
Subject: outreachy/moving a driver out of staging
In-Reply-To: <20170319091536.GO21222@n2100.armlinux.org.uk>
References: <alpine.DEB.2.20.1703092133340.2306@hadrien>
 <443f0143-aec1-2559-a2c2-73b245632948@broadcom.com>
 <2da12619-5fcb-9e0f-b6c1-c83cbf491e8d@wwwdotorg.org>
 <20170309212021.GA24433@kroah.com> <1489909067.1536.14.camel@crowfest.net>
 <20170319091536.GO21222@n2100.armlinux.org.uk>
Message-ID: <1489918928.1536.17.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-03-19 at 09:15 +0000, Russell King - ARM Linux wrote:
> On Sun, Mar 19, 2017 at 12:37:47AM -0700, Michael Zoran wrote:
> > I just noticed this e-mail.??What exactly is the requirement to get
> > a
> > driver or subsystem out of staging?
> 
> This is why each driver in staging is supposed to have a TODO file
> listing each point that needs to be addressed, and when each point
> is addressed, the TODO file should be updated.??The TODO file tells
> people what the remaining faults are with the driver.
> 
> I see that there's a todo file here:
> 
> drivers/staging/vc04_services/interface/vchi/TODO
> 
> and the very first thing I looked at was:
> 
> ? - Figure out an alternative to the dmac_map_area() hack.
> 
> $ grep -r dmac_map_area drivers/staging/vc04_services/interface/vchi
> drivers/staging/vc04_services/interface/vchi/TODO:??- Figure out an
> alternative
> to the dmac_map_area() hack.
> 
> So that one looks like it's resolved, so the TODO file is out of
> date.
> The first step, therefore, is to get the TODO files updated with the
> work that has been done, so it's possible to know what work remains.
> 
> I notice also that drivers/staging/vc04_services/interface/vchiq_arm
> does not have a TODO file, so that needs reviewing and a TODO file
> generated.
> 

I've actually been submitting changes to the TODO files as I've been
going.  Just these days I'm not sure which tree things are being
applied to anymore.

So I'm assuming once all the TODO items are addressed, and everything
is checkpatch.pl clean it can be moved out of staging?  I would assume
an existing subsystem would need to agree to accept it into their topic
branch correct?
