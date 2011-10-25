From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 25 Oct 2011 23:03:35 +0800
Subject: [GIT PULL] pxa: fixes for next
In-Reply-To: <4EA6C8A9.5000305@compulab.co.il>
References: <CAMPhdO8hOZ6=RHrF4evR+2A0R5v7v1QRfYPBtH274NkfA6fV5g@mail.gmail.com>
	<4EA6C8A9.5000305@compulab.co.il>
Message-ID: <CAMPhdO-SM88yeaQMG27MODCHCxDM3U=7=JDP0uphb_w-nfWAkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry Igor, now merged.

Anrd,

With that specific patch queued, see the updated request as below:

The following changes since commit c3b92c8787367a8bb53d57d9789b558f1295cc96:

  Linux 3.1 (2011-10-24 09:10:05 +0200)

are available in the git repository at:
  git://github.com/ycmiao/pxa-linux.git fix

Arnd Bergmann (9):
      ARM: pxa: make zylonite_pxa*_init declaration match code
      ARM: pxa: export symbols from pxa3xx-ulpi
      ARM: pxa: allow selecting just one of TREO680/CENTRO
      ARM: pxa: CPU_FREQ_TABLE is needed for CPU_FREQ
      ARM: pxa: pxa95x is incompatible with earlier pxa
      ARM: pxa: select POWER_SUPPLY on raumfeld
      ARM: pxa: centro and treo680 need palm27x
      ARM: pxa: sharpsl pm needs SPI
      ARM: pxa: use correct __iomem annotations

Axel Lin (1):
      ARM: pxa/cm-x300: properly set bt_reset pin

Eric Miao (5):
      ARM: pxa: fix building error by palm27x_lcd_init() when FB_PXA not defined
      ARM: pxa/z2: fix building error of pxa27x_cpu_suspend() no
longer available
      ARM: pxa: pxa95x/saarb depends on pxa3xx code
      ARM: pxa: make pxafb_smart_*() empty when not enabled
      ARM: mmp: rename SHEEVAD to GPLUGD

 arch/arm/Kconfig                          |    1 +
 arch/arm/include/asm/hardware/it8152.h    |    2 +-
 arch/arm/mach-mmp/Kconfig                 |    2 +-
 arch/arm/mach-mmp/Makefile                |    2 +-
 arch/arm/mach-mmp/clock.h                 |    8 +++---
 arch/arm/mach-mmp/common.c                |    4 +-
 arch/arm/mach-mmp/gplugd.c                |    2 +-
 arch/arm/mach-mmp/include/mach/addr-map.h |   10 ++++++-
 arch/arm/mach-mmp/mmp2.c                  |    3 +-
 arch/arm/mach-pxa/Kconfig                 |   38 ++++++++++++++++++++++-------
 arch/arm/mach-pxa/Makefile                |    2 +-
 arch/arm/mach-pxa/balloon3.c              |   10 ++++----
 arch/arm/mach-pxa/cm-x2xx-pci.c           |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c               |    4 +-
 arch/arm/mach-pxa/cm-x300.c               |    8 ++----
 arch/arm/mach-pxa/include/mach/addr-map.h |    8 +++---
 arch/arm/mach-pxa/include/mach/balloon3.h |    2 +-
 arch/arm/mach-pxa/include/mach/hardware.h |    9 ++++---
 arch/arm/mach-pxa/include/mach/lpd270.h   |    4 +-
 arch/arm/mach-pxa/include/mach/mtd-xip.h  |    1 -
 arch/arm/mach-pxa/include/mach/palm27x.h  |    2 +-
 arch/arm/mach-pxa/include/mach/palmtx.h   |    6 ++--
 arch/arm/mach-pxa/include/mach/pxa27x.h   |    2 +
 arch/arm/mach-pxa/include/mach/pxa95x.h   |    7 +++++
 arch/arm/mach-pxa/include/mach/pxafb.h    |   13 ++++++++++
 arch/arm/mach-pxa/include/mach/smemc.h    |    2 +-
 arch/arm/mach-pxa/include/mach/zeus.h     |    4 +-
 arch/arm/mach-pxa/include/mach/zylonite.h |    4 +-
 arch/arm/mach-pxa/irq.c                   |    4 +-
 arch/arm/mach-pxa/lpd270.c                |    2 +-
 arch/arm/mach-pxa/palmtreo.c              |    8 ++++++
 arch/arm/mach-pxa/palmtx.c                |    8 +++---
 arch/arm/mach-pxa/pxa25x.c                |    2 +-
 arch/arm/mach-pxa/pxa27x.c                |    2 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c           |    2 +
 arch/arm/mach-pxa/pxa3xx.c                |    2 +-
 arch/arm/mach-pxa/saarb.c                 |    3 +-
 arch/arm/mach-pxa/z2.c                    |    3 +-
 arch/arm/mach-pxa/zeus.c                  |    8 +++---
 arch/arm/plat-pxa/gpio.c                  |    2 +-
 arch/arm/plat-pxa/include/plat/mfp.h      |    2 +-
 arch/arm/plat-pxa/mfp.c                   |    4 +-
 drivers/pcmcia/pxa2xx_balloon3.c          |    2 +-
 drivers/video/mbx/mbxfb.c                 |    6 ++--
 drivers/video/pxafb.c                     |   10 -------
 45 files changed, 140 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa95x.h


