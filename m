From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Jul 2015 13:54:48 +0100
Subject: [RFC Patch V1 00/12] Reorganize struct msi_desc to prepare for
 support of generic MSI
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <559FC098.6080606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerry,

On 09/07/15 09:00, Jiang Liu wrote:
> Recently Marc Zyngier <marc.zyngier@arm.com> has posted a patch set at
> https://lkml.org/lkml/2015/7/7/712
> to enhance PCI MSI code to support generic MSI.
> 
> This is a companion patch set to refine struct msi_desc and related data
> structures to support generic MSI, and it would be better to combined with
> Marc's patch set.  It's also requested by
> Stuart Yoder <stuart.yoder@freescale.com>
> 
> It first introduces a helper function msi_desc_to_pci_sysdata(), and
> convert current PCI drivers to use helper functions to access fields
> in struct msi_desc.
> Then it moves msi_list from struct pci_dev into struct device and
> refines struct msi_desc.
> At last it moves alloc_msi_entry() into kernel/irq/msi.c for reuse.
> 
> Currently msi_desc_to_pci_sysdata() and msi_desc_to_pci_dev() are
> implemented as normal functions instead of inlines to avoid header file
> inclusion issue. If inlined version is preferred for performance, we could
> move all of first_pci_msi_entry, for_each_pci_msi_entry, msi_desc_to_pci_dev
> and msi_desc_to_pci_sysdata from linxu/kernel/msi.h into linux/kernel/pci.h.
> 
> This patch set is based on v4.2-rc1 and passes 0day test suite. You
> may access the code at:
> https://github.com/jiangliu/linux.git msi_desc_v1

Thanks a lot for doing this, it looks much helpful. I have a good look
at it, and apart from a small nit I commented on, I'm very happy with
this move.

For the whole set:
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
