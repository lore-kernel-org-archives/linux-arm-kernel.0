From: lkp@intel.com (kbuild test robot)
Date: Sun, 14 Oct 2018 00:07:53 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 4/30]
 arch/mips/lantiq/xway/dma.c:255:34: error: array type has incomplete element
 type 'struct of_device_id'
Message-ID: <201810140029.pketKugh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   f98d407b9c291bed866c2194b547782083eaf6f8
commit: 35391f5df33ee69e0d2ba0b794bac62712fe2020 [4/30] mips: Do not include linux/irqdomain.h from asm/irq.h
config: mips-xway_defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 35391f5df33ee69e0d2ba0b794bac62712fe2020
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

>> arch/mips/lantiq/xway/dma.c:255:34: error: array type has incomplete element type 'struct of_device_id'
    static const struct of_device_id dma_match[] = {
                                     ^~~~~~~~~
>> arch/mips/lantiq/xway/dma.c:256:4: error: field name not in record or union initializer
     { .compatible = "lantiq,dma-xway" },
       ^
   arch/mips/lantiq/xway/dma.c:256:4: note: (near initialization for 'dma_match')
>> arch/mips/lantiq/xway/dma.c:255:34: error: 'dma_match' defined but not used [-Werror=unused-variable]
    static const struct of_device_id dma_match[] = {
                                     ^~~~~~~~~
   cc1: all warnings being treated as errors

vim +255 arch/mips/lantiq/xway/dma.c

dfec1a82 John Crispin 2011-05-06  254  
ddd4eeca John Crispin 2012-04-12 @255  static const struct of_device_id dma_match[] = {
ddd4eeca John Crispin 2012-04-12 @256  	{ .compatible = "lantiq,dma-xway" },
ddd4eeca John Crispin 2012-04-12  257  	{},
ddd4eeca John Crispin 2012-04-12  258  };
ddd4eeca John Crispin 2012-04-12  259  

:::::: The code at line 255 was first introduced by commit
:::::: ddd4eeca961cc6b1d57e0ca2f264403d690b6882 MIPS: lantiq: convert dma to platform driver

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 16469 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181014/b1fc0212/attachment.gz>
