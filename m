From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 17 Aug 2013 13:43:21 -0300
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <520F6CA8.1090401@gmail.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130815162751.GA2403@localhost> <520EB5BC.4060102@wwwdotorg.org>
 <1982398.OuHBuuDmYS@flatron> <520F6CA8.1090401@gmail.com>
Message-ID: <20130817164319.GA2772@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 02:29:28PM +0200, Sebastian Hesselbarth wrote:
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
> >>> Just as explained for the Armada 370, the timer and watchdog counters
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
> > I fully agree. DT should list all the input clocks that are fed into the
> > IP block being described.
> 
> I don't object to the above, but strictly speaking the consequence
> would be, that all nodes require a clocks property. For A370/XP timer
> the fabric clock is configurable and needs to be passed among core
> clocks and timer, the 25MHz clock is not and _could_ be seen as an extra
> feature of the core.
> 

In fact: I'm not sure. I'm slightly inclined towards considering both
clocks as clock sources, just as Stephen and Tomasz are proposing.

> But in the end, passing it by DT should be the way to go. I cannot look
> into the XP datasheet, but I would guess that the exact feature of the
> ip is not to use _the_ fixed 25MHz clock but XTAL as reference. Maybe
> one of the free-electrons guys can look it up?
> 

No, the documentation has a register bit for "25Mhz frequency enable",
for each timer/watchdog.

---

Anyway, I (almost) agree that the 25Mhz fixed clock must be somehow represented
in the device-tree, but I'm not exactly sure how. Gregory: maybe you can help
in this?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
