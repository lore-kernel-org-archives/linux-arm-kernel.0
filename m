From: lkp@intel.com (kbuild test robot)
Date: Fri, 11 May 2018 09:11:41 +0800
Subject: [arm:to-build 2/13] WARNING: vmlinux.o(.text+0x18ff0): Section
 mismatch in reference from the function check_bugs() to the function
 .init.text:check_writebuffer_bugs()
Message-ID: <201805110939.2MJrkFPI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git to-build
head:   7eac243a530d849d5e2502ff3015dd68d1b27de3
commit: cc591a392bd5a56d60f3955c9c8bd15e14477ffa [2/13] ARM: bugs: prepare processor bug infrastructure
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cc591a392bd5a56d60f3955c9c8bd15e14477ffa
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x18ff0): Section mismatch in reference from the function check_bugs() to the function .init.text:check_writebuffer_bugs()
   The function check_bugs() references
   the function __init check_writebuffer_bugs().
   This is often because check_bugs lacks a __init
   annotation or the annotation of check_writebuffer_bugs is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64991 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180511/070af2b7/attachment-0001.gz>
