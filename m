From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Tue, 4 Dec 2012 22:48:56 +0100
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <20121130143435.GP19440@n2100.arm.linux.org.uk>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
Message-ID: <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have included the complete dmesg log of vanilla 3.7.0-rc7 in my
previous mail.
Here's a relevant snippet of it:

Linux version 3.7.0-rc7+ (dromede at dromedary) (gcc version 4.7.2 (GCC)
) #63 PREEMPT Fri Nov 30 13:49:35 CET 2012
CPU: XScale-PXA270 [69054117] revision 7 (ARMv5TE), cr=0000397f
CPU: VIVT data cache, VIVT instruction cache
Machine: SHARP Akita
Memory policy: ECC disabled, Data cache writeback
BUG: mapping for 0x00000000 at 0xff000000 out of vmalloc space

....

Sharp Scoop Device found at 0x10800000 -> 0xc4846000


It does seem that the kernel boots with the correct platform id.
I doubt that the second scoop device somehow got registered
and blocked those gpio numbers. It would fail to register, this would
be visible in dmesg output. Also, the second scoop device starts at
0x08800040. So the above registered scoop device is scoop device 1.
