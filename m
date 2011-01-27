From: ecc@cmu.edu (Eric Cooper)
Date: Wed, 26 Jan 2011 22:00:24 -0500
Subject: kexec on kirkwood kernels?
Message-ID: <20110127030024.GF19307@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anyone successfully used kexec to boot one kirkwood kernel from
another?  I've been trying to do it on a Seagate DockStar, but
all I see is this:

    # kexec -l --append="console=ttyS0,115200" zImage
    # kexec -e
    [   35.553632] Starting new kernel
    Uncompressing Linux... done, booting the kernel.

and then nothing.  I've tried with both 2.6.35 and 2.6.38-rc1 kernels.
I've tried modifying the kernel image to set the machine ID
explicitly, but that makes no difference.  I wonder if the boot
parameters are being passed correctly, but I don't know how to check
without any console output. I do have a JTAG setup, but so far I've
only used it cookbook-fashion to re-flash the u-boot NAND partition.
I'm hoping someone can help me avoid having to use gdb over JTAG to
resolve this.  Thanks.

-- 
Eric Cooper             e c c @ c m u . e d u
