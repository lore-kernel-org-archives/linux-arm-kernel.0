From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Feb 2014 16:01:58 +0000
Subject: [PATCH 03/18] arm64: boot protocol documentation update for GICv3
In-Reply-To: <530E0F63.3070007@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-4-git-send-email-marc.zyngier@arm.com>
 <20140225180658.GH23136@mudshark.cambridge.arm.com>
 <530DFC0C.3040704@arm.com>
 <20140226153142.GA12882@mudshark.cambridge.arm.com>
 <530E0F63.3070007@arm.com>
Message-ID: <20140226160157.GD12882@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 03:59:31PM +0000, Marc Zyngier wrote:
> On 26/02/14 15:31, Will Deacon wrote:
> > On Wed, Feb 26, 2014 at 02:37:00PM +0000, Marc Zyngier wrote:
> >> On 25/02/14 18:06, Will Deacon wrote:
> >>> On Wed, Feb 05, 2014 at 01:30:35PM +0000, Marc Zyngier wrote:
> >>>> Linux has some requirements that must be satisfied in order to boot
> >>>> on a system built with a GICv3.
> >>>>
> >>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>>> ---
> >>>>  Documentation/arm64/booting.txt | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> >>>> index a9691cc..4a02ebd 100644
> >>>> --- a/Documentation/arm64/booting.txt
> >>>> +++ b/Documentation/arm64/booting.txt
> >>>> @@ -131,6 +131,13 @@ Before jumping into the kernel, the following conditions must be met:
> >>>>    the kernel image will be entered must be initialised by software at a
> >>>>    higher exception level to prevent execution in an UNKNOWN state.
> >>>>  
> >>>> +  For systems with a GICv3 interrupt controller, it is expected that:
> >>>> +  - ID_AA64PFR0_EL1.GIC (bits [27:24]) must have the value 0b0001
> >>>
> >>> Since ID_AA64PFR0_EL1 is read-only at all exception levels, I don't see the
> >>> value of this statement.
> >>
> >> Think virtualization. A hypervisor can control reads of ID_AA64PFR0_EL1
> >> by setting HCR_EL2.TID3, and report whatever it wants.
> > 
> > Sure, but it seems unreasonable to me that we require a hypervisor to tell a
> > guest about GICv3 if the system happens to have one. What if it wants to
> > emulate a GICv2? In other words, requiring this in booting.txt seems
> > superflous.
> 
> The hypervisor can perfectly mask out the GICv3 feature if it wants to.
> The point I'm trying to make here is that if a guest is expected to be
> able to use the GICv3 system registers, then ID_AA64PFR0_EL1 should
> report so.

Fair enough, but that's not what the text says :)

Will
