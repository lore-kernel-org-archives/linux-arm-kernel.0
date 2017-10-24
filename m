From: jim2101024@gmail.com (Jim Quinlan)
Date: Tue, 24 Oct 2017 14:15:41 -0400
Subject: Subject: PCI: brcmstb: Add Broadcom Settopbox PCIe support (V2)
Message-ID: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the Broadcom Settopbox PCIe host
controller.  It is targeted to Broadcom Settopbox chips running on
ARM, ARM64, and MIPS platforms.

Changes from V1:

* Patch brcmstb-add-memory-API:
  - fix DT_PROP_DATA_TO_U32 macro.
  - dropped one EXPORT_SYMBOL, changed the other to GPL.
* Patch DT-docs-for-Brcmstb-PCIe:
  - change 'brcm,gen' prop to standard 'max-link-speed'. 
  - rewrite bindings commit to omit standard prop defs.
  - change props "supplies", "supply-names" to "xyz-supply"
* Patch removed: export-symbol-arch_setup_dma_ops [4/9] 
* Patch brcmstb-add-dma-ranges:
  - use get_dma_ops(); also use a const dma_map_ops structure.
  - rewrite map_sg(), unmap_sg(), other calls like syng_sg_*()
  - omit brcm_mapping_error(), but added code in brcm_dma_supported()
  - put all of the notifier code in one compilation unit.
