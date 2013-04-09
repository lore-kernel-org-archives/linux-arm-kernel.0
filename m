From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 9 Apr 2013 10:22:33 +0200
Subject: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
In-Reply-To: <20130409081119.GA30736@arm.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
 <20130409081119.GA30736@arm.com>
Message-ID: <20130409082232.GC27255@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 09:11:19AM +0100, Andrew Murray wrote:
[...]
> Also I believe pci_alloc_child_bus function would need to be changed to add
> "b->msi = msi" to inherit msi_chip for child buses in the above patch?

The patch already does:

	child->msi = parent->msi;

in pci_alloc_child_bus(), the same way that ops is inherited. I have
admittedly only tested this code on Tegra, but I don't see why that
wouldn't be enough. Or maybe I haven't understood your question?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130409/99b8cee1/attachment.sig>
