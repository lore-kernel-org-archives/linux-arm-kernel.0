From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 4 Mar 2016 10:27:37 -0600
Subject: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr()
 on ARM
In-Reply-To: <m38u1yojmq.fsf@t19.piap.pl>
References: <m337sapw89.fsf@t19.piap.pl> <20160303173522.GA9189@localhost>
 <m38u1yojmq.fsf@t19.piap.pl>
Message-ID: <20160304162737.GA1296@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 07:13:49AM +0100, Krzysztof Ha?asa wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Tue, Mar 01, 2016 at 07:07:18AM +0100, Krzysztof Ha?asa wrote:
> >> Many ARM platforms use a wrapper:
> >> /*
> >>  * Compatibility wrapper for older platforms that do not care about
> >>  * passing the parent device.
> >>  */
> >> static inline void pci_common_init(struct hw_pci *hw)
> >> {
> >>         pci_common_init_dev(NULL, hw);
> >> }
> >> 
> >> which means that pci_bus_assign_domain_nr() can be called without
> >> a parent. This patch fixes the NULL pointer dereference.
> >
> > What exactly is the impact of this?  Does this fix need to be in v4.5?
> > It sounds like it should be, but I need a little more detailed
> > justification, e.g., "platforms X, Y, Z don't boot at all without
> > this change."
> 
> At least CNS3xxx doesn't boot. I haven't verified a couple of others,
> but they may be broken as well.

Good, thanks.  Also (I should have asked this before), please include a
"Fixes:" line so we know exactly when this broke and what stable kernels
need the fix.

Bjorn
