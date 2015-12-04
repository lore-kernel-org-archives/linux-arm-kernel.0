From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Dec 2015 22:46:19 +0100
Subject: [PATCH] ahci: compile out msi/msix infrastructure
In-Reply-To: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
References: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <2378126.FJZNlQmf9U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 December 2015 11:58:30 Dan Williams wrote:
> Quoting Arnd:
>     The AHCI driver is used for some on-chip devices that do not use PCI
>     for probing, and it can be built even when CONFIG_PCI is disabled, but
>     that now results in a build failure:
> 
>     ata/libahci.c: In function 'ahci_host_activate_multi_irqs':
>     ata/libahci.c:2475:4: error: invalid use of undefined type 'struct msix_entry'
>     ata/libahci.c:2475:21: error: dereferencing pointer to incomplete type 'struct msix_entry'
> 
> Add ifdef CONFIG_PCI_MSI infrastructure to compile out the mutli-msi and
> multi-msix code.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Fixes: d684a90d38e2 ("ahci: per-port msix support")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks a lot, looks good. I've verified that this fixes the build on the
configuration that failed earlier.

Tested-by: Arnd Bergmann <arnd@arndb.de>
