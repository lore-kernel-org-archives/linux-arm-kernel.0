From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 15 Oct 2015 11:00:28 -0500
Subject: [PATCH] PCI: iproc: fix 32-bit build error
In-Reply-To: <5204456.Kxa6kNhPYW@wuerfel>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
 <561D6458.40504@hauke-m.de> <561D6576.2020107@broadcom.com>
 <5204456.Kxa6kNhPYW@wuerfel>
Message-ID: <20151015160028.GA17702@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 11:00:31PM +0200, Arnd Bergmann wrote:
> On Tuesday 13 October 2015 13:11:34 Ray Jui wrote:
> > >> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> > >> index f3481ddff344..abcb4be2ee19 100644
> > >> --- a/drivers/pci/host/pcie-iproc.c
> > >> +++ b/drivers/pci/host/pcie-iproc.c
> > >> @@ -235,12 +235,13 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
> > >>   *
> > >>   * axi_addr -> iproc_pcie_address -> OARR -> OMAP -> pci_address
> > >>   */
> > >> -static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> > >> +int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
> > > 
> > > Why are you removing the static here?
> > > 
> > 
> > Yeah we should keep this function as static. The rest of this change
> > looks good!
> > 
> 
> Sorry, this accidentally ended up in the patch when I marked the
> function as global to track down how the division got called.
> 
> I'll send a new version.

Ping; I can easily fix up the static, but it'd be nice to have real acks
from Ray and Hauke.

Bjorn
