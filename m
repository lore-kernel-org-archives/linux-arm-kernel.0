From: lkp@intel.com (kbuild test robot)
Date: Wed, 12 Sep 2018 22:25:14 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 4/5]
 include/linux/irqdomain.h:436:2: error: implicit declaration of function
 'generic_handle_irq_desc'; did you mean 'generic_handle_domain_irq'?
Message-ID: <201809122211.CkuqpZ2v%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   feacd6dd425a07c6e54d2fcca04665ac792c6cb0
commit: 210d3f78aea72fff13ad31616131a0ac27cb0bfe [4/5] irqdesc: Make __handle_domain_irq use irq_data instead of irq numbers
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 210d3f78aea72fff13ad31616131a0ac27cb0bfe
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   In file included from arch/mips/include/asm/irq.h:14:0,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from arch/mips/include/asm/highmem.h:24,
                    from arch/mips/include/asm/pgtable-32.h:23,
                    from arch/mips/include/asm/pgtable.h:14,
                    from include/linux/memremap.h:7,
                    from include/linux/mm.h:27,
                    from arch/mips/kernel/asm-offsets.c:15:
   include/linux/irqdomain.h: In function 'irq_linear_revmap':
   include/linux/irqdomain.h:409:38: error: dereferencing pointer to incomplete type 'struct irq_data'
      return domain->linear_revmap[hwirq]->irq;
                                         ^~
   include/linux/irqdomain.h: In function 'generic_handle_domain_irq':
>> include/linux/irqdomain.h:436:2: error: implicit declaration of function 'generic_handle_irq_desc'; did you mean 'generic_handle_domain_irq'? [-Werror=implicit-function-declaration]
     generic_handle_irq_desc(irq_data_to_desc(data));
     ^~~~~~~~~~~~~~~~~~~~~~~
     generic_handle_domain_irq
>> include/linux/irqdomain.h:436:26: error: implicit declaration of function 'irq_data_to_desc'; did you mean 'irq_to_desc'? [-Werror=implicit-function-declaration]
     generic_handle_irq_desc(irq_data_to_desc(data));
                             ^~~~~~~~~~~~~~~~
                             irq_to_desc
   In file included from include/linux/irq.h:519:0,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from arch/mips/include/asm/highmem.h:24,
                    from arch/mips/include/asm/pgtable-32.h:23,
                    from arch/mips/include/asm/pgtable.h:14,
                    from include/linux/memremap.h:7,
                    from include/linux/mm.h:27,
                    from arch/mips/kernel/asm-offsets.c:15:
   include/linux/irqdesc.h: At top level:
>> include/linux/irqdesc.h:118:32: error: conflicting types for 'irq_data_to_desc'
    static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
                                   ^~~~~~~~~~~~~~~~
   In file included from arch/mips/include/asm/irq.h:14:0,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from arch/mips/include/asm/highmem.h:24,
                    from arch/mips/include/asm/pgtable-32.h:23,
                    from arch/mips/include/asm/pgtable.h:14,
                    from include/linux/memremap.h:7,
                    from include/linux/mm.h:27,
                    from arch/mips/kernel/asm-offsets.c:15:
   include/linux/irqdomain.h:436:26: note: previous implicit declaration of 'irq_data_to_desc' was here
     generic_handle_irq_desc(irq_data_to_desc(data));
                             ^~~~~~~~~~~~~~~~
   In file included from include/linux/irq.h:519:0,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from arch/mips/include/asm/highmem.h:24,
                    from arch/mips/include/asm/pgtable-32.h:23,
                    from arch/mips/include/asm/pgtable.h:14,
                    from include/linux/memremap.h:7,
                    from include/linux/mm.h:27,
                    from arch/mips/kernel/asm-offsets.c:15:
>> include/linux/irqdesc.h:152:20: warning: conflicting types for 'generic_handle_irq_desc'
    static inline void generic_handle_irq_desc(struct irq_desc *desc)
                       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/irqdesc.h:152:20: error: static declaration of 'generic_handle_irq_desc' follows non-static declaration
   In file included from arch/mips/include/asm/irq.h:14:0,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from arch/mips/include/asm/highmem.h:24,
                    from arch/mips/include/asm/pgtable-32.h:23,
                    from arch/mips/include/asm/pgtable.h:14,
                    from include/linux/memremap.h:7,
                    from include/linux/mm.h:27,
                    from arch/mips/kernel/asm-offsets.c:15:
   include/linux/irqdomain.h:436:2: note: previous implicit declaration of 'generic_handle_irq_desc' was here
     generic_handle_irq_desc(irq_data_to_desc(data));
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +436 include/linux/irqdomain.h

   393	
   394	/**
   395	 * irq_linear_revmap() - Find a linux irq from a hw irq number.
   396	 * @domain: domain owning this hardware interrupt
   397	 * @hwirq: hardware irq number in that domain space
   398	 *
   399	 * This is a fast path alternative to irq_find_mapping() that can be
   400	 * called directly by irq controller code to save a handful of
   401	 * instructions. It is always safe to call, but won't find irqs mapped
   402	 * using the radix tree.
   403	 */
   404	static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
   405						     irq_hw_number_t hwirq)
   406	{
   407		if (!irq_domain_is_nomap(domain) && hwirq < domain->revmap_size &&
   408		    domain->linear_revmap[hwirq])
 > 409			return domain->linear_revmap[hwirq]->irq;
   410	
   411		return 0;
   412	}
   413	extern struct irq_data *irq_resolve_mapping(struct irq_domain *host,
   414						    irq_hw_number_t hwirq);
   415	
   416	static inline unsigned int irq_find_mapping(struct irq_domain *host,
   417						    irq_hw_number_t hwirq)
   418	{
   419		struct irq_data *data;
   420	
   421		data = irq_resolve_mapping(host, hwirq);
   422		if (data)
   423			return data->irq;
   424	
   425		return 0;
   426	}
   427	
   428	static inline int generic_handle_domain_irq(struct irq_domain *domain,
   429						    unsigned int hwirq)
   430	{
   431		struct irq_data *data = irq_resolve_mapping(domain, hwirq);
   432	
   433		if (unlikely(!data))
   434			return -EINVAL;
   435	
 > 436		generic_handle_irq_desc(irq_data_to_desc(data));
   437		return 0;
   438	}
   439	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57390 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180912/02411f36/attachment-0001.gz>
