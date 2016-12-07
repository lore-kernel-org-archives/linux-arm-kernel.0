From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Dec 2016 14:11:51 +0800
Subject: [PATCH 1/3] ARM: Define KERNEL_START and KERNEL_END
In-Reply-To: <20161206195312.22354-2-f.fainelli@gmail.com>
Message-ID: <201612071426.t1Kin0Fb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9-rc8 next-20161206]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/ARM-Add-support-for-CONFIG_DEBUG_VIRTUAL/20161207-071442
config: arm-lart_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> drivers/mtd/devices/lart.c:83:0: warning: "KERNEL_START" redefined
    #define KERNEL_START  (BLOB_START + BLOB_LEN)
    
   In file included from arch/arm/include/asm/page.h:163:0,
                    from arch/arm/include/asm/thread_info.h:17,
                    from include/linux/thread_info.h:58,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from drivers/mtd/devices/lart.c:38:
   arch/arm/include/asm/memory.h:117:0: note: this is the location of the previous definition
    #define KERNEL_START  _stext
    

vim +/KERNEL_START +83 drivers/mtd/devices/lart.c

^1da177e Linus Torvalds 2005-04-16  67  
^1da177e Linus Torvalds 2005-04-16  68  /*
^1da177e Linus Torvalds 2005-04-16  69   * These values are specific to LART
^1da177e Linus Torvalds 2005-04-16  70   */
^1da177e Linus Torvalds 2005-04-16  71  
^1da177e Linus Torvalds 2005-04-16  72  /* general */
^1da177e Linus Torvalds 2005-04-16  73  #define BUSWIDTH			4				/* don't change this - a lot of the code _will_ break if you change this */
^1da177e Linus Torvalds 2005-04-16  74  #define FLASH_OFFSET		0xe8000000		/* see linux/arch/arm/mach-sa1100/lart.c */
^1da177e Linus Torvalds 2005-04-16  75  
^1da177e Linus Torvalds 2005-04-16  76  /* blob */
^1da177e Linus Torvalds 2005-04-16  77  #define NUM_BLOB_BLOCKS		FLASH_NUMBLOCKS_16m_PARAM
^1da177e Linus Torvalds 2005-04-16  78  #define BLOB_START			0x00000000
^1da177e Linus Torvalds 2005-04-16  79  #define BLOB_LEN			(NUM_BLOB_BLOCKS * FLASH_BLOCKSIZE_PARAM)
^1da177e Linus Torvalds 2005-04-16  80  
^1da177e Linus Torvalds 2005-04-16  81  /* kernel */
^1da177e Linus Torvalds 2005-04-16  82  #define NUM_KERNEL_BLOCKS	7
^1da177e Linus Torvalds 2005-04-16 @83  #define KERNEL_START		(BLOB_START + BLOB_LEN)
^1da177e Linus Torvalds 2005-04-16  84  #define KERNEL_LEN			(NUM_KERNEL_BLOCKS * FLASH_BLOCKSIZE_MAIN)
^1da177e Linus Torvalds 2005-04-16  85  
^1da177e Linus Torvalds 2005-04-16  86  /* initial ramdisk */
^1da177e Linus Torvalds 2005-04-16  87  #define NUM_INITRD_BLOCKS	24
^1da177e Linus Torvalds 2005-04-16  88  #define INITRD_START		(KERNEL_START + KERNEL_LEN)
^1da177e Linus Torvalds 2005-04-16  89  #define INITRD_LEN			(NUM_INITRD_BLOCKS * FLASH_BLOCKSIZE_MAIN)
^1da177e Linus Torvalds 2005-04-16  90  
^1da177e Linus Torvalds 2005-04-16  91  /*

:::::: The code at line 83 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11578 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/3829bed8/attachment-0001.gz>
