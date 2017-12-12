From: pintu.ping@gmail.com (Pintu Kumar)
Date: Tue, 12 Dec 2017 21:49:42 +0530
Subject: [VDSO]: vdso_test failing on arm 32 bit
Message-ID: <CAOuPNLiiV=8xy+Fr3fqtsGWrJmCYPzzTDZSySntXZwHtonDobw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Did anybody tried running vdso_test (under Documentation/vDSO in
kernel 4.1) on an ARM 32 bit system?

When I test it on iMX.7 board (kernel 4.1, ARM 32 bit), I get this:
# ./vdso_test
Could not find __vdso_gettimeofday

When I check more in parse_vdso.c, I found that under vdso_sym
function, sym->st_name is returning 0 for the first time, and next it
returns value 54, then exit and finally vdso_sym returning 0.
So, its not able to parse the gettimeofday symbol from the ELF header.
When I check arch/arm/kernel/vdso.so, the symbol is present.

I even tried for clock_gettime, and even this is also failing.

Note: the same test is working fine on Ubuntu 16.04 (64 bit), when
compiled with both 32 bit and 64 bit version.
Even, the test is working on ARM 64 bit.

If anybody is aware, please let me know if vdso_test is supported on
ARM 32 bit system or not?


Thanks,
Pintu
