From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Sep 2015 19:27:26 +0100
Subject: [PATCH v5 0/6] irqchip, gicv3: Updates and Cavium ThunderX
 errata workarounds
In-Reply-To: <20150922190932.4391652a@arm.com>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
 <20150922175701.65ee4437@arm.com> <20150922190932.4391652a@arm.com>
Message-ID: <20150922182726.GN7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 07:09:32PM +0100, Marc Zyngier wrote:
> On Tue, 22 Sep 2015 17:57:01 +0100
> Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> [Duh. Now with Will and Catalin on CC]
> 
> > On Mon, 21 Sep 2015 22:58:33 +0200
> > Robert Richter <rric@kernel.org> wrote:
> > 
> > > From: Robert Richter <rrichter@cavium.com>
> > > 
> > > This patch series adds gicv3 updates and workarounds for HW errata in
> > > Cavium's ThunderX GICV3.
> > > 
> > > The patches has been rebased onto 4.3-rc1. Note that there are two
> > > important fixes. See below for all changes.
> > > 
> > > The first one is an unchanged resubmission of a patch from a gicv3
> > > series I sent a while ago.
> > > 
> > > The next patches implement the workarounds for ThunderX's gicv3. Patch
> > > #2 implements the cpu workaround for gicv3 on ThunderX. Patch #3 is a
> > > prerequisit for patch #5. Patch #4 adds generic code to parse the hw
> > > revision provided by an IIDR. This patch is used for the implementa-
> > > tion of the actual gicv3-its workaround in #5. Patch #6 updates to the
> > > new jump label API.
> > > 
> > > All current review comments addressed so far with v5
> > 
> > Catalin, Will: assuming you don't have any objection to this series,
> > how do you want to deal with patch 2?

What are the actual dependencies here? AFAICT, the series is addressing
multiple errata, so would it be possible to make the arm64 bits somewhat
independent from the gic parts?

Also, I assume this is targetting 4.4?

Will
