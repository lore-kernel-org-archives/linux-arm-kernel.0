From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Aug 2015 09:32:17 +0200
Subject: [GIT PULL] Xilinx ZynqMP DT changes for v4.3
In-Reply-To: <55C225A7.9050704@monstr.eu>
References: <55BB369F.4080100@monstr.eu> <20150805090016.GI6390@localhost>
 <55C225A7.9050704@monstr.eu>
Message-ID: <20150806073217.GB22787@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 05:03:03PM +0200, Michal Simek wrote:
> Hi Olof,
> 
> On 08/05/2015 11:00 AM, Olof Johansson wrote:
> > On Fri, Jul 31, 2015 at 10:49:35AM +0200, Michal Simek wrote:
> >> Hi,
> >>
> >> please pull these ARM64 DT patches to your tree.
> >>
> >> Thanks,
> >> Michal
> >>
> >>
> >> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> >>
> >>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.3
> >>
> >> for you to fetch changes up to f49310dc62f68ae9f905f9a1e42224fa23867f47:
> >>
> >>   ARM64: zynqmp: Move SPI nodes to the right location (2015-07-31
> >> 10:46:34 +0200)
> >>
> >> ----------------------------------------------------------------
> >> arm: Xilinx ZynqMP dt patches for v4.3
> >>
> >> - Add SATA, GPIO, CAN, SMMU, USB, SPI, I2C, watchdog and sdhci for zynqmp
> >> - Sort nodes in dtsi
> > 
> > You seem to sort these alphabetically. We normally encourage sorting by unit
> > address instead. Was there some reason you chose alphabetical?
> 
> Normally if you look for something you can't remember addresses but you
> remember names that's why this sorting is more natural at least for me.

Main purpose of sorting tends to be to avoid having add-add conflicts by new
entries going into different parts of the file. If different files are sorted
differently (but see below), it's hard for contributors to figure out where
they should add stuff.

> I have checked APM/EXYNOS/Juno/SPR for example (and probably others) and
> there is no order at all.

Yeah, it's in pretty bad shape. There have been some efforts to fix sorting in
the past, but it tends to degrade over time. I suspect part of this is due to
some patches lacking enough context such that the tools apply them to the wrong
part of the file. In other cases it's just neglect or forgetfulness.

> If this is any strict requirement to sort nodes by addresses I am happy
> to send patch on the top of this series to fix it. That's why please let
> me know.

It's not a strict requirement, it's just that when others have made efforts to
sort they have done so by unitid instead.

I'll merge this branch, it's probably not worth it to follow up with another
reshuffle. As you say, most other files are in even worse shape so it's
a losing battle.

> There are other questions what to do with clocks for example - having
> them on the bus like it is done for us and Cavium/Exynos/Seattle or
> having separate node on the bus like APM.
> Using soc node is another question.
> 
> I know that Grant wanted to update any guide which should cover these
> stuff but I am not aware if we have any doc which describe it.

Sounds like a suitable topic for one of many DT sessions at conferences around
the world these days, if you're attending any. It's usually easier to corner
people at those and hash things out.


-Olof
