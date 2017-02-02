From: pullururajasekhar@gmail.com (Rajasekhar Pulluru)
Date: Fri, 3 Feb 2017 00:19:37 +0530
Subject: Unhandled fault: alignment fault (0x92000061) at un-aligned address
Message-ID: <CAGA5_H4w4uaS_DeFEdZh6AkT6PNG2Y-0ZZQbMK-c5bZzJoOS8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I have an arm cortex A-57 machine that is running 3.16 linux kernel
(64bit) compiled using
gcc-linaro-aarch64_be-linux-gnu-4.9-2014.09_linux toolchain.

My application is accessing a member inside a structure at unalinged
address using pointer.

The application is compiled using
gcc-linaro-armeb-linux-gnueabihf-4.9-2014.09_linux toolchain and when
its run,
the application gets bus error with "Unhandled fault: alignment fault
(0x92000061) at 0x00000000fff0f729" on console.

When the same application is compilied using
gcc-linaro-aarch64_be-linux-gnu-4.9-2014.09_linux toolchain,
I don't get any alignment fault even though the member being accessed
is at an un-alinged address.

Could someone help me understand this behaviour and help fix it? (I
couldn't pad the structure as it points to network header
and for some reason the address of the member inside the network
header is not aligned.)

I have tried compiling the application using the
gcc-linaro-armeb-linux-gnueabihf-4.9-2014.09_linux toolchain with
compile flags -mno-unaligned-access and again with -munaligned-access
flags. But I still see the alignment fault in both the cases.


Thanks & Regards,
Rajasekhar
