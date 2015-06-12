From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Jun 2015 10:53:13 -0300
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
Message-ID: <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 9:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> I am trying to load a kernel and dtb via kexec on a mx6solo wandboard
> board running 4.1-rc7:
>
> root at wandboard-solo:~# kexec -d -l /mnt/zImage --dtb /mnt/imx6dl-wandboard.dtb -
> -command-line="console=ttymxc0,115200 root=/dev/mmcblk2p2 rootwait rw"
> my_load:667: do
> kernel: 0x75da4008 kernel_size: 0x5be000
> kexec_load: entry = 0x10008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0x75da4008
> segment[0].bufsz = 0x5be000
> segment[0].mem   = 0x10008000
> segment[0].memsz = 0x5be000
> segment[1].buf   = 0x1ce9008
> segment[1].bufsz = 0x6c87
> segment[1].mem   = 0x116f9000
> segment[1].memsz = 0x7000
> root at wandboard-solo:~# kexec -e
> [   62.581795] kexec: Starting new kernel
> [   62.585570] Disabling non-boot CPUs ...
> [   62.589485] Bye!
>
> And then nothing comes out.

If I use a 4.1-rc7 to be loaded via kexec then I get the
"Uncompressing Linux... done, booting the kernel" message.

Initially I was loading a 3.10 kernel from a running 4.1-rc7.

Now I see:

root at wandboard-solo:~# kexec -d -l /tmp/zImage --dtb /tmp/imx6dl-wandboard.dtb -
-command-line="console=ttymxc0,115200 root=/dev/mmcblk0p2 rootwait rw"
my_load:667: do
kernel: 0x75d95008 kernel_size: 0x5c99d8
kexec_load: entry = 0x10008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0x75d95008
segment[0].bufsz = 0x5c99d8
segment[0].mem   = 0x10008000
segment[0].memsz = 0x5ca000
segment[1].buf   = 0x1f4008
segment[1].bufsz = 0x6d63
segment[1].mem   = 0x11728000
segment[1].memsz = 0x7000
root at wandboard-solo:~# kexec -e
[   27.591555] kexec: Starting new kernel
[   27.595331] Disabling non-boot CPUs ...
[   27.599250] Bye!
Uncompressing Linux... done, booting the kernel.
