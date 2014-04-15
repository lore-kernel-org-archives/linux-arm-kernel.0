From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 17:55:07 +0200
Subject: [PATCH 0/2] ARM SMMU fixes
In-Reply-To: <20140414165858.GI12916@arm.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <53440057.6020703@arm.com> <20140414165858.GI12916@arm.com>
Message-ID: <15544035.e9eK8n7TO4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Monday 14 April 2014 17:58:58 Will Deacon wrote:
> On Tue, Apr 08, 2014 at 02:57:43PM +0100, Marc Zyngier wrote:
> > On 08/04/14 14:41, Laurent Pinchart wrote:
> > > I've obviously forgotten that Will was away for a month. CC'ing Marc
> > > Zyngier.
> > >
> > > On Thursday 03 April 2014 01:52:55 Laurent Pinchart wrote:
> > >> On Friday 28 February 2014 16:37:08 Laurent Pinchart wrote:
> > >>> Hello Will,
> > >>> 
> > >>> I've studied your arm-smmu driver as a base to write a Renesas IOMMU
> > >>> driver and found two small issues. Here are patches to fix them.
> > >>> Please bear with me if my understanding was incorrect and the patches
> > >>> wrong :-)
> > >>> 
> > >>> Laurent Pinchart (2):
> > >>>   iommu/arm-smmu: Replace list walk with platform driver data
> > >>>   iommu/arm-smmu: Return 0 on unmap failure
> > >>>  
> > >>>  drivers/iommu/arm-smmu.c | 17 +++++------------
> > >>>  1 file changed, 5 insertions(+), 12 deletions(-)
> > >> 
> > >> Do you plan to take these patches (or at least patch 2/2) in your tree
> > >> ? I can send a pull request to Joerg if you give me your acked-by.
> > > 
> > > Marc, would you like to handle this, or would you prefer to wait until
> > > Will comes back ?
> > 
> > Hi Laurent,
> > 
> > Yup, I'll have a look and stash them in a temp tree. Given that Will
> > will be back in about a week, he will have the final say.
> 
> I've already got the fix queued ("Return 0 on unmap failure") and plan to
> send it to Joerg this week.

Thank you.

> I think the other patch doesn't really add anything to the driver :)

Fair enough, it's your driver, so the decision is yours :-)

On a different but related topic, I've written an ipmmu-vmsa.c driver for a 
Renesas IOMMU. The IP core has custom registers but uses VMSA-compatible page 
tables. What would you think about sharing the page table management code 
between the two drivers ? The biggest difference between the two 
implementations is that I've hardcoded the long descriptor format, while you 
have reused more system MMU macros that make the arm-smmu driver use 2 or 3 
levels of page tables depending on whether LPAE is disabled or enabled.

-- 
Regards,

Laurent Pinchart
