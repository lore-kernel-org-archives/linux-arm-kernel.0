From: andrew.murray@arm.com (Andrew Murray)
Date: Tue, 9 Apr 2013 09:25:32 +0100
Subject: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
In-Reply-To: <20130409082232.GC27255@avionic-0098.mockup.avionic-design.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
 <20130409081119.GA30736@arm.com>
 <20130409082232.GC27255@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130409082532.GA31140@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 09:22:33AM +0100, Thierry Reding wrote:
> On Tue, Apr 09, 2013 at 09:11:19AM +0100, Andrew Murray wrote:
> [...]
> > Also I believe pci_alloc_child_bus function would need to be changed to add
> > "b->msi = msi" to inherit msi_chip for child buses in the above patch?
> 
> The patch already does:
> 
> 	child->msi = parent->msi;
> 
> in pci_alloc_child_bus(), the same way that ops is inherited. I have
> admittedly only tested this code on Tegra, but I don't see why that
> wouldn't be enough. Or maybe I haven't understood your question?

Sorry I missed that part of your patch - that was exacatly what I was
hoping to see.

Andrew Murray
