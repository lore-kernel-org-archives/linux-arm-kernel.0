From: eric.miao@linaro.org (Eric Miao)
Date: Fri, 2 Dec 2011 18:01:08 +0800
Subject: Building of arch/arm/plat-mxc/ssi-fiq.S failed w/ THUMB2 enabled?
Message-ID: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave & Sascha,

I checked the log of this file, found a THUMB2 related changes, yet
I'm still having the failure below, can you help do a quick check?


AS      arch/arm/plat-mxc/ssi-fiq.o
arch/arm/plat-mxc/ssi-fiq.S: Assembler messages:
arch/arm/plat-mxc/ssi-fiq.S:45: Error: r13 not allowed here -- `tst r13,#(1<<0)'
arch/arm/plat-mxc/ssi-fiq.S:50: Error: r13 not allowed here -- `tst r13,#(1<<0)'
arch/arm/plat-mxc/ssi-fiq.S:59: Error: r13 not allowed here -- `ldrh r13,[r11]'
arch/arm/plat-mxc/ssi-fiq.S:60: Error: r13 not allowed here -- `strh
r13,[r12,#0x00]'
arch/arm/plat-mxc/ssi-fiq.S:62: Error: r13 not allowed here -- `ldrh
r13,[r11,#2]'
arch/arm/plat-mxc/ssi-fiq.S:63: Error: r13 not allowed here -- `strh
r13,[r12,#0x00]'
arch/arm/plat-mxc/ssi-fiq.S:65: Error: r13 not allowed here -- `ldrh
r13,[r11,#4]'
arch/arm/plat-mxc/ssi-fiq.S:66: Error: r13 not allowed here -- `strh
r13,[r12,#0x00]'
arch/arm/plat-mxc/ssi-fiq.S:68: Error: r13 not allowed here -- `ldrh
r13,[r11,#6]'
arch/arm/plat-mxc/ssi-fiq.S:69: Error: r13 not allowed here -- `strh
r13,[r12,#0x00]'
arch/arm/plat-mxc/ssi-fiq.S:72: Error: r13 not allowed here -- `lsr r13,r8,#16'
arch/arm/plat-mxc/ssi-fiq.S:74: Error: r13 not allowed here -- `lslgt
r8,r13,#16'
arch/arm/plat-mxc/ssi-fiq.S:81: Error: r13 not allowed here -- `tst r13,#(1<<2)'
arch/arm/plat-mxc/ssi-fiq.S:86: Error: r13 not allowed here -- `tst r13,#(1<<2)'
arch/arm/plat-mxc/ssi-fiq.S:98: Error: r13 not allowed here -- `tst r13,#(1<<0)'
arch/arm/plat-mxc/ssi-fiq.S:101: Error: r13 not allowed here -- `strh r13,[r11]'
arch/arm/plat-mxc/ssi-fiq.S:104: Error: r13 not allowed here -- `strh
r13,[r11,#2]'
arch/arm/plat-mxc/ssi-fiq.S:110: Error: r13 not allowed here -- `strh
r13,[r11,#4]'
arch/arm/plat-mxc/ssi-fiq.S:113: Error: r13 not allowed here -- `strh
r13,[r11,#6]'
arch/arm/plat-mxc/ssi-fiq.S:119: Error: r13 not allowed here -- `lsr r13,r9,#16'
arch/arm/plat-mxc/ssi-fiq.S:121: Error: r13 not allowed here -- `lslgt
r9,r13,#16'
make[2]: *** [arch/arm/plat-mxc/ssi-fiq.o] Error 1
make[1]: *** [arch/arm/plat-mxc] Error 2
make[1]: *** Waiting for unfinished jobs....
