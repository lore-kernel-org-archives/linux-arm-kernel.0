From: robert.aden@crlsweden.com (Robert Aden)
Date: Wed, 24 Aug 2011 13:12:23 +0200
Subject: Gumstix: smc91x and CPU frequency scaling hangs system.
Message-ID: <4E54DC97.8030602@crlsweden.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi everybody.

I'm not sure this is the right list to post to, but as the NIC chip 
seems to be common
on arm platforms, and the fact that Russell King has written parts of 
the driver
I will give it a try. Otherwise, someone perhaps could point me to the 
right list?

I'm using a gumstix verdex pro platform with the netpro-vx add-on board with
kernel 2.6.32 + the gumstix-verdex pro platform support patches from 
open-wrt.
Everything is stable in normal operations.

However, when enabling the cpu frequency scaling functionality on the 
platform to
save power, the system becomes very unstable. The only mode i can safely 
use is
the "powersave" mode in which case the CPU always run at it lowest speed.

As soon as i use one of the other modes (conservative, ondemand, or 
userspace)
the platform either looses network connectivity, or hangs completely. 
When only
the networks stop working i can see a lot of the following i dmesg:

smc_hard_start_xmit: smc91x: bank reg screwed (0x33fe)
and
smc_interrupt: smc91x: bank reg screwed (0x33fe)

Sometimes the network comes back up again when the system load settles 
and the
cpu throttles back down, sometimes not.

Is there a known issue with the smc91x driver and CPU scaling or am i 
missing something?

Regards, Robert.

-- 
Robert Aden, R&D Network Team
Communication Research Labs Sweden AB

Address: Gr?ndalsv?gen, 392 36 Kalmar, Sweden
Cellular: +46 (0)70 425 95 77
E-mail: robert.aden at crlsweden.com

Skype: robert_crl
www.crlsweden.com

This communication is confidential and is only intended for the use of the individual or entity to which it is directed.  This Email (and any files or other attachments transmitted with it) is intended solely for the use of the addresee(s).  If you are not the intended recipient, please destroy all copies and notify the sender, you should not retain the message or disclose its contents to anyone.
