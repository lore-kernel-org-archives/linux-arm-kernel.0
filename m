From: lkp@intel.com (kbuild test robot)
Date: Wed, 11 Jul 2018 21:41:04 +0800
Subject: [arm:zii 12/20] net/dsa/slave.c:1169:26: sparse: incorrect type in
 initializer (different argument counts)
Message-ID: <201807112102.RrVOqWKK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git zii
head:   3a7146492a32222691cb4e016448b56095ca107a
commit: 3af90831f7beab5ef80878c8ac3586d7ef6733b3 [12/20] net: dsa: Plug in PHYLINK support
reproduce:
        # apt-get install sparse
        git checkout 3af90831f7beab5ef80878c8ac3586d7ef6733b3
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   net/dsa/slave.c:434:13: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got  const [noderef] <asn:3>*__vpp_verify @@
   net/dsa/slave.c:434:13:    expected void const [noderef] <asn:3>*__vpp_verify
   net/dsa/slave.c:434:13:    got struct pcpu_sw_netstats *<noident>
   net/dsa/slave.c:550:16: sparse: undefined identifier 'phylink_ethtool_get_module_info'
   net/dsa/slave.c:558:16: sparse: undefined identifier 'phylink_ethtool_get_module_eeprom'
   net/dsa/slave.c:593:21: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got  const [noderef] <asn:3>*__vpp_verify @@
   net/dsa/slave.c:593:21:    expected void const [noderef] <asn:3>*__vpp_verify
   net/dsa/slave.c:593:21:    got struct pcpu_sw_netstats *<noident>
   net/dsa/slave.c:953:21: sparse: incorrect type in initializer (different address spaces) @@    expected void const [noderef] <asn:3>*__vpp_verify @@    got  const [noderef] <asn:3>*__vpp_verify @@
   net/dsa/slave.c:953:21:    expected void const [noderef] <asn:3>*__vpp_verify
   net/dsa/slave.c:953:21:    got struct pcpu_sw_netstats *<noident>
>> net/dsa/slave.c:1169:26: sparse: incorrect type in initializer (different argument counts) @@    expected void ( *mac_link_down )( ... ) @@    got void ( *mac_link_down )( ... ) @@
   net/dsa/slave.c:1169:26:    expected void ( *mac_link_down )( ... )
   net/dsa/slave.c:1169:26:    got void ( *<noident> )( ... )
>> net/dsa/slave.c:1170:24: sparse: incorrect type in initializer (incompatible argument 3 (different base types)) @@    expected void ( *mac_link_up )( ... ) @@    got void ( *mac_link_up )( ... ) @@
   net/dsa/slave.c:1170:24:    expected void ( *mac_link_up )( ... )
   net/dsa/slave.c:1170:24:    got void ( *<noident> )( ... )
   net/dsa/slave.c:1332:20: sparse: incorrect type in assignment (different address spaces) @@    expected struct pcpu_sw_netstats *stats64 @@    got struct pcpu_sw_nestruct pcpu_sw_netstats *stats64 @@
   net/dsa/slave.c:1332:20:    expected struct pcpu_sw_netstats *stats64
   net/dsa/slave.c:1332:20:    got struct pcpu_sw_netstats [noderef] <asn:3>*pcpu_stats
   net/dsa/slave.c:1365:22: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:3>*__pdata @@    got stvoid [noderef] <asn:3>*__pdata @@
   net/dsa/slave.c:1365:22:    expected void [noderef] <asn:3>*__pdata
   net/dsa/slave.c:1365:22:    got struct pcpu_sw_netstats *stats64
   net/dsa/slave.c:1382:22: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:3>*__pdata @@    got stvoid [noderef] <asn:3>*__pdata @@
   net/dsa/slave.c:1382:22:    expected void [noderef] <asn:3>*__pdata
   net/dsa/slave.c:1382:22:    got struct pcpu_sw_netstats *stats64
   net/dsa/slave.c:550:47: sparse: call with no type!
   net/dsa/slave.c:558:49: sparse: call with no type!
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
   net/dsa/slave.c:1169:19: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
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
> 1170		.mac_link_up = dsa_slave_phylink_mac_link_up,
  1171	};
  1172	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
