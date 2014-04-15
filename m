From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Apr 2014 18:07:07 -0300
Subject: [RFC] ARM: dts: imx27-pdk: Add PMIC support
Message-ID: <1397596027-14301-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Hi,

I am sending it as RFC because I am getting the warning below.

Booting the non-dt kernel does not cause this warning.

Appreciate any comments/suggestions.

Thanks

1000a000.serial: ttymxc0 at MMIO 0x1000a000 (irq = 36, base_baud = 831250) is aX
console [ttymxc0] enabled                                                       
mc13xxx spi0.0: mc13783: rev: 3.7, fin: 3, fab: 3, icid: 7/63                   
Unable to handle kernel NULL pointer dereference at virtual address 00000000    
pgd = c0004000                                                                  
[00000000] *pgd=00000000                                                        
Internal error: Oops: 805 [#1] PREEMPT ARM                                      
Modules linked in:                                                              
CPU: 0 PID: 394 Comm: irq/158-mc13xxx Not tainted 3.15.0-rc1-26320-g1e9dfe2-dir4
task: c789b120 ti: c7a62000 task.ti: c7a62000                                   
PC is at __mutex_lock_slowpath+0x64/0x138                                       
LR is at __mutex_lock_slowpath+0x2c/0x138                                       
pc : [<c04bf2e8>]    lr : [<c04bf2b0>]    psr: a0000013                         
sp : c7a63ef8  ip : 00000000  fp : 00000000                                     
r10: c7a1ee20  r9 : 00000000  r8 : ffffffff                                     
r7 : c7922780  r6 : c789b120  r5 : c7a62000  r4 : c7a1ee1c                      
r3 : 00000000  r2 : c7a63efc  r1 : ffffffff  r0 : 00000001                      
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel             
Control: 0005317f  Table: a0004000  DAC: 00000017                               
Process irq/158-mc13xxx (pid: 394, stack limit = 0xc7a621c0)                    
Stack: (0xc7a63ef8 to 0xc7a64000)                                               
3ee0:                                                       c7a63f14 c7a1ee20   
3f00: 00000000 c7829aa0 20000093 c7a1ee10 c7a62000 c7922780 c7922780 c0051398   
3f20: c06c6100 c02cf9a0 c789b120 c793dc40 c7a62000 c00513b4 c793dc40 c7a62000   
3f40: 00000001 c0051148 00000000 c00512d8 00000000 c7a23e20 00000000 c793dc40   
3f60: c0051064 00000000 00000000 c003627c 00000000 00000000 00000000 c793dc40   
3f80: 00000000 c7a63f84 c7a63f84 00000000 c7a63f90 c7a63f90 c7a63fac c7a23e20   
3fa0: c00361c8 00000000 00000000 c00095b0 00000000 00000000 00000000 00000000   
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000   
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 007f00ff 04df08ff   
[<c04bf2e8>] (__mutex_lock_slowpath) from [<c02cf9a0>] (mc13xxx_irq_thread+0x10)
[<c02cf9a0>] (mc13xxx_irq_thread) from [<c00513b4>] (irq_thread_fn+0x1c/0x34)   
[<c00513b4>] (irq_thread_fn) from [<c0051148>] (irq_thread+0xe4/0x124)          
[<c0051148>] (irq_thread) from [<c003627c>] (kthread+0xb4/0xd0)                 
[<c003627c>] (kthread) from [<c00095b0>] (ret_from_fork+0x14/0x24)              
Code: e58d3008 e58da004 e5842008 e3e08000 (e5832000)                            
---[ end trace 800418a9e658bcb2 ]---                                            
note: irq/158-mc13xxx[394] exited with preempt_count 2                          
Unable to handle kernel paging request at virtual address fffffff0              
pgd = c0004000                                                                  
[fffffff0] *pgd=a7ffd831, *pte=00000000, *ppte=00000000                         
Internal error: Oops: 17 [#2] PREEMPT ARM                                       
Modules linked in:                                                              
CPU: 0 PID: 394 Comm: irq/158-mc13xxx Tainted: G      D       3.15.0-rc1-26320-4
task: c789b120 ti: c7a62000 task.ti: c7a62000                                   
PC is at kthread_data+0x4/0xc                                                   
LR is at irq_thread_dtor+0x28/0xc0                                              
pc : [<c00367ac>]    lr : [<c0051300>]    psr: 20000013                         
sp : c7a63ca0  ip : c7a63f84  fp : c7a62000                                     
r10: c7a63d4a  r9 : c04bf2ea  r8 : c7a62000                                     
r7 : 00000000  r6 : c07092fc  r5 : c789b120  r4 : 00000000                      
r3 : 00000000  r2 : c7a63ca0  r1 : a0000013  r0 : c789b120                      
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user               
Control: 0005317f  Table: a0004000  DAC: 00000015                               
Process irq/158-mc13xxx (pid: 394, stack limit = 0xc7a621c0)                    
Stack: (0xc7a63ca0 to 0xc7a64000)                                               
3ca0: c7a63f48 00000000 c789b120 c00335bc 0000000b c7a62000 c789b120 c001a8fc   
3cc0: c04bf2ea 00000001 c7a62000 c04ba5fc c05bb664 c06d09d0 c06c92e0 c07073a4   
3ce0: c7a62000 c06c92e0 60000013 0000000b c04bf2ea c7a63d4a c7a62000 c000bedc   
3d00: c7a621c0 0000000b 00000000 00000000 00000008 00000000 65000000 33643835   
3d20: 20383030 64383565 34303061 38356520 30303234 33652038 30383065 28203030   
3d40: 33383565 30303032 00002029 c04ba5fc c05f58b8 00000000 00000805 00000000   
3d60: c7a63eb0 00000000 00000000 c789b120 00000000 c04b9f0c 00000000 c04c2138   
3d80: c754c714 c00e590c c06d0dc8 c06d0dc8 c754c758 60000053 c06d10c0 c0058904   
3da0: c7a63ea8 c00e27ac c754c6e8 c754c6e8 c7a63ebb c7a63ec8 c7a62000 c00e4358   
3dc0: 00000002 0000000a 00000003 ffffffff 00000000 00000000 00000000 00000000   
3de0: c7a63e08 3530fffe c7a63e33 00000805 00000005 c06c9e8c 00000000 c7a63eb0   
3e00: 00000000 c7a1ee20 00000000 c00085e0 00000001 c788b8e0 c06d0dc8 c06d0dc8   
3e20: c787c520 60000053 c06d10c0 c7a63ebb c0610f88 00018ed9 00000000 22fe30c3   
3e40: 00000000 c78a3b70 00000020 c0251434 00000002 00000001 c78a3b70 c06cf998   
3e60: 00000000 ffffffff c7a64000 00000002 00000000 c04c23a8 00000000 00000001   
3e80: 000033fd 00000000 c06cf998 c0044664 c04c95b8 c06cf998 c04bf2e8 a0000013   
3ea0: ffffffff c7a63ee4 ffffffff c04c07b4 00000001 ffffffff c7a63efc 00000000   
3ec0: c7a1ee1c c7a62000 c789b120 c7922780 ffffffff 00000000 c7a1ee20 00000000   
3ee0: 00000000 c7a63ef8 c04bf2b0 c04bf2e8 a0000013 ffffffff c7a63f14 c7a1ee20   
3f00: 00000000 c7829aa0 20000093 c7a1ee10 c7a62000 c7922780 c7922780 c0051398   
3f20: c06c6100 c02cf9a0 c789b120 c793dc40 c7a62000 c00513b4 c793dc40 c7a62000   
3f40: 00000001 c0051148 00000000 c00512d8 00000000 c7a23e20 00000000 c793dc40   
3f60: c0051064 00000000 00000000 c003627c 00000000 00000000 00000000 c793dc40   
3f80: 00000000 c7a63f84 c7a63f84 00000001 c7a63f90 c7a63f90 c7a63fac c7a23e20   
3fa0: c00361c8 00000000 00000000 c00095b0 00000000 00000000 00000000 00000000   
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000   
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 007f00ff 04df08ff   
[<c00367ac>] (kthread_data) from [<c0051300>] (irq_thread_dtor+0x28/0xc0)       
[<c0051300>] (irq_thread_dtor) from [<c00335bc>] (task_work_run+0xa0/0xb4)      
[<c00335bc>] (task_work_run) from [<c001a8fc>] (do_exit+0x260/0x93c)            
[<c001a8fc>] (do_exit) from [<c000bedc>] (die+0x158/0x34c)                      
[<c000bedc>] (die) from [<c04b9f0c>] (__do_kernel_fault.part.9+0x54/0x74)       
[<c04b9f0c>] (__do_kernel_fault.part.9) from [<c04c2138>] (do_page_fault+0x348/)
[<c04c2138>] (do_page_fault) from [<c00085e0>] (do_DataAbort+0x34/0x98)         
[<c00085e0>] (do_DataAbort) from [<c04c07b4>] (__dabt_svc+0x34/0x40)            
Exception stack(0xc7a63eb0 to 0xc7a63ef8)                                       
3ea0:                                     00000001 ffffffff c7a63efc 00000000   
3ec0: c7a1ee1c c7a62000 c789b120 c7922780 ffffffff 00000000 c7a1ee20 00000000   
3ee0: 00000000 c7a63ef8 c04bf2b0 c04bf2e8 a0000013 ffffffff                     
[<c04c07b4>] (__dabt_svc) from [<c04bf2e8>] (__mutex_lock_slowpath+0x64/0x138)  
[<c04bf2e8>] (__mutex_lock_slowpath) from [<c02cf9a0>] (mc13xxx_irq_thread+0x10)
[<c02cf9a0>] (mc13xxx_irq_thread) from [<c00513b4>] (irq_thread_fn+0x1c/0x34)   
[<c00513b4>] (irq_thread_fn) from [<c0051148>] (irq_thread+0xe4/0x124)          
[<c0051148>] (irq_thread) from [<c003627c>] (kthread+0xb4/0xd0)                 
[<c003627c>] (kthread) from [<c00095b0>] (ret_from_fork+0x14/0x24)              
Code: e1a00120 e2000001 e12fff1e e59031d8 (e5130010)                            
---[ end trace 800418a9e658bcb3 ]---                                            
Fixing recursive fault but reboot is needed!                                    
note: irq/158-mc13xxx[394] exited with preempt_count 2                          
Unable to handle kernel NULL pointer dereference at virtual address 00000008    
pgd = c0004000                                                                  
[00000008] *pgd=00000000                                                        
Internal error: Oops: 5 [#3] PREEMPT ARM                                        
Modules linked in:                                                              
CPU: 0 PID: 394 Comm: irq/158-mc13xxx Tainted: G      D       3.15.0-rc1-26320-4
task: c789b120 ti: c7a62000 task.ti: c7a62000                                   
PC is at exit_shm+0x8/0x54                                                      
LR is at do_exit+0x238/0x93c                                                    
pc : [<c0223074>]    lr : [<c001a8d4>]    psr: 60000013                         
sp : c7a63a58  ip : 00000032  fp : c7a62000                                     
r10: c7a63af2  r9 : c00367ae  r8 : c7a62000                                     
r7 : 00000000  r6 : c789b120  r5 : c7a62000  r4 : 0000000b                      
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c789b120                      
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user               
Control: 0005317f  Table: a0004000  DAC: 00000015                               
Process irq/158-mc13xxx (pid: 394, stack limit = 0xc7a621c0)                    
Stack: (0xc7a63a58 to 0xc7a64000)                                               
3a40:                                                       c07050b0 0000000b   
3a60: c7a62000 c001a8d4 c00367ae 00000000 c7a62000 c04ba5fc c05bb664 c06d09d0   
3a80: 0000000b c07073a4 c7a62000 c06c92e0 60000013 0000000b c00367ae c7a63af2   
3aa0: c7a62000 c000bedc c7a621c0 0000000b 00000000 00000000 00000008 bf000000   
3ac0: 65000000 30306131 20303231 30303265 31303030 32316520 31666666 35652065   
3ae0: 31333039 28203864 33313565 30313030 c7002029 c04ba5fc c05f58b8 fffffff0   
3b00: 00000017 00000000 c7a63c58 00000000 c04bf2ea c789b120 c7a62000 c04b9f0c   
3b20: fffffff0 c04c2138 c06ce5b0 c0707f60 c0707f60 00000002 c06ce5b8 c0024614   
3b40: c06ca440 c7a63b50 c0708774 c0708974 c7a63b50 c7a63b50 00000000 00000001   
3b60: 00000002 00000002 c0707e24 00000001 00000102 00000001 60000013 c001cfe0   
3b80: 00000037 c7805500 c780c6a0 00000004 00000000 00000017 00000007 c06c9eac   
3ba0: fffffff0 c7a63c58 c04bf2ea c7a63d4a c7a62000 c00085e0 0000002a c06de398   
3bc0: 0000002a 00000000 c7a63bf8 c0009df4 f4440000 c070794c c7a63bf8 0000ffff   
3be0: c7a63c2c c0008710 c004e804 20000013 ffffffff c04c07f4 00000002 c7a62000   
3c00: 00000002 00000002 00000036 c06d09c8 00000000 00000001 c7a62000 00000000   
3c20: 00000000 60000013 00000032 c7a63c40 c004dfc0 c004e804 20000013 ffffffff   
3c40: c00367ac 20000013 ffffffff c7a63c8c c7a62000 c04c07b4 c789b120 a0000013   
3c60: c7a63ca0 00000000 00000000 c789b120 c07092fc 00000000 c7a62000 c04bf2ea   
3c80: c7a63d4a c7a62000 c7a63f84 c7a63ca0 c0051300 c00367ac 20000013 ffffffff   
3ca0: c7a63f48 00000000 c789b120 c00335bc 0000000b c7a62000 c789b120 c001a8fc   
3cc0: c04bf2ea 00000001 c7a62000 c04ba5fc c05bb664 c06d09d0 c06c92e0 c07073a4   
3ce0: c7a62000 c06c92e0 60000013 0000000b c04bf2ea c7a63d4a c7a62000 c000bedc   
3d00: c7a621c0 0000000b 00000000 00000000 00000008 00000000 65000000 33643835   
3d20: 20383030 64383565 34303061 38356520 30303234 33652038 30383065 28203030   
3d40: 33383565 30303032 00002029 c04ba5fc c05f58b8 00000000 00000805 00000000   
3d60: c7a63eb0 00000000 00000000 c789b120 00000000 c04b9f0c 00000000 c04c2138   
3d80: c754c714 c00e590c c06d0dc8 c06d0dc8 c754c758 60000053 c06d10c0 c0058904   
3da0: c7a63ea8 c00e27ac c754c6e8 c754c6e8 c7a63ebb c7a63ec8 c7a62000 c00e4358   
3dc0: 00000002 0000000a 00000003 ffffffff 00000000 00000000 00000000 00000000   
3de0: c7a63e08 3530fffe c7a63e33 00000805 00000005 c06c9e8c 00000000 c7a63eb0   
3e00: 00000000 c7a1ee20 00000000 c00085e0 00000001 c788b8e0 c06d0dc8 c06d0dc8   
3e20: c787c520 60000053 c06d10c0 c7a63ebb c0610f88 00018ed9 00000000 22fe30c3   
3e40: 00000000 c78a3b70 00000020 c0251434 00000002 00000001 c78a3b70 c06cf998   
3e60: 00000000 ffffffff c7a64000 00000002 00000000 c04c23a8 00000000 00000001   
3e80: 000033fd 00000000 c06cf998 c0044664 c04c95b8 c06cf998 c04bf2e8 a0000013   
3ea0: ffffffff c7a63ee4 ffffffff c04c07b4 00000001 ffffffff c7a63efc 00000000   
3ec0: c7a1ee1c c7a62000 c789b120 c7922780 ffffffff 00000000 c7a1ee20 00000000   
3ee0: 00000000 c7a63ef8 c04bf2b0 c04bf2e8 a0000013 ffffffff c7a63f14 c7a1ee20   
3f00: 00000000 c7829aa0 20000093 c7a1ee10 c7a62000 c7922780 c7922780 c0051398   
3f20: c06c6100 c02cf9a0 c789b120 c793dc40 c7a62000 c00513b4 c793dc40 c7a62000   
3f40: 00000001 c0051148 00000000 c00512d8 00000000 c7a23e20 00000000 c793dc40   
3f60: c0051064 00000000 00000000 c003627c 00000000 00000000 00000000 c793dc40   
3f80: 00000000 c7a63f84 c7a63f84 00000001 c7a63f90 c7a63f90 c7a63fac c7a23e20   
3fa0: c00361c8 00000000 00000000 c00095b0 00000000 00000000 00000000 00000000   
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000   
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 007f00ff 04df08ff   
[<c0223074>] (exit_shm) from [<c001a8d4>] (do_exit+0x238/0x93c)                 
[<c001a8d4>] (do_exit) from [<c000bedc>] (die+0x158/0x34c)                      
[<c000bedc>] (die) from [<c04b9f0c>] (__do_kernel_fault.part.9+0x54/0x74)       
[<c04b9f0c>] (__do_kernel_fault.part.9) from [<c04c2138>] (do_page_fault+0x348/)
[<c04c2138>] (do_page_fault) from [<c00085e0>] (do_DataAbort+0x34/0x98)         
[<c00085e0>] (do_DataAbort) from [<c04c07b4>] (__dabt_svc+0x34/0x40)            
Exception stack(0xc7a63c58 to 0xc7a63ca0)                                       
3c40:                                                       c789b120 a0000013   
3c60: c7a63ca0 00000000 00000000 c789b120 c07092fc 00000000 c7a62000 c04bf2ea   
3c80: c7a63d4a c7a62000 c7a63f84 c7a63ca0 c0051300 c00367ac 20000013 ffffffff   
[<c04c07b4>] (__dabt_svc) from [<c00367ac>] (kthread_data+0x4/0xc)              
[<c00367ac>] (kthread_data) from [<c0051300>] (irq_thread_dtor+0x28/0xc0)       
[<c0051300>] (irq_thread_dtor) from [<c00335bc>] (task_work_run+0xa0/0xb4)      
[<c00335bc>] (task_work_run) from [<c001a8fc>] (do_exit+0x260/0x93c)            
[<c001a8fc>] (do_exit) from [<c000bedc>] (die+0x158/0x34c)                      
[<c000bedc>] (die) from [<c04b9f0c>] (__do_kernel_fault.part.9+0x54/0x74)       
[<c04b9f0c>] (__do_kernel_fault.part.9) from [<c04c2138>] (do_page_fault+0x348/)
[<c04c2138>] (do_page_fault) from [<c00085e0>] (do_DataAbort+0x34/0x98)         
[<c00085e0>] (do_DataAbort) from [<c04c07b4>] (__dabt_svc+0x34/0x40)            
Exception stack(0xc7a63eb0 to 0xc7a63ef8)                                       
3ea0:                                     00000001 ffffffff c7a63efc 00000000   
3ec0: c7a1ee1c c7a62000 c789b120 c7922780 ffffffff 00000000 c7a1ee20 00000000   
3ee0: 00000000 c7a63ef8 c04bf2b0 c04bf2e8 a0000013 ffffffff                     
[<c04c07b4>] (__dabt_svc) from [<c04bf2e8>] (__mutex_lock_slowpath+0x64/0x138)  
[<c04bf2e8>] (__mutex_lock_slowpath) from [<c02cf9a0>] (mc13xxx_irq_thread+0x10)
[<c02cf9a0>] (mc13xxx_irq_thread) from [<c00513b4>] (irq_thread_fn+0x1c/0x34)   
[<c00513b4>] (irq_thread_fn) from [<c0051148>] (irq_thread+0xe4/0x124)          
[<c0051148>] (irq_thread) from [<c003627c>] (kthread+0xb4/0xd0)                 
[<c003627c>] (kthread) from [<c00095b0>] (ret_from_fork+0x14/0x24)              
Code: eaf89776 c0222f98 e92d4038 e5903280 (e5934008)                            
---[ end trace 800418a9e658bcb4 ]---                                            
Fixing recursive fault but reboot is needed!                                    
[sched_delayed] sched: RT throttling activated                                  
SW1A: 1200 <--> 1500 mV at 2200 mV                                              
SW2A: 1800 mV                                                                   
SW3: 5000 mV                                                                    
VGEN: 1500 mV                                                                   
VMMC1: 1600 <--> 3000 mV at 3000 mV                                             
GPO1: 3100 mV                                                                   
PWGT1SPI: 5500 mV                                                               
spi_imx 1000e000.cspi: probed                                                   

 arch/arm/boot/dts/imx27-pdk.dts | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 430b72b..f456fd5 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -21,6 +21,70 @@
 	};
 };
 
+&cspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cspi1>;
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	pmic: mc13783 at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mc13783";
+		reg = <0>;
+		spi-cs-high;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,mc13xxx-uses-adc;
+		fsl,mc13xxx-uses-rtc;
+
+		regulators {
+			/* SW1A and SW1B joined operation */
+			sw1_reg: sw1a {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1520000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* SW2A and SW2B joined operation */
+			sw2_reg: sw2a {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+
+			vgen_reg: vgen {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vmmc1_reg: vmmc1 {
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			gpo1_reg: gpo1 { };
+
+			pwgt1spi_reg: pwgt1spi {
+				regulator-always-on;
+			};
+		};
+	};
+};
 
 &fec {
 	phy-mode = "mii";
@@ -38,6 +102,17 @@
 
 &iomuxc {
 	imx27-pdk {
+		pinctrl_cspi1: cspi1grp {
+			fsl,pins = <
+				MX27_PAD_CSPI1_MISO__CSPI1_MISO 0x0
+				MX27_PAD_CSPI1_MOSI__CSPI1_MOSI 0x0
+				MX27_PAD_CSPI1_SCLK__CSPI1_SCLK 0x0
+				MX27_PAD_CSPI1_RDY__CSPI1_RDY	0x0
+				MX27_PAD_CSPI1_SS0__GPIO4_28	0x0 /* SPI1 CS0 */
+				MX27_PAD_TOUT__GPIO3_14		0x0 /* PMIC IRQ */
+			>;
+		};
+
 		pinctrl_fec: fecgrp {
 			fsl,pins = <
 				MX27_PAD_SD3_CMD__FEC_TXD0 0x0
-- 
1.8.3.2
