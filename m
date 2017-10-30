From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Oct 2017 15:55:12 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <871slk3b2k.fsf@free-electrons.com>
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <87k1zc3fxp.fsf@free-electrons.com>
 <CAKv+Gu95RR3SBb1dydKVVeQQ5+Ui56TcWLfNh=rfmw8_Ty=F7g@mail.gmail.com>
 <87a8083cc2.fsf@free-electrons.com>
 <CAKv+Gu9=xLfyM7ZkK4vNmMkhL2fJnvZmOv-dNNzesk9myadCCA@mail.gmail.com>
 <8760aw3c5p.fsf@free-electrons.com>
 <CAKv+Gu-9pQjBb0YXADRT87qpFb6ttT3tLGBnGNgZj3B1VDRN6Q@mail.gmail.com>
 <871slk3b2k.fsf@free-electrons.com>
Message-ID: <20171030155511.GQ20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 04:33:07PM +0100, Gregory CLEMENT wrote:
> Humm no, actually it was with the wrong branch. If I have the patch
> "ARM: verify size of zImage" then arch/arm/boot/compressed/vmlinux is
> not generated.
> 
> But if I remove this patch then I can generate this file and so:
> arm-linux-gnueabi-readelf -S ../build/arch/arm/boot/compressed/vmlinux
> There are 22 section headers, starting at offset 0x4b402c:
> 
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>   [ 1] .text             PROGBITS        00000000 010000 005ef8 00  AX  0   0 32
>   [ 2] .rodata           PROGBITS        00005ef8 015ef8 000d4c 00   A  0   0  4
>   [ 3] .piggydata        PROGBITS        00006c44 016c44 48a552 00   A  0   0  1
>   [ 4] .got.plt          PROGBITS        00491198 4a1198 00000c 04  WA  0   0  4
>   [ 5] .got              PROGBITS        004911a4 4a11a4 000028 00  WA  0   0  4
>   [ 6] .pad              PROGBITS        004911cc 4a11cc 000004 00  WA  0   0  1
>   [ 7] .bss              NOBITS          004911d0 4a11d0 00001c 00  WA  0   0  4
>   [ 8] .stack            NOBITS          004911f0 4a11d0 001000 00  WA  0   0  1
>   [ 9] .comment          PROGBITS        00000000 4a11d0 00001c 01  MS  0   0  1
>   [10] .ARM.attributes   ARM_ATTRIBUTES  00000000 4a11ec 00002d 00      0   0  1
>   [11] .debug_line       PROGBITS        00000000 4a1219 00281b 00      0   0  1
>   [12] .debug_info       PROGBITS        00000000 4a3a34 0066cb 00      0   0  1
>   [13] .debug_abbrev     PROGBITS        00000000 4aa0ff 0013ea 00      0   0  1
>   [14] .debug_aranges    PROGBITS        00000000 4ab4f0 0001a8 00      0   0  8
>   [15] .debug_str        PROGBITS        00000000 4ab698 0019b4 01  MS  0   0  1
>   [16] .debug_ranges     PROGBITS        00000000 4ad050 000640 00      0   0  8
>   [17] .debug_frame      PROGBITS        00000000 4ad690 001010 00      0   0  4
>   [18] .debug_loc        PROGBITS        00000000 4ae6a0 003643 00      0   0  1
>   [19] .symtab           SYMTAB          00000000 4b1ce4 0015b0 10     20 225  4
>   [20] .strtab           STRTAB          00000000 4b3294 000cc5 00      0   0  1
>   [21] .shstrtab         STRTAB          00000000 4b3f59 0000d2 00      0   0  1

I don't like readelf's output - please can you post the output of
arm-linux-objdump -h ../build/arch/arm/boot/compressed/vmlinux
instead.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
