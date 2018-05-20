From: lkp@intel.com (kbuild test robot)
Date: Sun, 20 May 2018 20:02:39 +0800
Subject: [arm:zii 12/20] net/dsa/slave.c:1169:2: warning: initialization from
 incompatible pointer type
Message-ID: <201805202038.c6beDYdX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git zii
head:   58e9ee3ee4dd4574170181ed8751766e234a33a8
commit: 94d9d1358684609c19eceb53aae76f40435b69dc [12/20] net: dsa: Plug in PHYLINK support
config: i386-randconfig-b0-05201752 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 94d9d1358684609c19eceb53aae76f40435b69dc
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   net/dsa/slave.c: In function 'dsa_slave_get_module_info':
   net/dsa/slave.c:550:2: error: implicit declaration of function 'phylink_ethtool_get_module_info' [-Werror=implicit-function-declaration]
     return phylink_ethtool_get_module_info(dp->pl, modinfo);
     ^
   net/dsa/slave.c: In function 'dsa_slave_get_module_eeprom':
   net/dsa/slave.c:558:2: error: implicit declaration of function 'phylink_ethtool_get_module_eeprom' [-Werror=implicit-function-declaration]
     return phylink_ethtool_get_module_eeprom(dp->pl, ee, buf);
     ^
   net/dsa/slave.c: At top level:
