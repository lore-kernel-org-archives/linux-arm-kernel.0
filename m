From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 Jan 2014 10:21:09 +0000
Subject: [PATCH v5 2/4] devicetree: bindings: Document Krait CPU/L1 EDAC
In-Reply-To: <20140116192617.GA13785@codeaurora.org>
References: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
 <1389735034-21430-3-git-send-email-sboyd@codeaurora.org>
 <20140115102701.GA27314@e102568-lin.cambridge.arm.com>
 <20140115165623.GJ14405@codeaurora.org>
 <20140116013840.GA674@codeaurora.org>
 <20140116113332.GC25540@e102568-lin.cambridge.arm.com>
 <20140116180505.GA30925@codeaurora.org>
 <20140116183326.GG25540@e102568-lin.cambridge.arm.com>
 <20140116192617.GA13785@codeaurora.org>
Message-ID: <20140117102109.GA22544@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 07:26:17PM +0000, Stephen Boyd wrote:
> On 01/16, Lorenzo Pieralisi wrote:
> > On Thu, Jan 16, 2014 at 06:05:05PM +0000, Stephen Boyd wrote:
> > > On 01/16, Lorenzo Pieralisi wrote:
> > > > Do we really want to do that ? I am not sure. A cpus node is supposed to
> > > > be a container node, we should not define this binding just because we
> > > > know the kernel creates a platform device for it then.
> > > 
> > > This is just copying more of the ePAPR spec into this document.
> > > It just so happens that having a compatible field here allows a
> > > platform device to be created. I don't see why that's a problem.
> > 
> > I do not see why you cannot define a node like pmu or arch-timer and stick
> > a compatible property in there. cpus node does not represent a device, and
> > must not be created as a platform device, that's my opinion.
> > 
> 
> I had what you're suggesting before in the original revision of
> this patch. Please take a look at the original patch series[1]. I
> suppose it could be tweaked slightly to still have a cache node
> for the L2 interrupt and the next-level-cache pointer from the
> CPUs.

Ok, sorry, we are running around in circles here, basically you moved
the node to cpus according to reviews. I still think that treating cpus
as a device is not a great idea, even though I am in the same
position with C-states and probably will add C-state tables in the cpus
node.

http://comments.gmane.org/gmane.linux.power-management.general/41012

I just would like to see under cpus nodes and properties that apply to
all ARM systems, and avoid defining properties (eg interrupts) that
have different meanings for different ARM cores.

The question related to why the kernel should create a platform device
out of cpus is still open. I really do not want to block your series
for these simple issues but we have to make a decision and stick to that,
I am fine either way if we have a plan.

> > What would you do for big.LITTLE systems ? We are going to create two
> > cpus node because we need two platform devices ? I really think there
> > must be a better way to implement this, but I will let DT maintainers
> > make a decision.
> 
> There is no such thing as big.LITTLE for Krait, so this is not a
> concern.

Yes, but if a core supporting big.LITTLE requires the same concept you
need here we have to cater for that because after all cpus is a node that
exists on ALL ARM systems, we should not rush and find a solution du
jour without thinking about all foreseeable use cases.

Thank you,
Lorenzo
