From: stsp@list.ru (Stas Sergeev)
Date: Thu, 12 Mar 2015 16:03:07 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150312134756.5335cb32@free-electrons.com>
References: <54FF21BE.2040506@list.ru>	<20150311175227.499612af@free-electrons.com>	<55007ADD.6080505@list.ru>	<20150311174618.GE8656@n2100.arm.linux.org.uk>	<55008483.8050603@list.ru>	<20150311193343.0317e3e1@free-electrons.com>	<55018A3C.7020409@list.ru>
 <20150312134756.5335cb32@free-electrons.com>
Message-ID: <55018E8B.8060704@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

12.03.2015 15:47, Thomas Petazzoni ?????:
> Dear Stas Sergeev,
>
>
>> The only problem I now have is the lack of 256Mb of
>> ram.
>>
>> [    0.000000] MEMBLOCK
>> configuration:                                         
>> [    0.000000]  memory size = 0x1f0000000 reserved size =
>> 0x70d6e3             
>> [    0.000000]  memory.cnt  =
>> 0x2                                              
>> [    0.000000]  memory[0x0]     [0x00000000000000-0x000000efffffff],
>> 0xf0000000
>> bytes flags:
>> 0x0                                                               
>> [    0.000000]  memory[0x1]     [0x00000100000000-0x000001ffffffff],
>> 0x100000000
>>  bytes flags: 0x0 
>>
>> There is a 8Gb in a single dimm.
>> Do you have any idea why 0xf0000000-0xffffffff range is missing?
>> I suspect this is something with uboot too.
> No, this is expected. Your physical address space is shared between RAM
> and I/O devices. So the space 0xf0000000 -> 0xffffffff in the physical
> address space is where all the registers for your SoC and PCIe devices
Yeah, I realize that, but I was hoping that some work-around
exists. For example, move entire dimm above 4G? Is this really
impossible? Or maybe move overlapping region above 8G...

> will be located. You are therefore indeed losing 256 MB of RAM, but
> there's nothing that can be done about this.
OK, that's sad.
Thanks for info!
