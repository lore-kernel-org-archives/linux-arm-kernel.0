From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 26 Sep 2013 11:02:50 +0100
Subject: [PATCH v2 0/2] ARM DT cpus/cpu and topology bindings
In-Reply-To: <5242EA2E.1010106@gmail.com>
References: <1379330464-27917-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130924160126.GC403@e102568-lin.cambridge.arm.com>
 <5242EA2E.1010106@gmail.com>
Message-ID: <20130926100250.GA20705@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 02:50:38PM +0100, Rob Herring wrote:
> On 09/24/2013 11:01 AM, Lorenzo Pieralisi wrote:
> > [replying to self]
> > 
> > Any further comments on this series ? If not, I think bindings are ready to be
> > queued, but for that I need acks from DT maintainers.
> 
> Who do you plan to take this? Is this dependent on something for 3.13?
> If not, I'll apply it.

v3 on the lists, should be final. No, there are no dependencies on 3.13
to the best of my knowledge. The problem with pre-v7 UP systems with
cpus node #address-cells == 0 is still there and I would like to ask you
please what we/I should do about that, it can trigger a considerable
amount of churn. As soon as these bindings hit the mainline I will
update the DT parsing code, I can easily take all pre-v7 UP dts out
of the picture in the parsing loop (after all, reg property for those
processors is useless), but the dts are _wrong_ regardless when these
patches become the official bindings.

Thanks !
Lorenzo

> 
> Rob
> 
> > The issue with in kernel dts that (re)-need patching owing to re-introduction
> > of reg property on pre-v7 UP is still pending.
> > 
> > Please advise, thank you very much,
> > Lorenzo
> > 
> > On Mon, Sep 16, 2013 at 12:21:02PM +0100, Lorenzo Pieralisi wrote:
> >> This is v2 of a previous posting:
> >>
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/192322.html
> >>
> >> - v2 changes
> >> 	- Removed single core cpu-map example
> >> 	- Removed OS dependency from cpus/cpu bindings
> >> 	- Updated Marvell compatible strings
> >> 	- Clarified behaviour on pre ARM v7 uniprocessor systems and updated
> >> 	  examples
> >>
> >> This patch resumes DT topology/cpu bindings discussions for ARM that were
> >> started here:
> >>
> >> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/031725.html
> >> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/032450.html
> >>
> >> Comments welcome, thanks,
> >> Lorenzo
> >>
> >> Lorenzo Pieralisi (2):
> >>   Documentation: devicetree: arm: cpus/cpu nodes bindings updates
> >>   Documentation: DT: arm: define CPU topology bindings
> >>
> >>  Documentation/devicetree/bindings/arm/cpus.txt     | 391 +++++++++++++++--
> >>  Documentation/devicetree/bindings/arm/topology.txt | 474 +++++++++++++++++++++
> >>  2 files changed, 818 insertions(+), 47 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/topology.txt
> >>
> >> -- 
> >> 1.8.2.2
> >>
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
