From: huangtao@rock-chips.com (Huang, Tao)
Date: Thu, 13 Oct 2016 15:12:38 +0800
Subject: [PATCH] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
In-Reply-To: <149df5ee-3478-6d15-bb76-47becac146e9@gmail.com>
References: <20161001140939.GA31220@vaio-ubuntu>
 <6239b970-09d3-f7ee-e6f5-c019eaedb725@rock-chips.com>
 <f8aba48d-6c69-b246-4cb2-48a2770c80e4@gmail.com>
 <67831fd0-76af-a793-0b2f-958e45633fe8@rock-chips.com>
 <149df5ee-3478-6d15-bb76-47becac146e9@gmail.com>
Message-ID: <e3746f9a-084e-163e-a412-1a1fc66926d5@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Pawe?:
On 2016?10?10? 17:11, Pawe? Jarosz wrote:
> W dniu 10.10.2016 o 09:18, Huang, Tao pisze:
>> Our IC guy need us tell them which master can not access such area, DMA
>> or EMMC Controller or GPU, etc? Could you tell me how to reproduce such
>> issue?
>> And we can confirm CPU core can access this memory through /dev/mem and
>> the test board is 1GB too. Personally, I don't think RK3066 has such
>> limit because when we verify this chip, we don't found such limit at all.
>>
>> Thanks,
>> Huang, Tao
> I'm getting this on Ubuntu 16.04 with mainline kernel.
> My board always freezes when i type: "memtester 800M"
>
We try run memtest 800M with Linux kernel 4.8, which killed by OOM.
But if we run:
# memtester -p 0x9F000000 16K 1
memtester version 4.3.0 (32-bit)
Copyright (C) 2001-2012 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffff000
want 0MB (16384 bytes)
Loop 1/1:
   Stuck Address       : ok
   Random Value        : ok
   Compare XOR         : ok
   Compare SUB         : ok
   Compare MUL         : ok
   Compare DIV         : ok
   Compare OR          : ok
   Compare AND         : ok
   Sequential Increment: ok
   Solid Bits          : ok
   Block Sequential    : ok
   Checkerboard        : ok
   Bit Spread          : ok
   Bit Flip            : ok
   Walking Ones        : ok
   Walking Zeroes      : ok
   8-bit Writes        : ok
   16-bit Writes       : ok

So these memory should be fine to CPU core. Maybe your system just
freeze because out of memory.
