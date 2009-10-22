From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 23 Oct 2009 00:36:31 +0200
Subject: [WARNING] pxamci: 'pxa2xx-mci.0' does not have a release() function.
Message-ID: <20091023003631.1331a60a.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I get this warning on shutdown. How to fix it properly?

FYI, in my setup pxa2xx_spi is the parent for pxamci, set using
this patch:
http://git.openezx.org/openezx.git?a=commitdiff;h=0ffd85ad8faea3456d4ecf5f63ae65aca26fff21

WARNING: at drivers/base/core.c:124 device_release+0x68/0x7c()
Device 'pxa2xx-mci.0' does not have a release() function, it is broken and must be fixed.
Modules linked in: bridge stp llc ipv6
[<c002fd44>] (unwind_backtrace+0x0/0xe0) from [<c004399c>] (warn_slowpath_common+0x4c/0x68)
[<c004399c>] (warn_slowpath_common+0x4c/0x68) from [<c00439f4>] (warn_slowpath_fmt+0x28/0x38)
[<c00439f4>] (warn_slowpath_fmt+0x28/0x38) from [<c01717c4>] (device_release+0x68/0x7c)
[<c01717c4>] (device_release+0x68/0x7c) from [<c0134a38>] (kobject_release+0x5c/0x74)
[<c0134a38>] (kobject_release+0x5c/0x74) from [<c0135778>] (kref_put+0x68/0x7c)
[<c0135778>] (kref_put+0x68/0x7c) from [<c029b47c>] (klist_next+0xa8/0xb4)
[<c029b47c>] (klist_next+0xa8/0xb4) from [<c0170674>] (next_device+0xc/0x1c)
[<c0170674>] (next_device+0xc/0x1c) from [<c01706c8>] (device_for_each_child+0x44/0x6c)
[<c01706c8>] (device_for_each_child+0x44/0x6c) from [<c0183308>] (spi_unregister_master+0x18/0x28)
[<c0183308>] (spi_unregister_master+0x18/0x28) from [<c0183f48>] (pxa2xx_spi_remove+0xd4/0xf0)
[<c0183f48>] (pxa2xx_spi_remove+0xd4/0xf0) from [<c01845ac>] (pxa2xx_spi_shutdown+0x10/0x48)
[<c01845ac>] (pxa2xx_spi_shutdown+0x10/0x48) from [<c01749b4>] (platform_drv_shutdown+0x1c/0x24)
[<c01749b4>] (platform_drv_shutdown+0x1c/0x24) from [<c0170410>] (device_shutdown+0x5c/0xbc)
[<c0170410>] (device_shutdown+0x5c/0xbc) from [<c00525cc>] (kernel_power_off+0x10/0x44)
[<c00525cc>] (kernel_power_off+0x10/0x44) from [<c0053844>] (sys_reboot+0x118/0x1d8)
[<c0053844>] (sys_reboot+0x118/0x1d8) from [<c0029f20>] (ret_fast_syscall+0x0/0x34)

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091023/67e4583e/attachment.sig>