>> net/dsa/slave.c:1169:2: warning: initialization from incompatible pointer type
     .mac_link_down = dsa_slave_phylink_mac_link_down,
     ^
   net/dsa/slave.c:1169:2: warning: (near initialization for 'dsa_slave_phylink_mac_ops.mac_link_down')
   net/dsa/slave.c:1170:2: warning: initialization from incompatible pointer type
     .mac_link_up = dsa_slave_phylink_mac_link_up,
     ^
   net/dsa/slave.c:1170:2: warning: (near initialization for 'dsa_slave_phylink_mac_ops.mac_link_up')
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
   Cyclomatic Complexity 2 arch/x86/include/asm/jump_label.h:arch_static_branch
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/list.h:__list_add_valid
   Cyclomatic Complexity 1 include/linux/list.h:__list_del_entry_valid
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add_tail
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_disable
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_enable
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 2 include/linux/notifier.h:notifier_from_errno
   Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_order_trace
   Cyclomatic Complexity 67 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 3 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/skbuff.h:skb_is_nonlinear
   Cyclomatic Complexity 1 include/linux/skbuff.h:skb_tail_pointer
   Cyclomatic Complexity 2 include/linux/skbuff.h:skb_tailroom
   Cyclomatic Complexity 1 include/linux/u64_stats_sync.h:u64_stats_init
   Cyclomatic Complexity 1 include/linux/u64_stats_sync.h:u64_stats_update_begin
   Cyclomatic Complexity 1 include/linux/u64_stats_sync.h:u64_stats_update_end
   Cyclomatic Complexity 1 include/linux/u64_stats_sync.h:__u64_stats_fetch_begin
   Cyclomatic Complexity 1 include/linux/u64_stats_sync.h:__u64_stats_fetch_retry
   Cyclomatic Complexity 2 include/linux/netdevice.h:netdev_for_each_tx_queue
   Cyclomatic Complexity 1 include/linux/netdevice.h:netdev_priv
   Cyclomatic Complexity 1 include/linux/netdevice.h:netdev_notifier_info_to_dev
   Cyclomatic Complexity 1 include/linux/netdevice.h:dev_put
   Cyclomatic Complexity 1 include/linux/netdevice.h:dev_hold
   Cyclomatic Complexity 1 include/linux/netdevice.h:netif_is_bridge_master
   Cyclomatic Complexity 1 include/linux/etherdevice.h:is_zero_ether_addr
   Cyclomatic Complexity 1 include/linux/etherdevice.h:is_multicast_ether_addr
   Cyclomatic Complexity 3 include/linux/etherdevice.h:is_valid_ether_addr
   Cyclomatic Complexity 1 include/linux/etherdevice.h:ether_addr_copy
   Cyclomatic Complexity 1 include/linux/etherdevice.h:eth_hw_addr_inherit
   Cyclomatic Complexity 1 include/linux/etherdevice.h:ether_addr_equal
   Cyclomatic Complexity 1 include/net/netlink.h:nlmsg_msg_size
   Cyclomatic Complexity 1 include/net/netlink.h:nlmsg_total_size
   Cyclomatic Complexity 1 include/net/netlink.h:nlmsg_data
   Cyclomatic Complexity 1 include/net/netlink.h:nlmsg_end
   Cyclomatic Complexity 2 include/net/pkt_cls.h:tcf_exts_to_list
   Cyclomatic Complexity 1 include/net/pkt_cls.h:tcf_exts_has_one_action
   Cyclomatic Complexity 1 include/net/pkt_cls.h:tc_can_offload
   Cyclomatic Complexity 3 include/net/tc_act/tc_mirred.h:is_tcf_mirred_egress_mirror
   Cyclomatic Complexity 1 include/linux/netpoll.h:netpoll_tx_running
   Cyclomatic Complexity 1 include/net/switchdev.h:switchdev_notifier_info_to_dev
   Cyclomatic Complexity 1 include/net/dsa.h:dsa_to_port
   Cyclomatic Complexity 1 net/dsa/dsa_priv.h:dsa_slave_to_port
   Cyclomatic Complexity 1 net/dsa/dsa_priv.h:dsa_slave_to_master
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_phy_read
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_phy_write
   Cyclomatic Complexity 1 net/dsa/slave.c:dsa_slave_get_iflink
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_get_regs_len
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_get_regs
   Cyclomatic Complexity 4 net/dsa/slave.c:dsa_slave_get_eeprom_len
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_get_eeprom
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_set_eeprom
   Cyclomatic Complexity 3 net/dsa/slave.c:dsa_slave_get_sset_count
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_get_rxnfc
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_set_rxnfc
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_get_ts_info
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_phylink_validate
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_phylink_mac_link_state
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_phylink_mac_config
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_phylink_mac_an_restart
   Cyclomatic Complexity 4 net/dsa/slave.c:dsa_slave_phylink_mac_link_down
   Cyclomatic Complexity 4 net/dsa/slave.c:dsa_slave_phylink_mac_link_up
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_phylink_fixed_state
   Cyclomatic Complexity 1 net/dsa/slave.c:dsa_slave_dev_check
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_get_phys_port_name
   Cyclomatic Complexity 1 net/dsa/slave.c:dsa_legacy_fdb_add
   Cyclomatic Complexity 1 net/dsa/slave.c:dsa_legacy_fdb_del
   Cyclomatic Complexity 1 net/dsa/slave.c:dsa_slave_set_lockdep_class_one
   Cyclomatic Complexity 4 net/dsa/slave.c:dsa_slave_port_attr_set
   Cyclomatic Complexity 3 net/dsa/slave.c:dsa_slave_port_attr_get
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_switchdev_fdb_work_init
   Cyclomatic Complexity 7 net/dsa/slave.c:dsa_slave_port_obj_add
   Cyclomatic Complexity 7 net/dsa/slave.c:dsa_slave_port_obj_del
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 5 net/dsa/slave.c:dsa_skb_tx_timestamp
   Cyclomatic Complexity 0 net/dsa/slave.c:dsa_slave_netpoll_send_skb
   Cyclomatic Complexity 2 net/dsa/slave.c:dsa_slave_xmit
   Cyclomatic Complexity 1 net/dsa/slave.c:dsa_slave_fdb_dump
   Cyclomatic Complexity 1 include/net/netlink.h:nla_put_u16
   Cyclomatic Complexity 2 include/net/netlink.h:nlmsg_put
   Cyclomatic Complexity 3 include/net/netlink.h:nlmsg_trim
   Cyclomatic Complexity 1 include/net/netlink.h:nlmsg_cancel
   Cyclomatic Complexity 7 net/dsa/slave.c:dsa_slave_port_fdb_do_dump

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
Size: 33813 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180520/5198a65a/attachment-0001.gz>
