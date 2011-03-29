From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 29 Mar 2011 08:35:35 -0000
Subject: [uClinux for armnommu] Undefined reference for access_remote_vm
In-Reply-To: <AANLkTikRMUcoGNGTRB2p8dYvOqV-utPmLDXK-gdTgKea@mail.gmail.com>
References: <AANLkTikRMUcoGNGTRB2p8dYvOqV-utPmLDXK-gdTgKea@mail.gmail.com>
Message-ID: <AANLkTi=-_rQrT0Y+kioV2obr23c2WUF0=MnkfVBab+fK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

I am building linux kernel for armnommu, but I see the error as following:

?CHK ? ? include/generated/compile.h
?UPD ? ? include/generated/compile.h
?CC ? ? ?init/version.o
?LD ? ? ?init/built-in.o
?LD ? ? ?.tmp_vmlinux1
fs/built-in.o?????mem_read???
super.c:(.text+0x40548)??access_remote_vm? Undefined reference
fs/built-in.o?????mem_write???
super.c:(.text+0x406b0)??access_remote_vm? Undefined reference
make: *** [.tmp_vmlinux1] ?? 1

I checked this code, 'access_remote_vm' function was defined in
mm/memory.c, and its Makefile is 'mmu-$(CONFIG_MMU) ? ? := fremap.o
highmem.o madvise.o memory.o',
so if I did not configure this CONFIG_MMU, then the memory.c will not
be built, which leaded to above error.

Thanks!
Wan.
