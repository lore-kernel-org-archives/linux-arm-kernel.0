From: miloody@gmail.com (loody)
Date: Thu, 10 Jan 2013 18:39:25 +0800
Subject: some question about usermode:kernel mode is not 2:2 or 1:3
Message-ID: <CANudz+snNE9shBTosbVK+xV9P0NPNPR3OH3z5ey=+u_FcFTrkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
There are some hw limitations on my platform.
1. dram size is only 128MB.
2. cpu dram physical address range only from 0x0 ~ 0x8000000(128MB)
    that means my PAGE_OFFSET cannot set as 2G or 3G

per above #1 and #2 limitation, I have to change  PAGE_OFFSET = 0x4000000(64MB)
Kernel booting very well.
but it will fail on running init, the first usermode program.

my question are:
A. I use codesourcety toolchain, is it possible this failure due to
toolchain not knowing the size limitation.
B. if A is correct, should I cross-compile own toolchain to link my own kernel?

-- 
Regards,
