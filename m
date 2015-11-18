From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Nov 2015 02:56:23 +0800
Subject: [PATCH v3] crypto: atmel: fix bogus select
In-Reply-To: <12173927.U7ILfy5BBh@wuerfel>
Message-ID: <201511190217.IGFIPXYT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on: cryptodev/master]
[also build test WARNING on: v4.4-rc1 next-20151118]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/crypto-atmel-fix-bogus-select/20151118-233706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/crypto/atmel-aes.c:191:25: sparse: incompatible types in comparison expression (different type sizes)
   drivers/crypto/atmel-aes.c:447:25: sparse: incompatible types in comparison expression (different type sizes)
   drivers/crypto/atmel-aes.c:448:25: sparse: incompatible types in comparison expression (different type sizes)
   In file included from drivers/crypto/atmel-aes.c:17:0:
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_sg_copy':
   include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
     (void) (&_min1 == &_min2);  \
                    ^
>> drivers/crypto/atmel-aes.c:191:11: note: in expansion of macro 'min'
      count = min(count, buflen);
              ^
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_start':
   include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
     (void) (&_min1 == &_min2);  \
                    ^
   drivers/crypto/atmel-aes.c:447:11: note: in expansion of macro 'min'
      count = min(dd->total, sg_dma_len(dd->in_sg));
              ^
   include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
     (void) (&_min1 == &_min2);  \
                    ^
   drivers/crypto/atmel-aes.c:448:11: note: in expansion of macro 'min'
      count = min(count, sg_dma_len(dd->out_sg));
              ^
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from drivers/crypto/atmel-aes.c:17:
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_stop':
>> include/linux/kern_levels.h:4:18: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'size_t {aka long unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:10:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^
   include/linux/printk.h:252:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^
>> drivers/crypto/atmel-aes.c:642:5: note: in expansion of macro 'pr_err'
        pr_err("not all data converted: %u\n", count);
        ^
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_buff_init':
>> drivers/crypto/atmel-aes.c:669:20: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
      dev_err(dd->dev, "dma %d bytes error\n", dd->buflen);
                       ^
   drivers/crypto/atmel-aes.c:677:20: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
      dev_err(dd->dev, "dma %d bytes error\n", dd->buflen);
                       ^

sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/crypto/atmel-aes.c:191:25: sparse: incompatible types in comparison expression (different type sizes)
   drivers/crypto/atmel-aes.c:447:25: sparse: incompatible types in comparison expression (different type sizes)
   drivers/crypto/atmel-aes.c:448:25: sparse: incompatible types in comparison expression (different type sizes)
   In file included from drivers/crypto/atmel-aes.c:17:0:
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_sg_copy':
   include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
     (void) (&_min1 == &_min2);  \
                    ^
   drivers/crypto/atmel-aes.c:191:11: note: in expansion of macro 'min'
      count = min(count, buflen);
              ^
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_start':
   include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
     (void) (&_min1 == &_min2);  \
                    ^
   drivers/crypto/atmel-aes.c:447:11: note: in expansion of macro 'min'
      count = min(dd->total, sg_dma_len(dd->in_sg));
              ^
   include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
     (void) (&_min1 == &_min2);  \
                    ^
   drivers/crypto/atmel-aes.c:448:11: note: in expansion of macro 'min'
      count = min(count, sg_dma_len(dd->out_sg));
              ^
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from drivers/crypto/atmel-aes.c:17:
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_stop':
   include/linux/kern_levels.h:4:18: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'size_t {aka long unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:10:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^
   include/linux/printk.h:252:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^
   drivers/crypto/atmel-aes.c:642:5: note: in expansion of macro 'pr_err'
        pr_err("not all data converted: %u\n", count);
        ^
   drivers/crypto/atmel-aes.c: In function 'atmel_aes_buff_init':
   drivers/crypto/atmel-aes.c:669:20: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
      dev_err(dd->dev, "dma %d bytes error\n", dd->buflen);
                       ^
   drivers/crypto/atmel-aes.c:677:20: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
      dev_err(dd->dev, "dma %d bytes error\n", dd->buflen);
                       ^

vim +/min +191 drivers/crypto/atmel-aes.c

bd3c7b5c Nicolas Royer 2012-07-01  175  
bd3c7b5c Nicolas Royer 2012-07-01  176  		sg_list = sg_next(sg_list);
bd3c7b5c Nicolas Royer 2012-07-01  177  		if (!sg_list)
bd3c7b5c Nicolas Royer 2012-07-01  178  			total = 0;
bd3c7b5c Nicolas Royer 2012-07-01  179  	}
bd3c7b5c Nicolas Royer 2012-07-01  180  
bd3c7b5c Nicolas Royer 2012-07-01  181  	return sg_nb;
bd3c7b5c Nicolas Royer 2012-07-01  182  }
bd3c7b5c Nicolas Royer 2012-07-01  183  
cadc4ab8 Nicolas Royer 2013-02-20  184  static int atmel_aes_sg_copy(struct scatterlist **sg, size_t *offset,
cadc4ab8 Nicolas Royer 2013-02-20  185  			void *buf, size_t buflen, size_t total, int out)
cadc4ab8 Nicolas Royer 2013-02-20  186  {
cadc4ab8 Nicolas Royer 2013-02-20  187  	unsigned int count, off = 0;
cadc4ab8 Nicolas Royer 2013-02-20  188  
cadc4ab8 Nicolas Royer 2013-02-20  189  	while (buflen && total) {
cadc4ab8 Nicolas Royer 2013-02-20  190  		count = min((*sg)->length - *offset, total);
cadc4ab8 Nicolas Royer 2013-02-20 @191  		count = min(count, buflen);
cadc4ab8 Nicolas Royer 2013-02-20  192  
cadc4ab8 Nicolas Royer 2013-02-20  193  		if (!count)
cadc4ab8 Nicolas Royer 2013-02-20  194  			return off;
cadc4ab8 Nicolas Royer 2013-02-20  195  
cadc4ab8 Nicolas Royer 2013-02-20  196  		scatterwalk_map_and_copy(buf + off, *sg, *offset, count, out);
cadc4ab8 Nicolas Royer 2013-02-20  197  
cadc4ab8 Nicolas Royer 2013-02-20  198  		off += count;
cadc4ab8 Nicolas Royer 2013-02-20  199  		buflen -= count;

:::::: The code at line 191 was first introduced by commit
:::::: cadc4ab8f6f73719ef0e124320cdd210d1c9ff3e crypto: atmel-aes - add support for latest release of the IP (0x130)

:::::: TO: Nicolas Royer <nicolas@eukrea.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51069 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151119/d0dc8111/attachment-0001.obj>
