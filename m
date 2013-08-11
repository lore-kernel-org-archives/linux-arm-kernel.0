From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 11 Aug 2013 08:54:43 -0700
Subject: SCSI bus failures with qemu-arm in kernel 3.8+
Message-ID: <5207B3C3.9080508@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

trying to boot arm versatile images with qemu results in the following error
if I try to boot with a disk image.

      sym0: <895a> rev 0x0 at pci 0000:00:0d.0 irq 92
      sym0: SCSI BUS has been reset.
      scsi0 : sym-2.2.3
      [...]
      scsi 0:0:0:0: ABORT operation started
      scsi 0:0:0:0: ABORT operation timed-out.
      [...]

Yocto's 3.8 kernel images work, upstream kernels 3.8 and later fail
(I did not check if/how earlier kernels are affected).

Tracking this down shows that the problem is known and has been fixed with
commit 351d1339 (arm: add dummy swizzle for versatile with qemu) in the
Yocto 3.8 kernel at git://git.yoctoproject.org/linux-yocto-3.8.

Would it be possible to submit this patch for inclusion into affected upstream kernels ?

Thanks,
Guenter
