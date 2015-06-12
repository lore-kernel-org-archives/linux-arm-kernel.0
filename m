From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 11 Jun 2015 21:08:01 -0300
Subject: Running kexec on mx6
Message-ID: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to load a kernel and dtb via kexec on a mx6solo wandboard
board running 4.1-rc7:

root at wandboard-solo:~# kexec -d -l /mnt/zImage --dtb /mnt/imx6dl-wandboard.dtb -
-command-line="console=ttymxc0,115200 root=/dev/mmcblk2p2 rootwait rw"
my_load:667: do
kernel: 0x75da4008 kernel_size: 0x5be000
kexec_load: entry = 0x10008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0x75da4008
segment[0].bufsz = 0x5be000
segment[0].mem   = 0x10008000
segment[0].memsz = 0x5be000
segment[1].buf   = 0x1ce9008
segment[1].bufsz = 0x6c87
segment[1].mem   = 0x116f9000
segment[1].memsz = 0x7000
root at wandboard-solo:~# kexec -e
[   62.581795] kexec: Starting new kernel
[   62.585570] Disabling non-boot CPUs ...
[   62.589485] Bye!

And then nothing comes out.

Does anyone have any suggestions on how I can debug this?

Thanks,

Fabio Estevam
