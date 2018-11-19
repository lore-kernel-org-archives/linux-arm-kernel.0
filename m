From: pasha.tatashin@soleen.com (Pavel Tatashin)
Date: Mon, 19 Nov 2018 16:44:42 -0500
Subject: [PATCH v1 0/1] Early boot time stamps for arm64
Message-ID: <20181119214443.25175-1-pasha.tatashin@soleen.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I made early boot time stamps available for SPARC and X86.

x86:
https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin at oracle.com

sparc:
https://www.spinics.net/lists/sparclinux/msg18063.html

As discussed at plumbers, I would like to add the same for arm64. The
implementation does not have to be perfect, and should work only when early
clock is easy to determine. arm64 defines a clock register, and thus makes
it easy, but on some platforms frequency register is broken, so if it is
not known, simply don't initialize clock early.

dmesg before:
https://paste.ubuntu.com/p/3pJ5kgJHyN

dmesg after:
https://paste.ubuntu.com/p/RHKGVd9nSM

As seen from the above with base smp_init is finished after 0.47s:
[    0.464585] SMP: Total of 8 processors activated.

But, in reality, 3.2s is missing which is a quiet long considering this is
only 60G domain.

Pavel Tatashin (1):
  arm64: early boot clock for aarch64

 arch/arm64/kernel/setup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.19.1
