From: lkp@intel.com (kbuild test robot)
Date: Fri, 21 Sep 2018 15:03:19 +0800
Subject: [PATCH v8 01/20] kasan, mm: change hooks signatures
In-Reply-To: <8b30f2d3e325de843f892e32f076fe9cc726191d.1537383101.git.andreyknvl@google.com>
References: <8b30f2d3e325de843f892e32f076fe9cc726191d.1537383101.git.andreyknvl@google.com>
Message-ID: <201809211535.aQeO07A4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Konovalov/kasan-add-software-tag-based-mode-for-arm64/20180920-172444
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=microblaze 

All errors (new ones prefixed by >>):

   In file included from include/linux/slab.h:129,
                    from include/linux/irq.h:21,
                    from include/asm-generic/hardirq.h:13,
                    from ./arch/microblaze/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from arch/microblaze/kernel/asm-offsets.c:14:
   include/linux/kasan.h: In function 'kasan_init_slab_obj':
>> include/linux/kasan.h:111:9: error: 'ptr' undeclared (first use in this function); did you mean 'qstr'?
     return ptr;
            ^~~
            qstr
   include/linux/kasan.h:111:9: note: each undeclared identifier is reported only once for each function it appears in
   make[2]: *** [arch/microblaze/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +111 include/linux/kasan.h

   102	
   103	static inline void kasan_poison_slab(struct page *page) {}
   104	static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
   105						void *object) {}
   106	static inline void kasan_poison_object_data(struct kmem_cache *cache,
   107						void *object) {}
   108	static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
   109					const void *object)
   110	{
 > 111		return ptr;
   112	}
   113	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12813 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/a18e090f/attachment.gz>
