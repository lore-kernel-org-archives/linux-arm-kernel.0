From: abhijeet.tripathy@yahoo.co.in (abhijeet tripathi)
Date: Sat, 14 Nov 2009 13:49:32 +0530 (IST)
Subject: Kernel Panic while booting arm-pb1176
Message-ID: <949782.99785.qm@web7604.mail.in.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am trying to do nfs boot of 2.6.29 arm-kernel for pb1176, but it is giving me kernel panic. Below is the dump trace:

=======

[<c00323d0>] (dump_backtrace+0x0/0x10c) from [<c0032890>] (dump_stack+0x18/0x1c)
 r6:c0457f84 r5:000001ce r4:c7829b35
[<c0032878>] (dump_stack+0x0/0x1c) from [<c0048da8>] (warn_slowpath+0x64/0x80)
[<c0048d44>] (warn_slowpath+0x0/0x80) from [<c01111cc>] (sysfs_add_one+0x34/0x48)
 r3:c7bf40f0 r2:c0457f94
 r6:c7829c54 r5:c7bf5bb0 r4:ffffffef
[<c0111198>] (sysfs_add_one+0x0/0x48) from [<c0112218>] (sysfs_do_create_link+0xf4/0x18)
 r5:c7bf5bb0 r4:c7bf5b2c
[<c0112124>] (sysfs_do_create_link+0x0/0x188) from [<c01122d8>] (sysfs_create_link+0x14)
 r8:c04bd7ec r7:c7bf3cc8 r6:00000000 r5:c7bf3c3c r4:c05659b0
[<c01122c4>] (sysfs_create_link+0x0/0x18) from [<c024c4e8>] (device_add+0x180/0x454)
[<c024c368>] (device_add+0x0/0x454) from [<c024c7d8>] (device_register+0x1c/0x20)
[<c024c7bc>] (device_register+0x0/0x20) from [<c025872c>] (mdiobus_register+0x8c/0x14c)
 r4:c7bf3c00
[<c02586a0>] (mdiobus_register+0x0/0x14c) from [<c03ad5f0>] (smsc911x_mii_init+0x3e0/0x)
[<c03ad210>] (smsc911x_mii_init+0x0/0x434) from [<c03ade08>] (smsc911x_drv_probe+0x7c4/)
 r7:00000000 r6:c7b6c800 r5:c7b6cba0 r4:20000013
[<c03ad644>] (smsc911x_drv_probe+0x0/0x9ec) from [<c024f4a8>] (platform_drv_probe+0x20/)
[<c024f488>] (platform_drv_probe+0x0/0x24) from [<c024e650>] (driver_probe_device+0xcc/)
[<c024e584>] (driver_probe_device+0x0/0x178) from [<c024e764>] (__driver_attach+0x68/0x)
 r7:c04d84b4 r6:c04d84b4 r5:c04bd8a0 r4:c04bd7f4
[<c024e6fc>] (__driver_attach+0x0/0x8c) from [<c024dc58>] (bus_for_each_dev+0x54/0x88)
 r6:c024e6fc r5:c7829dc8 r4:00000000
[<c024dc04>] (bus_for_each_dev+0x0/0x88) from [<c024e49c>] (driver_attach+0x20/0x28)
 r7:c7baeb40 r6:00000000 r5:c04d84b4 r4:00000000
[<c024e47c>] (driver_attach+0x0/0x28) from [<c024e0d4>] (bus_add_driver+0xa4/0x210)
[<c024e030>] (bus_add_driver+0x0/0x210) from [<c024ea34>] (driver_register+0x98/0x120)
 r8:00000001 r7:c001d774 r6:00000000 r5:c04d84b4 r4:c0025d04
[<c024e99c>] (driver_register+0x0/0x120) from [<c024f670>] (platform_driver_register+0x)
[<c024f5f8>] (platform_driver_register+0x0/0x94) from [<c001d788>] (smsc911x_init_modul)
[<c001d774>] (smsc911x_init_module+0x0/0x1c) from [<c002e310>] (__exception_text_end+0x)
[<c002e2b0>] (__exception_text_end+0x0/0x190) from [<c0008740>] (kernel_init+0x74/0xdc)
 r8:00000000 r7:00000000 r6:00000000 r5:c0025e44 r4:c0025d04
[<c00086cc>] (kernel_init+0x0/0xdc) from [<c004c644>] (do_exit+0x0/0x858)

======= 

Please let me know if you need any info from me.

Thanks in advance.

--regards,
Abhijeet


      The INTERNET now has a personality. YOURS! See your Yahoo! Homepage. http://in.yahoo.com/
