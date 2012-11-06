From: smoch@web.de (=?ISO-8859-1?Q?S=F6ren_Moch?=)
Date: Tue, 06 Nov 2012 22:28:45 +0100
Subject: [PATCH V2 1/4] arm: mvebu: increase atomic coherent pool size
 for armada 370/XP
Message-ID: <5099810D.9040902@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

resent as plain text, sorry.


 > For Armada 370/XP we have the same problem that for the commit
 > cb01b63, so we applied the same solution: "The default 256 KiB
 > coherent pool may be too small for some of the Kirkwood devices, so
 > increase it to make sure that devices will be able to allocate their
 > buffers with GFP_ATOMIC flag"

I see a regression from linux-3.5 to linux-3.6 and think there might be 
a fundamental problem
with this patch. On my Kirkwood system (guruplug server plus) with 
linux-3.6.2 I see following
errors and corresponding malfunction even with further increased (2M, 
4M) pool size:

Oct 19 00:41:22 guru kernel: ERROR: 4096 KiB atomic DMA coherent pool is 
too small!
Oct 19 00:41:22 guru kernel: Please increase it with coherent_pool= 
kernel parameter!

So I had to downgrade to linux-3.5 which is running without problems.

I use SATA and several DVB sticks (em28xx / drxk and dib0700).

I already sent this bug report to m.szyprowski and 
gregory.clementearlier, but
Sebastian suggested to send it to the mailing list and the responsible 
maintainers, too.

Please write to my e-mail directly if you have further questions or 
patches for me to test.

Regards,
Soeren
