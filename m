From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Wed, 15 Apr 2015 17:48:32 +0800
Subject: [PATCH v2 0/3] pci/designware: Add architecture-independent driver
 for Designware PCIe
Message-ID: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Synopsys Designware IP is shared with couples of platforms
under multiple architectures. The series of patches is to
provide basic architecture-independent Designware PCIe host
driver including ATU initialization and PCI OPS. Currently,
which supports arm and arm64 simultaneously.

I do not directly add arm64 support to pcie-designware.c, the
main reason is that it is hard to port other 5 platform PCIe
driver based on pcie-designware to the new implementation.
However, not changing those PCIe driver means the code for
arm32 must be remained.

I add a new file pcie-designware-base.c. Compared with
pcie-designware.c, there are main 3 differences.
1. It is a new implementation followed the latest PCIe
architecture-independent API without any code for specific
architecture.
2. There is no MSI chip code, which will be implemented in a 
separated file.
3. Improve ATU use - support more than 2 ATUs and use an exclusive
ATU to translate MEM transaction.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>

-- 
1.9.1
