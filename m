From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 21 May 2010 22:27:05 +0200
Subject: Initrd and 2.6.33 curious behaviour
Message-ID: <874oi157c6.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I pulled the 2.6.33 kernel and tried my mainboard with it (mioa701). My kernel
boots fine, but initrd load always fails.

After digging a bit in arch/arm/mm/init.c, I find that :
 - phys_initrd_start = 0xa0508000
 - phys_initrd_size = 3 759 480
 - initrd_start = 0 and initrd_end = 0

I'm a bit puzzled why initrd_start is null. I would expect it to be the virtual
address where the initrd is to be found.

Am I the only one with initrd problems on 2.6.34 kernels ?

For the record, the bootloader is the same I had before (haret), and the ATAGS
list passed to the kernel is correct. The initrd is the same I've been using
since 2.6.29 kernel. I have not tested since 2.6.32 I think.

Cheers.

--
Robert
