From: tj@kernel.org (Tejun Heo)
Date: Mon, 7 Dec 2015 09:50:43 -0500
Subject: [PATCH v2] ahci: compile out msi/msix infrastructure
In-Reply-To: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
References: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151207145043.GB9175@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 05, 2015 at 04:18:44PM -0800, Dan Williams wrote:
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
> Tested--by: Arnd Bergmann <arnd@arndb.de>
> [arnd: fix up pci enabled case]
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Fixes: d684a90d38e2 ("ahci: per-port msix support")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-4.5 w/ the typo fixed.

Thanks.

-- 
tejun
