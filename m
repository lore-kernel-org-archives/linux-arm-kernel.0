From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 30 Jan 2014 17:16:29 -0500
Subject: [PATCH v5 00/20] Armada 370/XP watchdog support
In-Reply-To: <52EACB92.2080700@gmail.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140129181949.GB27143@localhost>
 <20140130205315.GD29184@titan.lakedaemon.net>
 <20140130215056.GA1063@localhost> <52EACB92.2080700@gmail.com>
Message-ID: <20140130221629.GH29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 11:00:50PM +0100, Sebastian Hesselbarth wrote:
> On 01/30/2014 10:50 PM, Ezequiel Garcia wrote:
> >On Thu, Jan 30, 2014 at 03:53:15PM -0500, Jason Cooper wrote:
> >>Ezequiel,
> >>
> >>On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
> >>>On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> >>>>A new round, mostly fixing some minor nitpicks.
> >>>>
> >>>
> >>>If anyone wants to give this a test, here's a public branch:
> >>>
> >>>https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v5
> >>
> >>I just took a quick glance at this (commit oneliners/tags) and there
> >>doesn't appear to be any dependence on Sebastian's series.  Did I miss
> >>something?
> >>
> >
> >True, I've completely missed that. I pushed the branch in a rush!
> >
> >Let me prepare a v6, fixing the remaining issue pointed out by Russell,
> >and push again (together with Sebastian's irqchip fixes).
> 
> Umm, no. Just directly name irqchip-orion fixes. Jason will send a PR
> for irqchip-fixes _with-in_ v3.14 while watchdog will go into v3.15.

Yes, but I'd like to do a topic branch for that irqchip PR.  That way,
we don't have to wait for them to land in an -rc.  We can push the
watchdog changes when they are ready, and they can be based on v3.14-rc1
with irqchip/orion-fixes (or whatever) pulled in.

> In any way, do not include my patches into your set.

Agreed.  I wasn't really keen on including the MMIO patch in the series
since it was already in rmk's patch tracker.  Listing the deps in the
coverletter is enough.

> Jason: Ezequiel's watchdog patches install an irq handler that will
> panic(TM) on a watchdog irq. irqchip-orion does not properly clear
> stale bridge irqs which could signal a watchdog irq left by bootloader
> (or watchdog triggering between bootloader and driver probe).

Ok.  I'll look things over and get some branches setup this weekend.

thx,

Jason.
