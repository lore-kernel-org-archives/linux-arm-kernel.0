From: lkp@intel.com (kbuild test robot)
Date: Sun, 20 May 2018 03:42:30 +0800
Subject: [arm:zii 12/20] net//dsa/slave.c:1169:19: error: initialization from
 incompatible pointer type
Message-ID: <201805200328.4Cvmxxwe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git zii
head:   58e9ee3ee4dd4574170181ed8751766e234a33a8
commit: 94d9d1358684609c19eceb53aae76f40435b69dc [12/20] net: dsa: Plug in PHYLINK support
config: i386-randconfig-x012-201820 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 94d9d1358684609c19eceb53aae76f40435b69dc
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   net//dsa/slave.c: In function 'dsa_slave_get_module_info':
   net//dsa/slave.c:550:9: error: implicit declaration of function 'phylink_ethtool_get_module_info'; did you mean 'phylink_ethtool_get_pauseparam'? [-Werror=implicit-function-declaration]
     return phylink_ethtool_get_module_info(dp->pl, modinfo);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            phylink_ethtool_get_pauseparam
   net//dsa/slave.c: In function 'dsa_slave_get_module_eeprom':
   net//dsa/slave.c:558:9: error: implicit declaration of function 'phylink_ethtool_get_module_eeprom'; did you mean 'phylink_ethtool_get_pauseparam'? [-Werror=implicit-function-declaration]
     return phylink_ethtool_get_module_eeprom(dp->pl, ee, buf);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            phylink_ethtool_get_pauseparam
   net//dsa/slave.c: At top level:
>> net//dsa/slave.c:1169:19: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .mac_link_down = dsa_slave_phylink_mac_link_down,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net//dsa/slave.c:1169:19: note: (near initialization for 'dsa_slave_phylink_mac_ops.mac_link_down')
   net//dsa/slave.c:1170:17: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .mac_link_up = dsa_slave_phylink_mac_link_up,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net//dsa/slave.c:1170:17: note: (near initialization for 'dsa_slave_phylink_mac_ops.mac_link_up')
   cc1: some warnings being treated as errors

vim +1169 net//dsa/slave.c

  1163	
  1164	static const struct phylink_mac_ops dsa_slave_phylink_mac_ops = {
  1165		.validate = dsa_slave_phylink_validate,
  1166		.mac_link_state = dsa_slave_phylink_mac_link_state,
  1167		.mac_config = dsa_slave_phylink_mac_config,
  1168		.mac_an_restart = dsa_slave_phylink_mac_an_restart,
> 1169		.mac_link_down = dsa_slave_phylink_mac_link_down,
  1170		.mac_link_up = dsa_slave_phylink_mac_link_up,
  1171	};
  1172	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33520 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180520/1dd4f711/attachment-0001.gz>
