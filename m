From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 12:36:54 +0200
Subject: [PATCH v2 2/3] pci/designware: Add base driver for Designware PCIe
In-Reply-To: <1429091315-31891-3-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
 <1429091315-31891-3-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <2123546.0rhYViPpvy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 17:48:34 Minghuan Lian wrote:
> The Synopsys Designware IP is shared with couples of platforms
> under multiple architectures. The patch is to provide basic
> architecture-independent Designware PCIe host driver including
> ATU initialization and PCI OPS. Currently, which supports arm
> and arm64 simultaneously.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> change log:
> v1-v2:
> 1. Get MSI chip according to dts property 'msi-parent'
> 2. Simplify platform_get_resource_byname() failure checking   
> 
>  drivers/pci/host/Kconfig                |   3 +
>  drivers/pci/host/Makefile               |   1 +
>  drivers/pci/host/pcie-designware-base.c | 293 ++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-designware-base.h |  63 +++++++
> 

I don't understand this patch at all. What is the relation between
this driver and the existing pcie-designware.c? From the description
above, they would be the same.

	Arnd
