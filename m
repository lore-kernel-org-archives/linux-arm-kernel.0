From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Apr 2014 12:55:48 -0400
Subject: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375
 DB board
In-Reply-To: <20140416163447.GB14842@lunn.ch>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com> <20140416180315.5153c3f7@skate>
 <20140416160824.GA14842@lunn.ch> <20140416181938.6e8f8f4b@skate>
 <20140416163447.GB14842@lunn.ch>
Message-ID: <20140416165548.GI28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 06:34:47PM +0200, Andrew Lunn wrote:
> > So, I would like to see the Z1 stepping supported for now, and have the
> > freedom to remove its support later once we are all ready to switch to
> > A0.
> 
> Hi Thomas
> 
> Sounds like a good plan. Try to keep all the mess to support Z1 in one
> place so that it can be easily taken out once people have A0.

Agreed.  Thomas, do you think you'll be able to get a definitive answer
from Marvell re the number of Z1 boards in the wild?  Once they've moved
to the A0, of course.

Unless we can get a hard answer on that, I doubt we'll ever withdraw
support for the Z1.  Not that that's a bad thing, just trying to be
realistic.  If we add code, expect to support it.

And keeping it all in one place is kind of an impossibility.  Just for
thermal Z1, there are changes to the binding docs, the thermal driver,
and the soc code.

I'd say it's more important to keep it clean, with dts files targeting
the A0+ SoCs, and the Z1 being the exception case(s).

thx,

Jason.
