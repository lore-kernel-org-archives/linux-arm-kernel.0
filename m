From: stsp@list.ru (Stas Sergeev)
Date: Thu, 12 Mar 2015 15:44:44 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150311193343.0317e3e1@free-electrons.com>
References: <54FF21BE.2040506@list.ru>	<20150311175227.499612af@free-electrons.com>	<55007ADD.6080505@list.ru>	<20150311174618.GE8656@n2100.arm.linux.org.uk>	<55008483.8050603@list.ru>
 <20150311193343.0317e3e1@free-electrons.com>
Message-ID: <55018A3C.7020409@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 21:33, Thomas Petazzoni ?????:
> Dear Stas Sergeev,
>
> On Wed, 11 Mar 2015 21:08:03 +0300, Stas Sergeev wrote:
>
>> mem=0xc0000000 seems to work!
>> 0xd0000000 or 0xe0000000 do not.
>> OK, so 3Gb instead of 8... but at least it boots! :)
> What is the value of the register 0xf1020254 ?
Hello Thomas, I haven't got to look into that register:
uboot is updated to v2011.12-2014_T2.0 and everything
is working! So thanks once again.
The only problem I now have is the lack of 256Mb of
ram.

[    0.000000] MEMBLOCK
configuration:                                         
[    0.000000]  memory size = 0x1f0000000 reserved size =
0x70d6e3             
[    0.000000]  memory.cnt  =
0x2                                              
[    0.000000]  memory[0x0]     [0x00000000000000-0x000000efffffff],
0xf0000000
bytes flags:
0x0                                                               
[    0.000000]  memory[0x1]     [0x00000100000000-0x000001ffffffff],
0x100000000
 bytes flags: 0x0 

There is a 8Gb in a single dimm.
Do you have any idea why 0xf0000000-0xffffffff range is missing?
I suspect this is something with uboot too.
