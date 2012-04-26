From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 26 Apr 2012 16:22:59 +0200
Subject: i.MX6: 3.4-rc4: WARNING at arch/arm/kernel/smp_twd.c ?
Message-ID: <4F995A43.1050006@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Booting a 3.4-rc4 on a i.MX6 SabreLite board, the kernel boot messages 
contain

...
sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 65075ms
------------[ cut here ]------------
WARNING: at arch/arm/kernel/smp_twd.c:349 
twd_local_timer_of_register+0x54/0x98()
twd_local_timer_of_register failed (-19)
Modules linked in:
Backtrace:
[<80012128>] (dump_backtrace+0x0/0x10c) from [<803fef58>] 
(dump_stack+0x18/0x1c)
  r7:8055ff60 r6:8051cc08 r5:804ad180 r4:0000015d
[<803fef40>] (dump_stack+0x0/0x1c) from [<80021600>] 
(warn_slowpath_common+0x54/0x6c)
[<800215ac>] (warn_slowpath_common+0x0/0x6c) from [<800216bc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:412fc09a r8:8057afc0 r7:805aa5c0 r6:00000000 r5:8054fa8c
r4:00000000
[<80021684>] (warn_slowpath_fmt+0x0/0x40) from [<8051cc08>] 
(twd_local_timer_of_register+0x54/0x98)
  r3:ffffffed r2:804ad19c
[<8051cbb4>] (twd_local_timer_of_register+0x0/0x98) from [<805286a0>] 
(imx6q_timer_init+0x14/0x18)
  r5:8054fa8c r4:8fffffff
[<8052868c>] (imx6q_timer_init+0x0/0x18) from [<8051c80c>] 
(time_init+0x28/0x38)
[<8051c7e4>] (time_init+0x0/0x38) from [<80518890>] 
(start_kernel+0x19c/0x31c)
[<805186f4>] (start_kernel+0x0/0x31c) from [<10008044>] (0x10008044)
  r8:1000406a r7:8057efe4 r6:8054fa5c r5:8057b048 r4:10c53c7d
---[ end trace 1b75b31a2719ed1c ]---
Console: colour dummy device 80x30
...

Any idea or hint?

Best regards

Dirk
