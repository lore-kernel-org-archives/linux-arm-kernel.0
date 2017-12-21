From: Hermann.Lauer@iwr.uni-heidelberg.de (Hermann Lauer)
Date: Thu, 21 Dec 2017 09:41:53 +0100
Subject: [Allwinner R40] Banana M2 Ultra sysreq reboot and shutdown exceptions
Message-ID: <20171221084153.4j3jnfzdvhzzr3kl@lemon.iwr.uni-heidelberg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

after a night of kernel compiling on Bananapi_M2_Ultra (Allwinner R40) the device was not responding
anymore, so I tried the sysreq sequence on the serial console.
<break>b (to reboot) produced the appended kernel exception. 

Please tell if more information is needed (or if this is only cosmetic, as the device rebooted).

As a second case the log of a normal shutdown is attached, which ends also with an exception. 

Many thanks and merry Xmas,
 greetings
  Hermann

[34221.492249] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) terminate-all-tasks(e) memory-full-oom-kill(f) k 


[34232.752912] sysrq: SysRq : Resetting
[34232.756510] CPU2: stopping
[34232.759221] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W        4.15.0-rc3-next-20171212 #1
[34232.767993] Hardware name: Allwinner sun8i Family
[34232.772722] [<c0114e10>] (unwind_backtrace) from [<c010e970>] (show_stack+0x20/0x24)
[34232.780465] [<c010e970>] (show_stack) from [<c08fcca0>] (dump_stack+0x90/0xa4)
[34232.787687] [<c08fcca0>] (dump_stack) from [<c0112454>] (handle_IPI+0x29c/0x2bc)
[34232.795081] [<c0112454>] (handle_IPI) from [<c010253c>] (gic_handle_irq+0x90/0x94)
[34232.802645] [<c010253c>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
[34232.810118] Exception stack(0xee149f38 to 0xee149f80)
[34232.815164] 9f20:                                                       00000000 027a7444
[34232.823334] 9f40: eedd1420 c0121bc0 ee148000 c1005df8 c1005e5c 00000004 c10f084b c0b653b4
[34232.831503] 9f60: 00000000 ee149f94 ee149f98 ee149f88 c010a214 c010a218 600e0013 ffffffff
[34232.839676] [<c0101a0c>] (__irq_svc) from [<c010a218>] (arch_cpu_idle+0x48/0x4c)
[34232.847070] [<c010a218>] (arch_cpu_idle) from [<c0919a90>] (default_idle_call+0x30/0x3c)
[34232.855156] [<c0919a90>] (default_idle_call) from [<c019b4cc>] (do_idle+0xe4/0x158)
[34232.862808] [<c019b4cc>] (do_idle) from [<c019b800>] (cpu_startup_entry+0x28/0x2c)
[34232.870372] [<c019b800>] (cpu_startup_entry) from [<c0111f20>] (secondary_start_kernel+0x15c/0x184)
[34232.879412] [<c0111f20>] (secondary_start_kernel) from [<40102b8c>] (0x40102b8c)
[34232.886800] CPU0: stopping
[34232.889509] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        4.15.0-rc3-next-20171212 #1
[34232.898279] Hardware name: Allwinner sun8i Family
[34232.902987] [<c0114e10>] (unwind_backtrace) from [<c010e970>] (show_stack+0x20/0x24)
[34232.910725] [<c010e970>] (show_stack) from [<c08fcca0>] (dump_stack+0x90/0xa4)
[34232.917944] [<c08fcca0>] (dump_stack) from [<c0112454>] (handle_IPI+0x29c/0x2bc)
[34232.925334] [<c0112454>] (handle_IPI) from [<c010253c>] (gic_handle_irq+0x90/0x94)
[34232.932898] [<c010253c>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
[34232.940369] Exception stack(0xc1001ee0 to 0xc1001f28)
[34232.945419] 1ee0: 00000000 0279020c eedaf420 c0121bc0 c1000000 c1005df8 c1005e5c 00000001
[34232.953588] 1f00: c10f084b c0b653b4 c0e94a30 c1001f3c c1001f40 c1001f30 c010a214 c010a218
[34232.961753] 1f20: 60070013 ffffffff
[34232.965243] [<c0101a0c>] (__irq_svc) from [<c010a218>] (arch_cpu_idle+0x48/0x4c)
[34232.972634] [<c010a218>] (arch_cpu_idle) from [<c0919a90>] (default_idle_call+0x30/0x3c)
[34232.980718] [<c0919a90>] (default_idle_call) from [<c019b4cc>] (do_idle+0xe4/0x158)
[34232.988368] [<c019b4cc>] (do_idle) from [<c019b800>] (cpu_startup_entry+0x28/0x2c)
[34232.995932] [<c019b800>] (cpu_startup_entry) from [<c0912cc4>] (rest_init+0xc0/0xc4)
[34233.003671] [<c0912cc4>] (rest_init) from [<c0e00eb0>] (start_kernel+0x428/0x450)
[34233.011143] CPU3: stopping
[34233.013852] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W        4.15.0-rc3-next-20171212 #1
[34233.022623] Hardware name: Allwinner sun8i Family
[34233.027330] [<c0114e10>] (unwind_backtrace) from [<c010e970>] (show_stack+0x20/0x24)
[34233.035068] [<c010e970>] (show_stack) from [<c08fcca0>] (dump_stack+0x90/0xa4)
[34233.042286] [<c08fcca0>] (dump_stack) from [<c0112454>] (handle_IPI+0x29c/0x2bc)
[34233.049676] [<c0112454>] (handle_IPI) from [<c010253c>] (gic_handle_irq+0x90/0x94)
[34233.057239] [<c010253c>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
[34233.064709] Exception stack(0xee14bf38 to 0xee14bf80)
[34233.069754] bf20:                                                       00000000 0279f86c
[34233.077924] bf40: eede2420 c0121bc0 ee14a+-----------------------------+c10f084b c0b653b4
[34233.086093] bf60: 00000000 ee14bf94 ee14b|                             |60080013 ffffffff
[34233.094263] [<c0101a0c>] (__irq_svc) from|  Cannot open /dev/ttyUSB0!  |48/0x4c)
[34233.101655] [<c010a218>] (arch_cpu_idle) |                             |_call+0x30/0x3c)
[34233.109739] [<c0919a90>] (default_idle_ca+-----------------------------+0xe4/0x158)
[34233.117388] [<c019b4cc>] (do_idle) from [<c019b800>] (cpu_startup_entry+0x28/0x2c)
[34233.124952] [<c019b800>] (cpu_startup_entry) from [<c0111f20>] (secondary_start_kernel+0x15c/0x184)
[34233.133988] [<c0111f20>] (secondary_start_kernel) from [<40102b8c>] (0x40102b8c)

U-Boot SPL 2017.11-rc2 (Oct 20 2017 - 22:21:57)
DRAM: 2048 MiB
Trying to boot from MMC1


U-Boot 2017.11-rc2 (Oct 20 2017 - 22:21:57 +0200) Allwinner Technology

CPU:   Allwinner R40 (SUN8I 1701)
Model: Banana Pi BPI-M2-Ultra
I2C:   ready
DRAM:  2 GiB
MMC:   SUNXI SD/MMC: 0, SUNXI SD/MMC: 1
*** Warning - bad CRC, using default environment

In:    serial at 1c28000
Out:   serial at 1c28000
Err:   serial at 1c28000
SCSI:  Target spinup took 0 ms.
AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
flags: ncq stag pm led clo only pmp pio slum part ccc apst 
Net:   No ethernet found.
starting USB...
No controllers found
Hit any key to stop autoboot:  0 

--- normal shutdown ---
[ 3826.601352] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 3826.606737] sd 0:0:0:0: [sda] Stopping disk
[ 3827.208326] reboot: Power down
[ 3829.265309] i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
[ 3829.781624] systemd-shutdow: 3 output lines suppressed due to ratelimiting
[ 3829.788652] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
[ 3829.788652] 
[ 3829.797779] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 4.15.0-rc3-next-20171212 #1
[ 3829.805770] Hardware name: Allwinner sun8i Family
[ 3829.810499] [<c0114e10>] (unwind_backtrace) from [<c010e970>] (show_stack+0x20/0x24)
[ 3829.818243] [<c010e970>] (show_stack) from [<c08fcca0>] (dump_stack+0x90/0xa4)
[ 3829.825466] [<c08fcca0>] (dump_stack) from [<c014ea58>] (panic+0x100/0x28c)
[ 3829.832427] [<c014ea58>] (panic) from [<c0154634>] (complete_and_exit+0x0/0x2c)
[ 3829.839734] [<c0154634>] (complete_and_exit) from [<c0175974>] (SyS_reboot+0x1c8/0x238)
[ 3829.847733] [<c0175974>] (SyS_reboot) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
[ 3829.855379] Exception stack(0xee109fa8 to 0xee109ff0)
[ 3829.860427] 9fa0:                   00455660 4321fedc fee1dead 28121969 4321fedc 8b9c6d00
[ 3829.868597] 9fc0: 00455660 4321fedc 008b8028 00000058 008b80b0 008b8028 be919e94 fffff000
[ 3829.876763] 9fe0: 00000058 be919bc4 b6d08075 b6c8e6f6
[ 3829.881829] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
[ 3829.881829] 

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 205; 69120 Heidelberg; Tel: (06221)54-14405 Fax: -14427
Email: Hermann.Lauer at iwr.uni-heidelberg.de
