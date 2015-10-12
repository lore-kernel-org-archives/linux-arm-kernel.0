From: vikas.sajjan@samsung.com (VIKAS SAJJAN C)
Date: Mon, 12 Oct 2015 16:38:15 +0000 (GMT)
Subject: HANG at bootup on 3.10 kernel at memset in early_alloc_aligned with
 CMA
Message-ID: <1773685879.894081444667895180.JavaMail.weblogic@epmlwas09a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

 we are recently migrating to 3.10 kernel on a 32bit SoC, I see that while boot up, the kernel HANGS in function early_alloc_aligned() at  memset(ptr, 0, sz);

we are reserving memory using CMA 


we have 4 banks :

bank 1 : 0x200000000,  size 0x10000000

bank 2 : 0x300000000,  size 0x10000000

bank 3 : 0x400000000,  size 0x10000000

bank 4 : 0x500000000,  size 0x0f500000

 
arm_lowmem_limit is set to 0x4f000000 and mapping is created for section: 20000000 ~ 4f000000

 I came across your patch "ARM: 8356/1: mm: handle non-pmd-aligned end of RAM"

Was wondering whether patch is back ported to 3.10 stable branch, if so can you point me to the patch? if not, can you let us know the changes needed for 3.10  kernel.
