From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 May 2017 16:53:26 +0100
Subject: [PATCH] ARM64: PCI: Fix struct acpi_pci_root_ops allocation
 failure path
In-Reply-To: <20170522154828.10872-1-lorenzo.pieralisi@arm.com>
References: <20170522154828.10872-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170525155326.GB1610@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 04:48:28PM +0100, Lorenzo Pieralisi wrote:
> From: Timmy Li <lixiaoping3@huawei.com>
> 
> Commit 093d24a20442 ("arm64: PCI: Manage controller-specific data on
> per-controller basis") added code to allocate ACPI PCI root_ops
> dynamically on a per host bridge basis but failed to update the
> corresponding memory allocation failure path in pci_acpi_scan_root()
> leading to a potential memory leakage.
> 
> Fix it by adding the required kfree call.
> 
> Fixes: 093d24a20442 ("arm64: PCI: Manage controller-specific data on per-controller basis")
> Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
> [lorenzo.pieralisi at arm.com: refactored code, rewrote commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>

I queued the patch for 4.12. Thanks.

-- 
Catalin
