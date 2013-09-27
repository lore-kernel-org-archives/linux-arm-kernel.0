From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 13:07:56 +0200
Subject: [PATCH 4/9] iommu/arm-smmu: Check for num_context_irqs > 0 to
 avoid divide by zero exception
In-Reply-To: <20130927104802.GF9057@mudshark.cambridge.arm.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-5-git-send-email-andreas.herrmann@calxeda.com>
 <20130927084154.GB8319@mudshark.cambridge.arm.com>
 <20130927090348.GF3315@alberich>
 <20130927102307.GE9057@mudshark.cambridge.arm.com>
 <20130927103949.GM3315@alberich>
 <20130927104802.GF9057@mudshark.cambridge.arm.com>
Message-ID: <20130927110756.GP3315@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 06:48:02AM -0400, Will Deacon wrote:
> On Fri, Sep 27, 2013 at 11:39:49AM +0100, Andreas Herrmann wrote:
> > On Fri, Sep 27, 2013 at 06:23:07AM -0400, Will Deacon wrote:
> > > What do you think?
> > 
> > Yes, that should suffice.
> > 
> > I know it's clear for us but what about a short comment to emphasize
> > that we expect to find at least one context irq?
> > 
> > -       if (num_irqs < smmu->num_global_irqs) {
> > +       /* expect num_global_irqs plus at least one context irq */
> > +       if (num_irqs <= smmu->num_global_irqs) {
> > 
> > which can be translated to
> > 
> > -       if (num_irqs < smmu->num_global_irqs) {
> > +       if (!smmu->num_context_irqs) {
> 
> Even better! Do you want to send a patch, or shall I just create one myself?

I can do it.
(Have to update other patches anyway.)


Andreas
