From: rabin@rab.in (Rabin Vincent)
Date: Sun, 23 Jan 2011 11:14:11 +0530
Subject: Linux ARM SMP kernel for qemu
In-Reply-To: <AANLkTim4UTckvZeokXy9jhzyvw0NXZTjbE8w6cGvy02d@mail.gmail.com>
References: <AANLkTimi5B8pBVatpq4n2HvcT-iU6+EXwdntV1ucAkVL@mail.gmail.com>
	<AANLkTim4UTckvZeokXy9jhzyvw0NXZTjbE8w6cGvy02d@mail.gmail.com>
Message-ID: <AANLkTik4V3E8G5AZtHxiwb74doBEOVZWUxntNajoPYjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 20:47, Kevin Pouget <kevin.pouget@gmail.com> wrote:
> do you know if it's feasible to compile a Linux kernel to be run by a
> Qemu SMP ARM machine? after so many hours of tries, I can say that any
> version of the kernel, any Qemu machine would be okay, provided that
> the SMP capability is set, and the kernel boots !

Try the kernel from latest git, QEMU from latest git, and the attached
.config.

The .config is just realview_smp-defconfig with:
 - PB11 and ARMv6 disabled
 - PBX A9 and ARMv7 enabled
 - CONFIG_REALVIEW_HIGH_PHYS_OFFSET disabled

Initramfs support is also enabled.  You can boot it with this line (you'll
need an initramfs or initrd to get to userspace):

qemu-system-arm -kernel arch/arm/boot/uImage -nographic \
		-append "earlyprintk console=ttyAMA0 mem=128M debug" \
		-M realview-pbx-a9 -m 128M -initrd ~/kernel/root -smp 2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: qemu-pbx-config
Type: application/octet-stream
Size: 38104 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110123/674c7a1e/attachment-0001.obj>
