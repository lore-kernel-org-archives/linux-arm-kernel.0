From: chuhu@redhat.com (Chunyu Hu)
Date: Thu, 9 Aug 2018 08:47:38 -0400 (EDT)
Subject: Bug report: Bad mode in FIQ handler detected on CPU0, code 0x56000000
In-Reply-To: <1426298268.23978174.1533818483053.JavaMail.zimbra@redhat.com>
Message-ID: <381494229.23979617.1533818858635.JavaMail.zimbra@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I hit an 100% panic when I executed:

perf &
perf top

Logs are as below,

[  123.234492] Bad mode in FIQ handler detected on CPU0, code 0x56000000 -- SVC (AArch64)
[  123.242379] Internal error: Oops - bad mode: 0 [#1] SMP
[  123.247578] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache sunrpc vfat fat xgene_hwmon sg gpio_xgene_sb gpio_dwapb xgene_edac mailbox_xgene_slimpro gpio_generic xgene_rng uio_pdrv_genirq uio xfs libcrc32c xgene_enet at803x i2c_xgene_slimpro realtek ahci_xgene libahci_platform mdio_xgene dm_mirror dm_region_hash dm_log dm_mod
[  123.279949] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc8+ #1
[  123.286270] Hardware name: AmpereComputing(R) Mustang/Mustang, BIOS 0ACDY027 06/22/2018
[  123.294235] pstate: 00000085 (nzcv daIf -PAN -UAO)
[  123.299005] pc : __perf_event_enable+0x188/0x1e0
[  123.303599] lr : __perf_event_enable+0x188/0x1e0
[  123.308191] sp : ffff00000800fe80
[  123.311486] x29: ffff00000800fe80 x28: ffff0000092c5640 
[  123.316772] x27: 0000000000000000 x26: 0000000000000000 
[  123.322058] x25: 0000000000000001 x24: 0000000000000000 
[  123.327343] x23: ffff8003c926b000 x22: ffff8003c926b000 
[  123.332629] x21: ffff8003ffdf51a0 x20: ffff8003ffdf51a0 
[  123.337914] x19: ffff8003c926b000 x18: ffff0000092f7104 
[  123.343199] x17: 000000007fff2728 x16: 0000000000000000 
[  123.348485] x15: ffff0000092f7100 x14: 0000000000000000 
[  123.353771] x13: ffff8003a081d1e0 x12: ffff8003a081d208 
[  123.359056] x11: ffff8003a081d2f9 x10: 0000000000000c50 
[  123.364341] x9 : ffff00000928fe30 x8 : 0000000000000001 
[  123.369626] x7 : ffff8003c926b000 x6 : 00000000869b5fc0 
[  123.374912] x5 : 00ffffffffffffff x4 : ffff8003c2ef5500 
[  123.380197] x3 : 0000000000000000 x2 : 0000000000000041 
[  123.385482] x1 : 0000000000000080 x0 : 0000000000000070 
[  123.390769] Process swapper/0 (pid: 0, stack limit = 0x00000000307099b4)
[  123.397436] Call trace:
[  123.399869]  __perf_event_enable+0x188/0x1e0
[  123.404117]  event_function+0x84/0xd0
[  123.407760]  remote_function+0x58/0x68
[  123.411491]  flush_smp_call_function_queue+0x60/0x150
[  123.416516]  generic_smp_call_function_single_interrupt+0x18/0x20
[  123.422581]  handle_IPI+0x110/0x390
[  123.426050]  gic_handle_irq+0xa4/0xa8
[  123.429693]  el1_irq+0xb0/0x140
[  123.432818]  arch_cpu_idle+0x34/0x140
[  123.436462]  do_idle+0x210/0x278
[  123.439673]  cpu_startup_entry+0x2c/0x30
[  123.443576]  rest_init+0xb8/0xc4
[  123.446788]  start_kernel+0x448/0x470
[  123.450432] Code: f100007f 321d0043 1a820062 97ffff77 (17ffffbf) 
[  123.456501] ---[ end trace 7c22327cfccb25ee ]---
[  123.461094] Kernel panic - not syncing: Fatal exception in interrupt
[  123.467417] SMP: stopping secondary CPUs
[  123.471321] Kernel Offset: disabled
[  123.474791] CPU features: 0x20802000
[  123.478347] Memory Limit: none
[  123.481386] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
[  123.488918] Bad mode in FIQ handler detected on CPU0, code 0x56000000 -- SVC (AArch64)

Is this a known issue?

-- 
Regards,
Chunyu Hu
