From: lambertarthur22@gmail.com (Arthur LAMBERT)
Date: Wed, 21 Mar 2018 14:25:48 +0100
Subject: issue with kexec/kdump on imx6ull
In-Reply-To: <20180320191259.GI2743@n2100.armlinux.org.uk>
References: <20180320100427.GA21933@arthur-bzh>
 <20180320104302.GG2743@n2100.armlinux.org.uk>
 <20180320150723.GH2743@n2100.armlinux.org.uk>
 <20180320171608.GB32282@arthur-bzh>
 <20180320191259.GI2743@n2100.armlinux.org.uk>
Message-ID: <20180321132548.GA32618@arthur-bzh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tuesday 20 Mar 2018 ? 19:12:59 (+0000), Russell King - ARM Linux wrote :
> They're all included there.  Please try running kexec in debug mode
> when loading the kernel, and report the output.

No more dtb argument with device tree file path and debug enable now.

Kexec output :

# sh kx.sh
Try gzip decompression.
kernel: 0x768cf008 kernel_size: 0x64a480
MEMORY RANGES
0000000080000000-000000009fffffff (0)
zImage header: 0x016f2818 0x00000000 0x0064a480
zImage size 0x64a480, file size 0x64a480
zImage requires 0x0065b480 bytes
Reserved memory ranges
0000000088000000-000000008b1fffff (0)
Coredump memory ranges
0000000080000000-0000000087ffffff (0)
000000008b200000-000000009fffffff (0)
kernel symbol _stext vaddr =         80100000
phys offset = 0x80000000, page offset = 80000000
Using 32-bit ELF core format
get_crash_notes_per_cpu: crash_notes addr = 8bb3a600, size = 180
Elf header: p_type = 4, p_offset = 0x8bb3a600 p_paddr = 0x8bb3a600 p_vaddr = 0x0 p_filesz = 0xb4 p_memsz = 0xb4
vmcoreinfo header: p_type = 4, p_offset = 0x80fd2610 p_paddr = 0x80fd2610 p_vaddr = 0x0 p_filesz = 0x1024 p_memsz = 0x1024
Elf header: p_type = 1, p_offset = 0x80000000 p_paddr = 0x80000000 p_vaddr = 0x80000000 p_filesz = 0x8000000 p_memsz = 0x8000000
Elf header: p_type = 1, p_offset = 0x8b200000 p_paddr = 0x8b200000 p_vaddr = 0x8b200000 p_filesz = 0x14e00000 p_memsz = 0x14e00000
elfcorehdr: 0x8b100000
crashkernel: [0x88000000 - 0x8b1fffff] (50M)
memory range: [0x80000000 - 0x87ffffff] (128M)
memory range: [0x8b200000 - 0x9fffffff] (334M)
kernel command line: "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw  maxcpus=1 reset_devices init=/sbin/init elfcorehdr=0x8b100000 mem=50176K"
Kernel: address=0x88008000 size=0x01fc8680
DT    : address=0x89fd2000 size=0x0000904c
kexec_load: entry = 0x88008000 flags = 0x280001
nr_segments = 3
segment[0].buf   = 0x768cf008
segment[0].bufsz = 0x64a484
segment[0].mem   = 0x88008000
segment[0].memsz = 0x64b000
segment[1].buf   = 0x996578
segment[1].bufsz = 0x904c
segment[1].mem   = 0x89fd2000
segment[1].memsz = 0xa000
segment[2].buf   = 0x996100
segment[2].bufsz = 0x400
segment[2].mem   = 0x8b100000
segment[2].memsz = 0x1000
kx.sh: kexec: success, dump kernel loaded.

> Also, please run 'size' on the top-level vmlinux and
> arch/arm/boot/compressed/vmlinux.

As said previously in my first mail I am using the same kernel in kexec that in my system.
So not sure to understand why you are asking me to execute 'size' on two differents vmlinux file

size result of vmlinux + size of zimage :

[arthur * dreem] size output/build/linux-rel_imx_4.9.x_1.0.0_ga/arch/arm/boot/compressed/vmlinux
 text	   data	     bss	    dec	    hex	filename
 6595649      60      4124	    6599833  64b499	output/build/linux-rel_imx_4.9.x_1.0.0_ga/arch/arm/boot/compressed/vmlinux
[arthur * dreem] size output/images/zImage
size: output/images/zImage: File format not recognized
[arthur * dreem] du -skh output/images/zImage
 6,3M   output/images/zImage

Thanks,
Arthur.
