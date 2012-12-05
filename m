From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Dec 2012 15:50:44 +0000
Subject: [PATCH] ARM: bcm281xx: Add timer driver
In-Reply-To: <50BF0DAE.6000202@broadcom.com>
References: <1354593324-21300-1-git-send-email-csd@broadcom.com>
 <50BEB77F.10303@wwwdotorg.org> <50BF0DAE.6000202@broadcom.com>
Message-ID: <201212051550.44288.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 December 2012, Christian Daudt wrote:
> On 12-12-04 06:54 PM, Stephen Warren wrote:
> > On 12/03/2012 08:55 PM, Christian Daudt wrote:
> > I'm slightly worried about "kona". Is it a well-known name outside
> > Broadcom for this HW block? If it really is the name though, it's fine I
> > guess, since it's within the "bcm," name-space here.
> Some of these konas slip by :) This is an internal name, but I don't 
> need to use it here. I'll change this to "bcm,bcm-timer"

bcm-timer sounds a bit too generic, unless it's the only one used in
Broadcom, I don't mind a code name like "kona" if that serves to
uniquely identify this timer implementation.
If you don't want to to use that, you should pick a specific mode number
and encode that into the compatible string, such as "bcm,bcm28154-timer".
You can then use the same string for every SoC whose timer is the
same as the one in the bcm28154.

> >> diff --git a/drivers/clocksource/bcm_timer.c b/drivers/clocksource/bcm_timer.c
> > Is this timer HW used in every Broadcom chip? I wonder if the file
> > shouldn't be named bcm_kona_timer.c to allow co-existence with any others.
>
> I'm sure it is not used in every Broadcom chip, but it is used in the 
> ones I'm upstreaming at this point. I can always rename it if it turns 
> out that this is no longer the only one, can't I ? I have been 
> struggling a bit with when to use just "bcm" for name, and when to use 
> something else. Internally we've used kona (and a number of other 
> internal only names) but I've been trying to scrub these out of the code 
> going to upstream, as the internal names are meaningless. But then I end 
> up with no name in some cases, and I don't know that that is more 
> helpful than the meaningless name...

If the name means something to you and is not likely to be used elsewhere in
broadcom for something different, then it's a good enough name. Leaving
out the name is not enough.

	Arnd
