From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 25 Sep 2015 18:34:02 -0500
Subject: [PATCH 1/1] PCI/MSI: X-Gene: Remove msi_controller assignment in
 X-Gene PCIe driver
In-Reply-To: <20150918095956.2e27c93c@arm.com>
References: <1442449900-30842-1-git-send-email-dhdang@apm.com>
 <20150918095956.2e27c93c@arm.com>
Message-ID: <20150925233402.GA23134@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 09:59:56AM +0100, Marc Zyngier wrote:
> On Wed, 16 Sep 2015 17:31:40 -0700
> Duc Dang <dhdang@apm.com> wrote:
> 
> > With commit 8d63bc7beaee ("PCI/MSI: pci-xgene-msi: Get rid of
> > struct msi_controller"), it is no longer required to assign
> > msi_controller for X-Gene PCIe host bridge to support MSI. This
> > patch removes this unnecessary code and also helps avoid a warning
> > message ("failed to enable MSI") during boot.
> > 
> > Signed-off-by: Duc Dang <dhdang@apm.com>
> > Cc: Tanmay Inamdar <tinamdar@apm.com>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I lost the original mail from Duc, but I applied this to pci/host-xgene for
v4.4 with this changelog:

commit 00b9b91cb330e70b6bc571a9aa7175b4590ca452
Author: Duc Dang <dhdang@apm.com>
Date:   Wed Sep 16 17:31:40 2015 -0700

    PCI/MSI: xgene: Remove msi_controller assignment
    
    After 8d63bc7beaee ("PCI/MSI: pci-xgene-msi: Get rid of struct
    msi_controller"), it is no longer required to assign msi_controller for
    X-Gene PCIe host bridge to support MSI.
    
    Remove this unnecessary code.  This also avoids a warning message ("failed
    to enable MSI") during boot.
    
    [bhelgaas: changelog]
    Signed-off-by: Duc Dang <dhdang@apm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Marc Zyngier <marc.zyngier@arm.com>
    Cc: Tanmay Inamdar <tinamdar@apm.com>
