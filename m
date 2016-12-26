From: nm@ti.com (Nishanth Menon)
Date: Mon, 26 Dec 2016 12:30:10 -0600
Subject: v4.10-rc1 - build failure arm64?
Message-ID: <9e720e28-469f-6a06-a97c-9d52ce951bfb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Not sure if this was already reported (but searching linux-arm and 
linux-next MLs did not quickly show something)

* master 7ce7d89f4883 Linux 4.10-rc1
-> http://pastebin.ubuntu.com/23689404/

Backtracking:
next-20161224, next-20161223, next-20161222-> 
http://pastebin.ubuntu.com/23689415/ (different from master)

next-20161221 -> Builds fine (last clean build)

GCC: 
https://releases.linaro.org/components/toolchain/binaries/latest-6/aarch64-linux-gnu/
$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Linaro GCC 6.2-2016.11) 6.2.1 20161016
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
PURPOSE.

Reproduction steps:

$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 defconfig
$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 Image


-- 
Regards,
Nishanth Menon
