From: helgaas@kernel.org (Bjorn Helgaas)
Date: Sun, 4 Sep 2016 21:22:03 -0500
Subject: [RFC PATCH V5 1/5] PCI: Embed pci_ecam_ops in pci_config_window
 structure
In-Reply-To: <20160902153845.GA11234@red-moon>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-2-git-send-email-tn@semihalf.com>
 <20160901182345.GA18461@localhost>
 <20160902153845.GA11234@red-moon>
Message-ID: <20160905022203.GB30488@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 04:38:45PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Sep 01, 2016 at 01:23:45PM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 08, 2016 at 03:05:37PM +0200, Tomasz Nowicki wrote:
> > > pci_config_window keeps pointer to pci_ecam_ops and every time
> > > we want to deallocate pci_config_window (pci_ecam_free()) we need to make
> > > sure to free pci_ecam_ops in case it was dynamically allocated prior to
> > > pci_ecam_create() call.
> > 
> > I think this is a theoretical problem, right?  All the current callers
> > pass a pointer to a static pci_ecam_ops struct that does not need to
> > be deallocated.
> > 
> > I see that the next patch uses a pci_ecam_ops struct on the stack,
> 
> I asked Tomasz why we need to have pci_ecam_ops on the stack in the
> first place since I do not think it is needed, or nicer (actually I
> think it is not nice at all, what's the problem in making it static ?).

If it's useful to copy the struct instead of saving the pointer, that's
fine.  I just want the changelog to match the diff.

Bjorn
