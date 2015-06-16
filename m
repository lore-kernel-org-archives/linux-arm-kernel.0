From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Jun 2015 17:13:37 -0300
Subject: Running kexec on mx6
In-Reply-To: <20150616195828.GT7557@n2100.arm.linux.org.uk>
References: <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <CAOMZO5CvjfADx_0AhxVNwadPTb-i5LCdPTOq2ZQaYpzo-m+4Jg@mail.gmail.com>
 <CAOMZO5Br0BBSeSxtCG3aeew7ToVuBH00xEJhAsjHWRCav8+ufA@mail.gmail.com>
 <CAOMZO5DBoKXE9URxWvk+WkJEZ1RkC4S3hAyugTbd7b5Qu91QKA@mail.gmail.com>
 <CAOMZO5DOdrJdkvmtBV3Kegdxg=LVZB60qB_TvMJ-D45+1vDAHw@mail.gmail.com>
 <20150616094242.GR7557@n2100.arm.linux.org.uk>
 <CAOMZO5B9ysnLKpCrpyN3JBUrxVT7MOh7crY3nS8MDW2Hv4Xs+A@mail.gmail.com>
 <CAOMZO5BYCNuQ=5zHurf6Zqmpwcj1tiCZj7Nj4j6ygijbePNBFw@mail.gmail.com>
 <20150616161317.GS7557@n2100.arm.linux.org.uk>
 <CAOMZO5A43JV9piTpkoQQdkYr2P-ysEZVaXLQWd4mNW7OTe_ANw@mail.gmail.com>
 <20150616195828.GT7557@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5CrqAhcx=CmYVmKQ0t0oF-pduJYVio3xbUinvL8yTnrRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 4:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> If you don't have that commit, kexec should fail gracefully if it thinks
> it can't cope with the existing system config - it shouldn't get to the
> point where it takes the existing kernel down.

That's correct. On 4.0.5:

root at wandboard-solo:~# kexec -d -l /tmp/zImage --dtb
/tmp/imx6dl-wandboard.dtb --command-line="console=ttymxc0,115200
earlyprintk root=/dev/mmcblk0p2 rootwait rw"
my_load:667: do
kernel: 0x75dd1008 kernel_size: 0x5664c8
kexec_load: entry = 0x10008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0x75dd1008
segment[0].bufsz = 0x5664c8
segment[0].mem   = 0x10008000
segment[0].memsz = 0x567000
segment[1].buf   = 0x10ab008
segment[1].bufsz = 0x6ba7
segment[1].mem   = 0x1159b000
segment[1].memsz = 0x7000
kexec_load failed: Invalid argument
entry       = 0x10008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0x75dd1008
segment[0].bufsz = 0x5664c8
segment[0].mem   = 0x10008000
segment[0].memsz = 0x567000
segment[1].buf   = 0x10ab008
segment[1].bufsz = 0x6ba7
segment[1].mem   = 0x1159b000
segment[1].memsz = 0x7000

Applying fee3fd4fd2ad136b into 4.0.5 then kexec works fine.

Should we send fee3fd4fd2ad136b to stable?

Thanks
