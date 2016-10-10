From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 10 Oct 2016 12:16:30 -0500
Subject: [PATCH 1/5] PCI: aardvark: Name private struct pointer "advk"
 consistently
In-Reply-To: <20161007220734.5f43e444@free-electrons.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161007220734.5f43e444@free-electrons.com>
Message-ID: <20161010171630.GA12748@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Oct 07, 2016 at 10:07:34PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 07 Oct 2016 11:20:53 -0500, Bjorn Helgaas wrote:
> > Use a device-specific name, "advk", for struct advk_pcie pointers to hint
> > that this is device-specific information.  No functional change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/host/pci-aardvark.c |  370 +++++++++++++++++++--------------------
> >  1 file changed, 183 insertions(+), 187 deletions(-)
> 
> For the entire series:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Sorry to iterate on this even more, but I renamed the local variables
from "advk" to "advk_pcie" since some of these are SoCs with drivers
other than just PCI, and I renamed "advk_readl" to "advk_pcie_readl"
similarly.  I repushed the branch.

Bjorn
