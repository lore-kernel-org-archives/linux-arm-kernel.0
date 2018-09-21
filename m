From: lkp@intel.com (kbuild test robot)
Date: Fri, 21 Sep 2018 12:05:01 +0800
Subject: [PATCH v8 01/20] kasan, mm: change hooks signatures
In-Reply-To: <8b30f2d3e325de843f892e32f076fe9cc726191d.1537383101.git.andreyknvl@google.com>
References: <8b30f2d3e325de843f892e32f076fe9cc726191d.1537383101.git.andreyknvl@google.com>
Message-ID: <201809211218.10PA6RGy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Konovalov/kasan-add-software-tag-based-mode-for-arm64/20180920-172444
config: x86_64-randconfig-x013-201837 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from include/linux/slab.h:129:0,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/kasan.h: In function 'kasan_init_slab_obj':
>> include/linux/kasan.h:111:9: error: 'ptr' undeclared (first use in this function)
     return ptr;
            ^~~
   include/linux/kasan.h:111:9: note: each undeclared identifier is reported only once for each function it appears in
   make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +/ptr +111 include/linux/kasan.h

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
Size: 30217 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/ddb08485/attachment-0001.gz>
