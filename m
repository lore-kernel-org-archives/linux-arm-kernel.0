From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 01:24:53 +0300
Subject: [PATCH 37/37] ARM: dts: tegra20-ventana: Fix regulator enable
 GPIO polarity
In-Reply-To: <561C2773.5090408@wwwdotorg.org>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1444684386-17094-38-git-send-email-laurent.pinchart@ideasonboard.com>
 <561C2773.5090408@wwwdotorg.org>
Message-ID: <9351580.BEfKjdvstm@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Monday 12 October 2015 15:34:43 Stephen Warren wrote:
> On 10/12/2015 03:13 PM, Laurent Pinchart wrote:
> > The enable GPIO is active low,
> 
> It'd be good to mention a justification for that statement in the
> patches, since the cover letter isn't going to be checked in.
> 
> > but is flagged as active high in the gpio
> > property. As the gpio property flags are currently unused by the driver
> > this doesn't cause any issue for now, but will break later if the driver
> > starts making use of the flags. Fix it.
> 
> IIRC the history here was that for some bizarre reason not all GPIO
> bindings contained an active-high/low flag and there was resistance to
> extending them in a backwards compatible way. So the regulator binding
> needed the separate property to represent this. For bindings that did
> have the flag, we had to set the GPIO flag to active-high, so that if
> anything started honoring the GPIO flags (e.g. I thikn the gpiod API
> does today, but the legacy GPIO API doesn't), we wouldn't apply both
> "active low indicators", and end up driving an active-high signal, and
> breaking things.
> 
> So while this change is logically correct when read in isolation (and
> for Harmony, Seaboard, and Ventana I verified that these regulators do
> use an active-low GPIO), I worry that making it makes mistakes likely
> later. How would we mitigate that?

That's a very good point. Is the resistance to move to the standard GPIO 
active low/high flags still present, or is it now only history ? In other 
words, could we aim for using GPIO flags as the primary method to specify 
polarities, and fall back to the custom properties for backward compatibility 
(and possibly for GPIO controllers that don't support the flags) ?

-- 
Regards,

Laurent Pinchart
