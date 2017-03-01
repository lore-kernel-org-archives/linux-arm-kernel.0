From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Mar 2017 17:15:14 +0100
Subject: [PATCH 01/20] PCI: remove __weak tag from pci_remap_iospace()
In-Reply-To: <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
Message-ID: <CAK8P3a36fX2gdgdYcVT1Zg=5dsN1o-Z=Xy4471zxRWwnr1aZvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 4:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> pci_remap_iospace() is marked as a weak symbol even though
> no architecture is currently overriding it; given that its
> implementation internals have already code paths that are
> arch specific (ie PCI_IOBASE and ioremap_page_range() attributes)
> there is no need to leave the weak symbol in the kernel since the
> same functionality can be achieved by customizing per-arch the
> corresponding functionality.
>
> Remove the __weak symbol from pci_remap_iospace().

Good idea,

Acked-by: Arnd Bergmann <arnd@arndb.de>
