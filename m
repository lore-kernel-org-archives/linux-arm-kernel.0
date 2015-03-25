From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 25 Mar 2015 12:46:47 -0400 (EDT)
Subject: [GIT PULL] MCPM maintenance for v4.1
Message-ID: <alpine.LFD.2.11.1503251216310.27567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider pulling the following:

http://git.linaro.org/people/nicolas.pitre/linux.git mcpm_for_armsoc

This series greatly simplifies things by moving all the locking handling 
to the core code, leaving machine specific backend only with simple and 
straight forward operations performed under lock protection. It will no 
longer be necessary for backend authors to know about all the MCPM 
subtleties for their code to be "right".

To avoid a flag day, the new scheme is introduced in parallel to the 
existing backend interface. This series may be merged at the same time 
as new backends still using the previous interface. That old interface 
should be removed in a subsequent merge cycle after everything is 
converted over.

The diffstat also shows a clear benefit.  Despite the addition of new 
documentation and the previous interface still in place, the number of 
lines actually goes down.

Tested on Versatile Express TC2 and Exynos 5800 (Chromebook2).

 arch/arm/common/mcpm_entry.c       | 202 +++++++++++++++++----
 arch/arm/include/asm/mcpm.h        |  65 ++++++-
 arch/arm/mach-exynos/mcpm-exynos.c | 247 ++++++--------------------
 arch/arm/mach-vexpress/dcscb.c     | 197 +++++++--------------
 arch/arm/mach-vexpress/tc2_pm.c    | 291 +++++++++----------------------
 5 files changed, 436 insertions(+), 566 deletions(-)

Thanks


Nicolas