On Tue, Oct 25, 2011 at 10:33 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Eric,
>
> Can you please include the below patch [1] in your pull request?
>
> [1] https://lkml.org/lkml/2011/9/17/38
>
> It has been quit a long time on the list and it fixes a regression.
>
> Thanks
> Igor
>
> On 10/25/2011 03:04 PM, Eric Miao wrote:
>> Arnd,
>>
>> The fixes are mostly your randconfig fixes which are acked, we'll go
>> through the remaining issues next cycle.
>>
>> The following changes since commit c3b92c8787367a8bb53d57d9789b558f1295cc96:
>>
>> ? Linux 3.1 (2011-10-24 09:10:05 +0200)
>>
>> are available in the git repository at:
>> ? git://github.com/ycmiao/pxa-linux.git fix
>>
>> Arnd Bergmann (9):
>> ? ? ? ARM: pxa: make zylonite_pxa*_init declaration match code
>> ? ? ? ARM: pxa: export symbols from pxa3xx-ulpi
>> ? ? ? ARM: pxa: allow selecting just one of TREO680/CENTRO
>> ? ? ? ARM: pxa: CPU_FREQ_TABLE is needed for CPU_FREQ
>> ? ? ? ARM: pxa: pxa95x is incompatible with earlier pxa
>> ? ? ? ARM: pxa: select POWER_SUPPLY on raumfeld
>> ? ? ? ARM: pxa: centro and treo680 need palm27x
>> ? ? ? ARM: pxa: sharpsl pm needs SPI
>> ? ? ? ARM: pxa: use correct __iomem annotations
>>
>> Eric Miao (5):
>> ? ? ? ARM: pxa: fix building error by palm27x_lcd_init() when FB_PXA not defined
>> ? ? ? ARM: pxa/z2: fix building error of pxa27x_cpu_suspend() no
>> longer available
>> ? ? ? ARM: pxa: pxa95x/saarb depends on pxa3xx code
>> ? ? ? ARM: pxa: make pxafb_smart_*() empty when not enabled
>> ? ? ? ARM: mmp: rename SHEEVAD to GPLUGD
>>
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/include/asm/hardware/it8152.h ? ?| ? ?2 +-
>> ?arch/arm/mach-mmp/Kconfig ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?arch/arm/mach-mmp/Makefile ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-mmp/clock.h ? ? ? ? ? ? ? ? | ? ?8 +++---
>> ?arch/arm/mach-mmp/common.c ? ? ? ? ? ? ? ?| ? ?4 +-
>> ?arch/arm/mach-mmp/gplugd.c ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-mmp/include/mach/addr-map.h | ? 10 ++++++-
>> ?arch/arm/mach-mmp/mmp2.c ? ? ? ? ? ? ? ? ?| ? ?3 +-
>> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? | ? 38 ++++++++++++++++++++++-------
>> ?arch/arm/mach-pxa/Makefile ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-pxa/balloon3.c ? ? ? ? ? ? ?| ? 10 ++++----
>> ?arch/arm/mach-pxa/cm-x2xx-pci.c ? ? ? ? ? | ? ?2 +-
>> ?arch/arm/mach-pxa/cm-x2xx.c ? ? ? ? ? ? ? | ? ?4 +-
>> ?arch/arm/mach-pxa/include/mach/addr-map.h | ? ?8 +++---
>> ?arch/arm/mach-pxa/include/mach/balloon3.h | ? ?2 +-
>> ?arch/arm/mach-pxa/include/mach/hardware.h | ? ?9 ++++---
>> ?arch/arm/mach-pxa/include/mach/lpd270.h ? | ? ?4 +-
>> ?arch/arm/mach-pxa/include/mach/mtd-xip.h ?| ? ?1 -
>> ?arch/arm/mach-pxa/include/mach/palm27x.h ?| ? ?2 +-
>> ?arch/arm/mach-pxa/include/mach/palmtx.h ? | ? ?6 ++--
>> ?arch/arm/mach-pxa/include/mach/pxa27x.h ? | ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/pxa95x.h ? | ? ?7 +++++
>> ?arch/arm/mach-pxa/include/mach/pxafb.h ? ?| ? 13 ++++++++++
>> ?arch/arm/mach-pxa/include/mach/smemc.h ? ?| ? ?2 +-
>> ?arch/arm/mach-pxa/include/mach/zeus.h ? ? | ? ?4 +-
>> ?arch/arm/mach-pxa/include/mach/zylonite.h | ? ?4 +-
>> ?arch/arm/mach-pxa/irq.c ? ? ? ? ? ? ? ? ? | ? ?4 +-
>> ?arch/arm/mach-pxa/lpd270.c ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-pxa/palmtreo.c ? ? ? ? ? ? ?| ? ?8 ++++++
>> ?arch/arm/mach-pxa/palmtx.c ? ? ? ? ? ? ? ?| ? ?8 +++---
>> ?arch/arm/mach-pxa/pxa25x.c ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-pxa/pxa27x.c ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-pxa/pxa3xx-ulpi.c ? ? ? ? ? | ? ?2 +
>> ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-pxa/saarb.c ? ? ? ? ? ? ? ? | ? ?3 +-
>> ?arch/arm/mach-pxa/z2.c ? ? ? ? ? ? ? ? ? ?| ? ?3 +-
>> ?arch/arm/mach-pxa/zeus.c ? ? ? ? ? ? ? ? ?| ? ?8 +++---
>> ?arch/arm/plat-pxa/gpio.c ? ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/plat-pxa/include/plat/mfp.h ? ? ?| ? ?2 +-
>> ?arch/arm/plat-pxa/mfp.c ? ? ? ? ? ? ? ? ? | ? ?4 +-
>> ?drivers/pcmcia/pxa2xx_balloon3.c ? ? ? ? ?| ? ?2 +-
>> ?drivers/video/mbx/mbxfb.c ? ? ? ? ? ? ? ? | ? ?6 ++--
>> ?drivers/video/pxafb.c ? ? ? ? ? ? ? ? ? ? | ? 10 -------
>> ?44 files changed, 137 insertions(+), 87 deletions(-)
>> ?create mode 100644 arch/arm/mach-pxa/include/mach/pxa95x.h
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
>
