From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 9 Aug 2016 13:04:13 +0200
Subject: [RFC PATCH V5 5/5] PCI: thunder-pem: Support quirky
 configuration space access for ACPI based PCI host controller
In-Reply-To: <1470661541-26270-6-git-send-email-tn@semihalf.com>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-6-git-send-email-tn@semihalf.com>
Message-ID: <20160809110413.GV22012@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.16 15:05:41, Tomasz Nowicki wrote:
> Add infrastructure to support ThunderX PEM specific PCI configuration space
> access for ACPI based PCI host controller. This involves:
> 1. New initialization call thunder_pem_cfg_init() to create configuration
> space mapping based on hardcoded range addresses
> 2. thunder_pem_init() ACPI extension to obtain hardcoded addresses for
> PEM specific register ranges
> 3. New quirk entry (for common quirk array) which identifies platform and
> calls thunder_pem_cfg_init() from [1]
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Robert Richter <rrichter@cavium.com>

> ---
>  drivers/pci/host/mcfg-quirks.c     |  7 +++
>  drivers/pci/host/mcfg-quirks.h     |  4 ++
>  drivers/pci/host/pci-thunder-pem.c | 96 ++++++++++++++++++++++++++++++++------
>  3 files changed, 94 insertions(+), 13 deletions(-)
