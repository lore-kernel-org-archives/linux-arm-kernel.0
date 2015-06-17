From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Jun 2015 09:42:56 +0100
Subject: [PATCHv2 1/7] arm: perf: factor arm_pmu core out to drivers
In-Reply-To: <20150616214432.GV7557@n2100.arm.linux.org.uk>
References: <1434041060-16378-1-git-send-email-mark.rutland@arm.com>
 <1434041060-16378-2-git-send-email-mark.rutland@arm.com>
 <20150616161728.GI30522@arm.com>
 <20150616214432.GV7557@n2100.arm.linux.org.uk>
Message-ID: <20150617084255.GA6303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 10:44:32PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 16, 2015 at 05:17:28PM +0100, Will Deacon wrote:
> > I wonder whether that's such a good name for the subsystem. We already
> > have a bunch of perf_* headers directly under include/linux/ for the perf
> > core interfaces, so maybe drivers/pmu/ would be better?
> 
> I think drivers/perf/ is better than drivers/pmu/.  PMU can mean many
> things - performance monitor unit, power management unit, ...
> 
> There comes a point where the use of TLAs becomes excessive, confusing
> and annoying, and I think this is it.

Okey doke, if the perf core guys don't mind the slightly odd namespace
split of <include/linux/perf_*.h> for the core stuff and
<include/linux/perf/*.h> for the PMU drivers, then we can stick with
Mark's proposal.

Will
