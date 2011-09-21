From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Sep 2011 23:37:03 +0800
Subject: [GIT PULL] CSR prima2 PM support for 3.2
Message-ID: <CAGsJ_4y6vuy8ZicefRR8DE6Zoj2nzy1JcOxhHK3Xos8d9NxxSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Can you pls pull the prima2 PM support for 3.2? As the patchset
depends on rtciobrg you pulled last time, i didn't rebase it to 3.1-rc
to avoid merge conflict.

The following changes since commit 684f741446f7a3108b4c167faf20214c42b7eeac:
  Zhiwu Song (1):
        ARM: CSR: add rtc i/o bridge interface for SiRFprimaII

are available in the git repository at:

  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git for-arnd

Barry Song (2):
      ARM: CSR: PM: save/restore timer status in suspend cycle
      ARM: CSR: PM: save/restore irq status in suspend cycle

Rongjun Ying (1):
      ARM: CSR: PM: add sleep entry for SiRFprimaII

 arch/arm/mach-prima2/Makefile |    1 +
 arch/arm/mach-prima2/irq.c    |   40 +++++++++++
 arch/arm/mach-prima2/pm.c     |  149 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/pm.h     |   29 ++++++++
 arch/arm/mach-prima2/sleep.S  |   64 ++++++++++++++++++
 arch/arm/mach-prima2/timer.c  |   34 +++++++++
 6 files changed, 317 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-prima2/pm.c
 create mode 100644 arch/arm/mach-prima2/pm.h
 create mode 100644 arch/arm/mach-prima2/sleep.S

Thanks
barry

2011/9/11 Barry Song <21cnbao@gmail.com>:
> Hi Arnd,
> can you please pull the 1st patchset of CSR prima2 for next? most of
> them are minor changes except that rtciobrg is new stuff.
>
> The following changes since commit ddf28352b80c86754a6424e3a61e8bdf9213b3c7:
> ?Linus Torvalds (1):
> ? ? ? ?Linux 3.1-rc5
>
> are available in the git repository at:
>
> ?git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git for-arnd
>
> Barry Song (3):
> ? ? ?ARM: CSR: add lost Resource Sharing Control(RSC) node in dts
> ? ? ?ARM: CSR: extend the compatibility of gpio controller to pinmux in dts
> ? ? ?ARM: CSR: IRQ: add simple irq_domain so that hw irq can map to Linux
>
> Jamie Iles (1):
> ? ? ?ARM: CSR: add missing sentinels to of_device_id tables
>
> Zhiwu Song (1):
> ? ? ?ARM: CSR: add rtc i/o bridge interface for SiRFprimaII
>
> ?arch/arm/boot/dts/prima2-cb.dts ? ? ?| ? ?9 ++-
> ?arch/arm/mach-prima2/Makefile ? ? ? ?| ? ?1 +
> ?arch/arm/mach-prima2/clock.c ? ? ? ? | ? ?1 +
> ?arch/arm/mach-prima2/irq.c ? ? ? ? ? | ? ?4 +
> ?arch/arm/mach-prima2/rstc.c ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-prima2/rtciobrg.c ? ? ?| ?139 ++++++++++++++++++++++++++++++++++
> ?arch/arm/mach-prima2/timer.c ? ? ? ? | ? ?1 +
> ?include/linux/rtc/sirfsoc_rtciobrg.h | ? 18 +++++
> ?8 files changed, 172 insertions(+), 2 deletions(-)
> ?create mode 100644 arch/arm/mach-prima2/rtciobrg.c
> ?create mode 100644 include/linux/rtc/sirfsoc_rtciobrg.h
>
> Thanks
> barry
>
