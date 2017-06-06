From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 6 Jun 2017 08:05:01 +0800
Subject: [arm:phy 25/29]
 net/core/ethtool.o:(.text.__ethtool_get_module_info+0x44): undefined
 reference to `sfp_get_module_info'
Message-ID: <201706060859.h6UjqNYb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   3a9fc132d462fcbef5aac7a8b4fe7abcabb9ef1e
commit: 1b72c8ec227c007d6e49f7e780349d4db6ddb257 [25/29] sfp: move module eeprom ethtool access into netdev core ethtool
config: parisc-allmodconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1b72c8ec227c007d6e49f7e780349d4db6ddb257
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

   net/built-in.o: In function `__ethtool_get_module_info':
>> net/core/ethtool.o:(.text.__ethtool_get_module_info+0x44): undefined reference to `sfp_get_module_info'
   net/built-in.o: In function `__ethtool_get_module_eeprom':
>> net/core/ethtool.o:(.text.__ethtool_get_module_eeprom+0x48): undefined reference to `sfp_get_module_eeprom'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50685 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/7ae7f1c9/attachment-0001.gz>
