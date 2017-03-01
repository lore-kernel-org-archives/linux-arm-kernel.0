From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Mar 2017 17:18:27 +0100
Subject: [PATCH 00/20] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Message-ID: <CAK8P3a2ULkNH39UJAeZSuw2kS+7wNyySs1RaY74ELGm498NmnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 4:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> This patch series[1] addresses both issues in one go:
>
> - It updates the pci_remap_iospace() function to use a page mapping
>   that guarantees non-posted write transactions for I/O space addresses
> - It adds a kernel API to remap PCI config space resources, so that
>   architecture can override it with a mapping implementation that
>   guarantees PCI specifications compliancy wrt non-posted write
>   configuration transactions
> - It updates all PCI host controller implementations (and the generic
>   ECAM layer) to use the newly introduced mapping interface
>
> Tested on Juno ECAM based interface (DT/ACPI).

This looks all good to me, nice work!

    Arnd
