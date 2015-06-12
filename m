From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Jun 2015 11:02:18 -0300
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
Message-ID: <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 10:53 AM, Fabio Estevam <festevam@gmail.com> wrote:

> root at wandboard-solo:~# kexec -d -l /tmp/zImage --dtb /tmp/imx6dl-wandboard.dtb -
> -command-line="console=ttymxc0,115200 root=/dev/mmcblk0p2 rootwait rw"
> my_load:667: do
> kernel: 0x75d95008 kernel_size: 0x5c99d8
> kexec_load: entry = 0x10008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0x75d95008
> segment[0].bufsz = 0x5c99d8
> segment[0].mem   = 0x10008000
> segment[0].memsz = 0x5ca000
> segment[1].buf   = 0x1f4008
> segment[1].bufsz = 0x6d63
> segment[1].mem   = 0x11728000
> segment[1].memsz = 0x7000
> root at wandboard-solo:~# kexec -e
> [   27.591555] kexec: Starting new kernel
> [   27.595331] Disabling non-boot CPUs ...
> [   27.599250] Bye!
> Uncompressing Linux... done, booting the kernel.

Ok, so here is the "kexec -e" output with earlyprintk enabled:

root at wandboard-solo:~# kexec -e
[   33.853279] kexec: Starting new kernel
[   33.857076] Disabling non-boot CPUs ...
[   33.861107] Bye!
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.1.0-rc7-00063-gcff100f (fabio at fabio-Latitude-E645
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instructie
[    0.000000] Machine model: Wandboard i.MX6 Dual Lite Board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 16 MiB at 0x4f000000
[    0.000000] Memory policy: Data cache writeback

And then it hangs here.
