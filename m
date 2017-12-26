From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 27 Dec 2017 03:39:00 +0800
Subject: [arm:phy 15/66] drivers/net/dsa/mv88e6xxx/global2.h:449: multiple
 definition of `mv88e6xxx_g2_scratch_gpio_set_ext_smi'
Message-ID: <201712270356.ThdSJv37%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   73c2c610e10e5b83922c0be529c000a9506d0630
commit: 4520555b93f27772482e7e0ae714641633c8bf16 [15/66] net: dsa: mv88e6xxx: Enable external MDIO bus
config: x86_64-randconfig-s1-12270141 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 4520555b93f27772482e7e0ae714641633c8bf16
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/dsa/mv88e6xxx/serdes.o: In function `mv88e6xxx_g2_scratch_gpio_set_ext_smi':
>> drivers/net/dsa/mv88e6xxx/global2.h:449: multiple definition of `mv88e6xxx_g2_scratch_gpio_set_ext_smi'
   drivers/net/dsa/mv88e6xxx/chip.o:drivers/net/dsa/mv88e6xxx/global2.h:449: first defined here

vim +449 drivers/net/dsa/mv88e6xxx/global2.h

   446	
   447	int mv88e6xxx_g2_scratch_gpio_set_ext_smi(struct mv88e6xxx_chip *chip,
   448						  bool external)
 > 449	{
   450		return -EOPNOTSUPP;
   451	}
   452	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30903 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171227/a0d57286/attachment-0001.gz>
