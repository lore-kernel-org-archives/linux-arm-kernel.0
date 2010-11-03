From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 3 Nov 2010 12:21:34 -0400
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BE1EB1C@dbde02.ent.ti.com>
References: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
	<FCCFB4CDC6E5564B9182F639FC356087034BE1EB1C@dbde02.ent.ti.com>
Message-ID: <AANLkTinSwSnozABAJrNzc+vNNVyV-qOo_avSQXWmihyF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 3, 2010 at 8:59 AM, Taneja, Archit <archit@ti.com> wrote:
> Hi,
>
> Bryan Wu <bryan.wu@canonical.com> wrote:
>> There are 4 duplicated panel drivers in DSS2 display driver.
>> They are similar and generic panel driver can support all
>> them with specific panel configuration.
>> And new panel driver can be easily supported by adding panel
>> configurations into generic panel driver.
>>
>> This patchset introduces generic panel driver, remove 3 panel
>> drivers and enable generic panel driver in board files. And
>> it is based on 2.6.37-rc1.
>>
>> Building with omap2plus_defconfig is successful.
>>
>> Keep sharp_ls_panel, since it contains blacklight control
>> code which will be moved out later.
>>
>> Bryan Wu (3):
>> ? OMAP: DSS2: Add generic panel display driver
>> ? OMAP: DSS2: remove generic panel driver duplicated panel drivers
>> ? OMAP: use generic panel driver in board files
>>
>> ?arch/arm/mach-omap2/board-3430sdp.c ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-omap2/board-am3517evm.c ? ? ? ? ? ? ?| ? ?4 +-
>> ?arch/arm/mach-omap2/board-cm-t35.c ? ? ? ? ? ? ? ? | ? ?4 +-
>> ?arch/arm/mach-omap2/board-devkit8000.c ? ? ? ? ? ? | ? ?2 +
>> ?arch/arm/mach-omap2/board-igep0020.c ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-omap2/board-omap3beagle.c ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-omap2/board-omap3evm.c ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-omap2/board-omap3stalker.c ? ? ? ? ? | ? ?2 +
>> ?arch/arm/plat-omap/include/plat/display.h ? ? ? ? ?| ? 28 +++-
>> ?drivers/video/omap2/displays/Kconfig ? ? ? ? ? ? ? | ? 16 +--
>> ?drivers/video/omap2/displays/Makefile ? ? ? ? ? ? ?| ? ?2 -
>> ?drivers/video/omap2/displays/panel-generic.c ? ? ? | ?153 ++++++++++++++++--
>> ?.../video/omap2/displays/panel-sharp-lq043t1dg01.c | ?165
>> ?-------------------- .../video/omap2/displays/panel-toppoly-tdo35s.c ? ?|
>> ?164 ------------------- 14 files changed, 175 insertions(+), 369 deletions(-)
>> delete mode 100644
>> drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c ?delete mode 100644
>> drivers/video/omap2/displays/panel-toppoly-tdo35s.c
>
> This series will break the build if we try to compile after applying
> only the first or the first two patches of the series since things used
> by the first patch are introduced in the last patch.
>
> Archit

Got it. I will try to reorder the sequence

-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
