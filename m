From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sun, 29 Mar 2015 20:34:21 -0300
Subject: Fwd: Ask for help: ARM: mvebu: add NAND support for dove
In-Reply-To: <551714F8.2050401@gmail.com>
References: <551713D8.3060809@gmail.com> <551714F8.2050401@gmail.com>
Message-ID: <55188BFD.5070908@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/28/2015 05:54 PM, Gabriel Dobato wrote:
[..]
> However, if I try to read/write into the mtd partitions, I can not,
> there are errors:
> 
> root at debug:~# nandwrite -p /dev/mtd0 /uImage
> Writing at 0x00000000
> pxa3xx-nand f10c0000.nand: Wait time out!!!
> 
> root at debug:~# flash_erase /dev/mtd0 0 0
> Erasing 128 Kibyte @ 0 --  0 % complete pxa3xx-nand f10c0000.nand: Wait
> time out!!!
> 
> root at debug:~# cat /dev/mtd0
> pxa3xx-nand f10c0000.nand: Wait time out!!!
> 

Maybe a silly question, but does your bootloader initializes the
controller? Are you able to read/write/erase using it?

The current pxa3xx-nand driver relies on that for Armada370/XP, as
timing setup is not properly handled.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
