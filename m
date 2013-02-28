From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 28 Feb 2013 13:21:57 +0100
Subject: [PATCH v3 0/3] CPUFreq for kzm9g
Message-ID: <1362054120-8600-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of the patch-series, adding CPUFreq support to sh73a0 SoCs and 
to the kzm9g board specifically. It now consists of 3 patches instead of 2, 
as in v2. The first patch is new. It adds waiting to the clock-kicking 
operation for all clocks, controlled by the FRQCRA and FRQCRB operations. 
In principle, this means, that this change affects existing systems, but 
in fact, I don't think any of them currently actively configure rates of 
those clocks, at least I haven't found any occurrences in the mainline. So, 
the risk should be purely theoretical. Other changes are noted in 
respective patches.

Also note, that there seems to be a problem with the TWD clock, when 
adjusting the CPU rate. I'm posting these patches for now for reference, 
but they shouldn't be applied, until the problem is solved.

Thanks
Guennadi

Guennadi Liakhovetski (3):
  ARM: shmobile: sh73a0: wait for completion when kicking the clock
  ARM: shmobile: sh73a0: add support for adjusting CPU frequency
  ARM: shmobile: kzm9g-reference: add CPUFreq support

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   19 ++++-
 arch/arm/mach-shmobile/Kconfig               |    2 +
 arch/arm/mach-shmobile/clock-sh73a0.c        |  118 ++++++++++++++++++++++++--
 3 files changed, 128 insertions(+), 11 deletions(-)

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
