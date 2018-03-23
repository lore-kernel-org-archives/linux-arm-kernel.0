From: domenico.andreoli@linux.com (Domenico Andreoli)
Date: Fri, 23 Mar 2018 17:07:21 +0100
Subject: ARM64: Allwinner H5 crashes after few hours (NanoPI NEO2)
Message-ID: <20180323160720.4gnhfwu4gdtvblrb@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  I'm running Debian Buster (kernel 4.15.4-1) on a NanoPI NEO2, Allwinner
H5.  It's a new installation and I'm now hitting some stability issue,
I've not any prior stable kernel to compare with.

The one below is the first capture of the fault in action. Is anybody having similar issues?

Kind regards,
Domenico
 
[62490.281028] Unable to handle kernel paging request at virtual address fffe800046c85dd4
[62490.281032] Unable to handle kernel NULL pointer dereference at virtual address 00000321
[62490.281042] Mem abort info:
[62490.281045]   ESR = 0x96000004
[62490.281049]   Exception class = DABT (current EL), IL = 32 bits
[62490.281052]   SET = 0, FnV = 0
[62490.281055]   EA = 0, S1PTW = 0
[62490.281056] Data abort info:
[62490.281059]   ISV = 0, ISS = 0x00000004
[62490.281061]   CM = 0, WnR = 0
[62490.281069] user pgtable: 4k pages, 48-bit VAs, pgd = 00000000fde6a890
[62490.281072] [0000000000000321] *pgd=0000000000000000
[62490.281081] Internal error: Oops: 96000004 [#1] SMP
[62490.281087] Modules linked in: ip6table_mangle nf_log_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_connmark iptable_mangle xt_helper nf_log_ipv4 nf_log_common xt_LOG xt_limit nf_conntrack_ipv4 nf_defrag_ipv4 xt_tcpudp xt_multiport xt_conntrack nf_conntrack_sip nf_conntrack_ftp nf_conntrack_irc nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack libcrc32c ip6table_filter ip6_tables iptable_filter cpufreq_powersave cpufreq_ondemand cpufreq_userspace cpufreq_conservative nls_ascii nls_cp437 vfat fat aes_ce_blk crypto_simd cryptd aes_ce_cipher ghash_ce gf128mul sha2_ce efi_pstore sha256_arm64 leds_gpio sha1_ce efivars ledtrig_heartbeat efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb aes_arm64 realtek ohci_platform ohci_hcd ehci_platform ehci_hcd dwmac_sun8i mdio_mux
[62490.281220]  stmmac_platform stmmac ptp pps_core of_mdio fixed_phy libphy usbcore phy_sun4i_usb sunxi_mmc fixed
[62490.281250] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.15.0-1-arm64 #1 Debian 4.15.4-1
[62490.281253] Hardware name: sunxi sunxi/sunxi, BIOS 2018.01 03/10/2018
[62490.281259] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[62490.281276] pc : enqueue_task_rt+0xa4/0x308
[62490.281282] lr : enqueue_task_rt+0x60/0x308
[62490.281284] sp : ffff00000801bc70
[62490.281287] x29: ffff00000801bc70 x28: 0000000000000319 
[62490.281293] x27: 0000000000000319 x26: 0000000000000000 
[62490.281299] x25: ffff000009029c50 x24: ffff000008ccf200 
[62490.281305] x23: ffff80003eb91e00 x22: ffff80003eb92100 
[62490.281311] x21: 0000000000000309 x20: 0000000000000009 
[62490.281317] x19: ffff80003eb91e00 x18: 00017175913bbe2c 
[62490.281323] x17: 0000ffff9fe83130 x16: ffff00000817eb48 
[62490.281329] x15: 00000000d2feb795 x14: 0000000000000008 
[62490.281335] x13: a72686428ff910ec x12: ba76aeca90793bf7 
[62490.281341] x11: 0000000000000000 x10: 0000000000000040 
[62490.281347] x9 : ffff0000090503b8 x8 : ffff80003e402b58 
[62490.281353] x7 : ffff80003e402b80 x6 : 000001583068daff 
[62490.281358] x5 : 00ffffffffffffff x4 : 0000000000000015 
[62490.281364] x3 : ffff80003eb91e00 x2 : 0000000000000000 
[62490.281369] x1 : 0000000000000003 x0 : 0000000000000000 
[62490.281376] Process swapper/3 (pid: 0, stack limit = 0x00000000a9c5950d)
[62490.281380] Call trace:
[62490.281389]  enqueue_task_rt+0xa4/0x308
[62490.281398]  activate_task+0x84/0xd8
[62490.281405]  ttwu_do_activate+0x58/0x98
[62490.281411]  try_to_wake_up+0x1e8/0x470
[62490.281416]  wake_up_process+0x28/0x38
[62490.281424]  watchdog_timer_fn+0xa0/0x2e8
[62490.281430]  __hrtimer_run_queues+0xdc/0x2b8
[62490.281436]  hrtimer_interrupt+0xa8/0x228
[62490.281446]  arch_timer_handler_phys+0x38/0x58
[62490.281453]  handle_percpu_devid_irq+0x90/0x268
[62490.281458]  generic_handle_irq+0x34/0x50
[62490.281462]  __handle_domain_irq+0x68/0xc0
[62490.281469]  gic_handle_irq+0x60/0xb0
[62490.281473]  el1_irq+0xb0/0x140
[62490.281481]  arch_cpu_idle+0x30/0x188
[62490.281487]  do_idle+0x138/0x1f8
[62490.281492]  cpu_startup_entry+0x28/0x30
[62490.281499]  secondary_start_kernel+0x120/0x130
[62490.281507] Code: 910c429c 937c7c5a 8b1a039b 37201018 (f9400778) 
[62490.281521] ---[ end trace 35aa8b5dd2481c2a ]---
[62490.622441] Mem abort info:
[62490.625240]   ESR = 0x96000004
[62490.628297]   Exception class = DABT (current EL), IL = 32 bits
[62490.634214]   SET = 0, FnV = 0
[62490.637269]   EA = 0, S1PTW = 0
[62490.640408] Data abort info:
[62490.643288]   ISV = 0, ISS = 0x00000004
[62490.647122]   CM = 0, WnR = 0
[62490.650091] [fffe800046c85dd4] address between user and kernel address ranges

-- 
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
