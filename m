From: lkp@intel.com (kbuild test robot)
Date: Thu, 5 Jan 2017 14:28:50 +0800
Subject: [PATCH v5 13/17] irqdomain: irq_domain_check_msi_remap
In-Reply-To: <1483536746-2725-14-git-send-email-eric.auger@redhat.com>
Message-ID: <201701051438.w4q2qX7B%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc2 next-20170105]
[cannot apply to iommu/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-MSI-passthrough-on-ARM-ARM64-and-IOVA-reserved-regions/20170105-132853
config: i386-randconfig-x003-201701 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/irq/irqdomain.c: In function 'irq_domain_is_msi_remap':
>> kernel/irq/irqdomain.c:289:17: error: 'struct irq_domain' has no member named 'parent'
     for (; h; h = h->parent) {
                    ^~

vim +289 kernel/irq/irqdomain.c

   283	 * @domain: domain pointer
   284	 */
   285	static bool irq_domain_is_msi_remap(struct irq_domain *domain)
   286	{
   287		struct irq_domain *h = domain;
   288	
 > 289		for (; h; h = h->parent) {
   290			if (h->flags & IRQ_DOMAIN_FLAG_MSI_REMAP)
   291				return true;
   292		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25534 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/89886e81/attachment-0001.gz>
