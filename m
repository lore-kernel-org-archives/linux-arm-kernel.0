From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Apr 2014 12:59:41 +0100
Subject: Versatile express lockdep warning on poweroff
Message-ID: <20140411115941.GM16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has been going on for a while now... found by the autobuilder.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 717 at kernel/locking/lockdep.c:2742 lockdep_trace_alloc+0xc0/0x100()
DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
Modules linked in:
CPU: 0 PID: 717 Comm: halt Not tainted 3.14.0+ #1
Backtrace:
[<c0011eb8>] (dump_backtrace) from [<c0012440>] (show_stack+0x18/0x1c)
 r6:c037350b r5:00000009 r4:00000000 r3:04400100
[<c0012428>] (show_stack) from [<c0364128>] (dump_stack+0x74/0x94)
[<c03640b4>] (dump_stack) from [<c001efa4>] (warn_slowpath_common+0x6c/0x8c)
 r4:ee33fdc0 r3:edf36b40
[<c001ef38>] (warn_slowpath_common) from [<c001f068>] (warn_slowpath_fmt+0x38/0x40)
 r8:c000ed04 r7:c0201738 r6:000080d0 r5:000080d0 r4:60000093
[<c001f034>] (warn_slowpath_fmt) from [<c005edf8>] (lockdep_trace_alloc+0xc0/0x100)
 r3:c0374738 r2:c0373554
[<c005ed38>] (lockdep_trace_alloc) from [<c00c20a4>] (kmem_cache_alloc+0x2c/0x114)
 r4:ee801f00 r3:c04d0d14
[<c00c2078>] (kmem_cache_alloc) from [<c0201738>] (__vexpress_config_func_get+0x6c/0x178)
 r10:00000000 r8:c000ed04 r7:c04d52e8 r6:00000000 r5:c04d52e8 r4:c03be2af
[<c02016cc>] (__vexpress_config_func_get) from [<c0266eb8>] (vexpress_reset_do+0x1c/0x74)
 r7:00000001 r6:4321fedc r5:c04d52e8 r4:c03be2af
[<c0266e9c>] (vexpress_reset_do) from [<c0266f54>] (vexpress_power_off+0x1c/0x28)
 r5:fee1dead r4:c04d9ff8
[<c0266f38>] (vexpress_power_off) from [<c000f8ac>] (machine_power_off+0x2c/0x34)
[<c000f880>] (machine_power_off) from [<c004089c>] (kernel_power_off+0x44/0x50)
[<c0040858>] (kernel_power_off) from [<c0040afc>] (SyS_reboot+0x12c/0x1bc)
[<c00409d0>] (SyS_reboot) from [<c000eb40>] (ret_fast_syscall+0x0/0x48)
 r7:00000058 r6:00000001 r5:00000000 r4:00000000
---[ end trace eae2f29f1a23e46a ]---

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
