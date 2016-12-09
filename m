From: sdliyong@gmail.com (Yong Li)
Date: Fri, 9 Dec 2016 10:28:49 +0800
Subject: boot hang issue on S5PV210 with the latest kernel
Message-ID: <CADO9-pdnfb+noSZ3A_Y+AEZ6pJYzO=KD1pHDzB5WHQ5RoqBsrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am testing the latest kernel(4.8+) on my S5PV210 ARM boards. I found I
have to add the kputc debug in __armv7_mmu_cache_on in
boot/compressed/head.S:
mov r11, r3
kputc #'x'
mov r3, r11

Without the above kputc, the kernel boot hang, there is no any output on UART

Any suggestions?

Thanks,
Yong
