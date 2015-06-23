From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Tue, 23 Jun 2015 11:35:05 +0100
Subject: build failure with VDSO on non-glibc based systems
Message-ID: <55893659.80607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if the host toolchain is not glibc based then the arm kernel build fails with

 arch/arm/vdso/vdsomunge.c:53:19: fatal error: error.h: No such file or directory

error.h is a glibc only header (ie not available in musl, newlib and bsd libcs).

i attached a patch that fixes the build failure for me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fix-arm-vdsomunge-not-to-depend-on-glibc-specific-er.patch
Type: text/x-patch
Size: 4168 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150623/81f37be6/attachment.bin>
