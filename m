From: kasi.anbumony@ti.com (Anbumony, Kasi Lakshman Karthi)
Date: Wed, 21 Apr 2010 18:11:18 -0500
Subject: Can I use VFP in work queue context ? 
Message-ID: <2A1038AD87AFFA4291065666737B4EAA08CB0BA1BC@dlee06.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have done some optimization in NEON (Neon/VFP sharing the same register set) and using it in my driver running in (Linux) kernel space. The neon optimized code will be used under a work queue context and not under any interrupt. Going by the design of Linux kernel, it looks like there is no context save and restore on VFP registers whenever there is a context switch from user mode to kernel mode, but Linux handles the same for user space processes.

Currently I am not seeing any issues (may be lucky) with my implementation (any exceptions) and was wondering whether it is safe to use of neon code in work queue context? My development platform is OMAP 3 (ARM cortex A-8) and using Android with Linux kernel: 2.6.29.

Thanks
-Anbumony, Kasi Lakshman Karthi

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100421/c337dc9a/attachment-0001.htm>
