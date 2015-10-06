From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 6 Oct 2015 16:22:38 +0800
Subject: [arm-platforms:irq/gsi-irq-domain-v5 5/10]
 kernel/irq/irqdomain.c:491:12: error: 'const struct irq_domain_ops' has no
 member named 'translate'
Message-ID: <201510061636.Cmak5G9A%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gsi-irq-domain-v5
head:   7ee1e49948841ea333fd8c0e6139be1addcd450a
commit: d335dea54be8019a4f257d9dea9eff2818c67d40 [5/10] WIP: irq_fwspec
config: i386-randconfig-x005-201540 (attached as .config)
reproduce:
        git checkout d335dea54be8019a4f257d9dea9eff2818c67d40
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the arm-platforms/irq/gsi-irq-domain-v5 HEAD 7ee1e49948841ea333fd8c0e6139be1addcd450a builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   kernel/irq/irqdomain.c: In function 'irq_domain_translate':
>> kernel/irq/irqdomain.c:491:12: error: 'const struct irq_domain_ops' has no member named 'translate'
     if (d->ops->translate)
               ^
   kernel/irq/irqdomain.c:492:16: error: 'const struct irq_domain_ops' has no member named 'translate'
      return d->ops->translate(d, fwspec, hwirq, type);
                   ^

vim +491 kernel/irq/irqdomain.c

   485	EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
   486	
   487	static int irq_domain_translate(struct irq_domain *d,
   488					struct irq_fwspec *fwspec,
   489					irq_hw_number_t *hwirq, unsigned int *type)
   490	{
 > 491		if (d->ops->translate)
   492			return d->ops->translate(d, fwspec, hwirq, type);
   493	
   494		if (d->ops->xlate)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23124 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/ddfe76c7/attachment-0001.obj>
