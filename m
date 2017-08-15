From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 15 Aug 2017 23:25:53 +0800
Subject: [arm-platforms:irq/fixes-4.13 3/12] include/linux/cpumask.h:24:29:
 warning: 'mask' may be used uninitialized in this function
Message-ID: <201708152345.tWBYGR0b%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/fixes-4.13
head:   7636e759fb20cb932b867b58a9d1a706d0155372
commit: 2090e3e6320fab84046c2d2abf86a18b876bf0a9 [3/12] irqchip/gic: Report that effective affinity is a single target
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2090e3e6320fab84046c2d2abf86a18b876bf0a9
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from include/linux/smp.h:12:0,
                    from include/linux/irq.h:12,
                    from kernel/irq/proc.c:9:
   kernel/irq/proc.c: In function 'show_irq_affinity':
>> include/linux/cpumask.h:24:29: warning: 'mask' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define cpumask_bits(maskp) ((maskp)->bits)
                                ^
   kernel/irq/proc.c:50:24: note: 'mask' was declared here
     const struct cpumask *mask;
                           ^~~~
--
   In file included from include/linux/smp.h:12:0,
                    from include/linux/irq.h:12,
                    from kernel//irq/proc.c:9:
   kernel//irq/proc.c: In function 'show_irq_affinity':
>> include/linux/cpumask.h:24:29: warning: 'mask' may be used uninitialized in this function [-Wmaybe-uninitialized]
    #define cpumask_bits(maskp) ((maskp)->bits)
                                ^
   kernel//irq/proc.c:50:24: note: 'mask' was declared here
     const struct cpumask *mask;
                           ^~~~

vim +/mask +24 include/linux/cpumask.h

^1da177e Linus Torvalds 2005-04-16  16  
ae7a47e7 Rusty Russell  2008-12-30  17  /**
6ba2ef7b Rusty Russell  2009-09-24  18   * cpumask_bits - get the bits in a cpumask
6ba2ef7b Rusty Russell  2009-09-24  19   * @maskp: the struct cpumask *
ae7a47e7 Rusty Russell  2008-12-30  20   *
6ba2ef7b Rusty Russell  2009-09-24  21   * You should only assume nr_cpu_ids bits of this mask are valid.  This is
6ba2ef7b Rusty Russell  2009-09-24  22   * a macro so it's const-correct.
ae7a47e7 Rusty Russell  2008-12-30  23   */
6ba2ef7b Rusty Russell  2009-09-24 @24  #define cpumask_bits(maskp) ((maskp)->bits)
7ea931c9 Paul Jackson   2008-04-28  25  

:::::: The code at line 24 was first introduced by commit
:::::: 6ba2ef7baac23a5d9bb85e28b882d16b439a2293 cpumask: Move deprecated functions to end of header.

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63456 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170815/8cda43dc/attachment-0001.gz>
