From: aric@sdgsystems.com (Aric D. Blumer)
Date: Thu, 25 Feb 2010 10:20:17 -0500
Subject: Soft Lockup Debugging
Message-ID: <4B869531.3030708@sdgsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was wondering if someone could give me some pointers on how to debug
the soft lockup shown in the attachment.

System:  Kernel 2.6.29.6, PXA320, AR6002 wifi using the SDIO stack.

The lockup only occurs when the CPU_FREQ governor is set to powersave
(reducing CPU frequency from 806 MHz to 104 MHz) and the wifi interface
is sending traffic.  I suspect that the main schedule() function is
getting stuck on the runqueue spinlock.  If that's the case, how do I
figure out who is holding the lock?  If that's not the case, can anyone
enlighten me on what exactly is hanging from this trace?

Thanks.



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: soft_lockup.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100225/28cc81e3/attachment-0001.txt>
