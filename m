From: lkp@intel.com (kbuild test robot)
Date: Wed, 11 Jul 2018 20:46:09 +0800
Subject: [arm:zii 12/20] net/dsa/slave.c:1169:19: error: initialization from
 incompatible pointer type
Message-ID: <201807112004.ly2kyQ5F%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git zii
head:   3a7146492a32222691cb4e016448b56095ca107a
commit: 3af90831f7beab5ef80878c8ac3586d7ef6733b3 [12/20] net: dsa: Plug in PHYLINK support
config: x86_64-randconfig-x018-201827 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 3af90831f7beab5ef80878c8ac3586d7ef6733b3
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   net/dsa/slave.c: In function 'dsa_slave_get_module_info':
   net/dsa/slave.c:550:9: error: implicit declaration of function 'phylink_ethtool_get_module_info'; did you mean 'phylink_ethtool_get_pauseparam'? [-Werror=implicit-function-declaration]
     return phylink_ethtool_get_module_info(dp->pl, modinfo);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            phylink_ethtool_get_pauseparam
   net/dsa/slave.c: In function 'dsa_slave_get_module_eeprom':
   net/dsa/slave.c:558:9: error: implicit declaration of function 'phylink_ethtool_get_module_eeprom'; did you mean 'phylink_ethtool_get_pauseparam'? [-Werror=implicit-function-declaration]
     return phylink_ethtool_get_module_eeprom(dp->pl, ee, buf);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            phylink_ethtool_get_pauseparam
   net/dsa/slave.c: At top level:
>> net/dsa/slave.c:1169:19: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .mac_link_down = dsa_slave_phylink_mac_link_down,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/dsa/slave.c:1169:19: note: (near initialization for 'dsa_slave_phylink_mac_ops.mac_link_down')
   net/dsa/slave.c:1170:17: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .mac_link_up = dsa_slave_phylink_mac_link_up,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/dsa/slave.c:1170:17: note: (near initialization for 'dsa_slave_phylink_mac_ops.mac_link_up')
   cc1: some warnings being treated as errors

vim +1169 net/dsa/slave.c

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
Size: 26008 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/c763af70/attachment-0001.gz>
