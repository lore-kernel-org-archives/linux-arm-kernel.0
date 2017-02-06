From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 03:39:57 +0800
Subject: [hisi:topic-lpc-4.10-libio 138/148] undefined reference to `libio_inb'
Message-ID: <201702070356.hEihEPVn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: c3fb8a18b9d66d740ac05a181c83d12f67f39f24 [138/148] asm-generic: use libio accessors as default
config: cris-etrax-100lx_v2_defconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c3fb8a18b9d66d740ac05a181c83d12f67f39f24
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All errors (new ones prefixed by >>):

   lib/built-in.o: In function `ioread8':
>> (.text+0xa91c): undefined reference to `libio_inb'
   lib/built-in.o: In function `ioread16':
>> (.text+0xa956): undefined reference to `libio_inw'
   lib/built-in.o: In function `ioread16be':
   (.text+0xa990): undefined reference to `libio_inw'
   lib/built-in.o: In function `ioread32':
>> (.text+0xa9cc): undefined reference to `libio_inl'
   lib/built-in.o: In function `ioread32be':
   (.text+0xaa00): undefined reference to `libio_inl'
   lib/built-in.o: In function `iowrite8':
>> (.text+0xaa38): undefined reference to `libio_outb'
   lib/built-in.o: In function `iowrite16':
>> (.text+0xaa6c): undefined reference to `libio_outw'
   lib/built-in.o: In function `iowrite16be':
   (.text+0xaa9c): undefined reference to `libio_outw'
   lib/built-in.o: In function `iowrite32':
>> (.text+0xaadc): undefined reference to `libio_outl'
   lib/built-in.o: In function `iowrite32be':
   (.text+0xab0a): undefined reference to `libio_outl'
   lib/built-in.o: In function `ioread8_rep':
>> (.text+0xab6a): undefined reference to `libio_insb'
   lib/built-in.o: In function `ioread16_rep':
>> (.text+0xabbc): undefined reference to `libio_insw'
   lib/built-in.o: In function `ioread32_rep':
>> (.text+0xac0e): undefined reference to `libio_insl'
   lib/built-in.o: In function `iowrite8_rep':
>> (.text+0xac60): undefined reference to `libio_outsb'
   lib/built-in.o: In function `iowrite16_rep':
>> (.text+0xacb4): undefined reference to `libio_outsw'
   lib/built-in.o: In function `iowrite32_rep':
>> (.text+0xad08): undefined reference to `libio_outsl'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 8450 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/d9011ea5/attachment-0001.gz>
