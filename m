From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jun 2015 19:43:53 -0300
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
 <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
Message-ID: <CAOMZO5DBoKXE9URxWvk+WkJEZ1RkC4S3hAyugTbd7b5Qu91QKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 6:40 PM, Fabio Estevam <festevam@gmail.com> wrote:

> [    0.925893] imx-sdma 20ec000.sdma: Direct firmware load for
> imx/sdma/sdma-imx6q.bin failed with error -2
> [    0.935510] imx-sdma 20ec000.sdma: external firmware not found,
> using ROM firmware
> [    0.941269] imx-sdma 20ec000.sdma: initialized
> [    0.943507] pfuze100-regulator 1-0008: Full layer: 1, Metal layer: 1
> [    0.944228] pfuze100-regulator 1-0008: FAB: 0, FIN: 0
> [    0.944236] pfuze100-regulator 1-0008: pfuze100 found.
>
> [Hangs here]

Restarted from a clean build of imx_v6_v7_defconfig and now it can
kexec a linux-next kernel just fine on a mx6qsabresd:
http://pastebin.com/458TY8Z3

However, kexec still hangs the same way on mx6solo:
[  216.673307] kexec: Starting new kernel
[  216.677079] Disabling non-boot CPUs ...
[  216.681002] Bye!
[  216.682852] ********** flushing and disabling L2 cache
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.1.0-rc7-next-20150615-dirty
(fabio at fabio-Latitude-E6410) (gcc version 4.7.3 (Ubuntu/Linaro
4.7.3-12ubu5
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: Wandboard i.MX6 Dual Lite Board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 16 MiB at 0x4f000000
[    0.000000] Memory policy: Data cache writeback

So kexec is working fine on mx6quad, but not on mx6solo.
