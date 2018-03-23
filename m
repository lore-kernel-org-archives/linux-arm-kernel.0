From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Mar 2018 11:14:53 -0700
Subject: Regression with arm in next with stack protector
Message-ID: <20180323181452.GJ5799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like commit 5638790dadae ("zboot: fix stack protector in
compressed boot phase") breaks booting on arm.

This is all I get from the bootloader on omap3:

Starting kernel ...

data abort
pc : [<810002d0>]          lr : [<100110a8>]
reloc pc : [<9d6002d0>]    lr : [<2c6110a8>]
sp : 81467c18  ip : 81466bf0     fp : 81466bf0
r10: 80fc2c40  r9 : 81000258     r8 : 86fec000
r7 : ffffffff  r6 : 81466bf8     r5 : 00000000  r4 : 80008000
r3 : 81466c14  r2 : 81466c18     r1 : 000a0dff  r0 : 00466bf8
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
Resetting CPU ...

resetting ...

Regards,

Tony
