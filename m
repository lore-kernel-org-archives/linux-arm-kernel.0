From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 Aug 2013 14:34:23 +0200
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <520F6CA8.1090401@gmail.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1982398.OuHBuuDmYS@flatron> <520F6CA8.1090401@gmail.com>
Message-ID: <17210761.UnLLsEXJpa@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 of August 2013 14:29:28 Sebastian Hesselbarth wrote:
> On 08/17/2013 02:09 PM, Tomasz Figa wrote:
> > On Friday 16 of August 2013 17:29:00 Stephen Warren wrote:
> >> On 08/15/2013 10:27 AM, Ezequiel Garcia wrote:
> >> ...
> >> 
> >>> Armada XP
> >>> ---------
> >>> 
> >>> Two clock sources are available for timer and watchdog counters:
> >>> 
> >>> Just as explained for the Armada 370, the timer and watchdog
> >>> counters
> >>> decrement rate is a configurable ratio of the L2/coherency fabric
> >>> clock. The current clocksource driver implementation chooses an
> >>> abritrary ratio.
> >>> 
> >>> In addition to this, both timer and watchdog counter rate can be
> >>> configured to use an (internal) 25 MHz fixed clock.
> >> 
> >> So there are clearly two clocks fed into the HW block here. The DT
> >> should reflect that.
> > 
> > I fully agree. DT should list all the input clocks that are fed into
> > the IP block being described.
> 
> I don't object to the above, but strictly speaking the consequence
> would be, that all nodes require a clocks property.

Well, I should have added something like "if this is relevant to the IP 
being described", e.g. it can select its operating or I/O clock from those 
input clocks.

> For A370/XP timer
> the fabric clock is configurable and needs to be passed among core
> clocks and timer, the 25MHz clock is not and _could_ be seen as an extra
> feature of the core.

Well, so the core allows selection between both clocks and so both should 
be listed IMHO.

Best regards,
Tomasz
