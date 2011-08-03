From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 3 Aug 2011 11:47:52 +0800
Subject: [PATCH 3.1 0/4] ARM: simpad: Add support for GPIO attached
	hardware
In-Reply-To: <1310453186-22518-1-git-send-email-jochen@scram.de>
References: <1310453186-22518-1-git-send-email-jochen@scram.de>
Message-ID: <CAK5ve-+mT4EOU0p6=A-XSg24u43Y2+nJuCqVBB6CT5Bdi0TjAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jochen,

Is there any news about this patchset? Merged already? I'm going to
post an updated Led patchset based on this.

Thanks,
-Bryan

On Tue, Jul 12, 2011 at 2:46 PM, Jochen Friedrich <jochen@scram.de> wrote:
> Resend as this might got lost in the develtech.com disaster.
> Bryan Wu <bryan.wu@canonical.com> intends to base his patch set to
> get rid of the custom LED code on this series.
>
> This series enables GPIO API on UCB1x00 and implements the GPIO
> API on the CS3 latch. The third patch finally registers platform
> devices for the GPIO attached LED, buttons and I2C bus.
>
> ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
> ARM: simpad: Cleanup CS3 accessors and add GPIO API
> ARM: simpad: add GPIO based device definitions
> ARM: simpad: replace ARM specific LED code
>
> Overall diffstat:
>
> ?arch/arm/mach-sa1100/Makefile ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-sa1100/include/mach/simpad.h | ? 94 ++++++++++---
> ?arch/arm/mach-sa1100/leds-simpad.c ? ? ? ? | ?100 -------------
> ?arch/arm/mach-sa1100/leds.c ? ? ? ? ? ? ? ?| ? ?2 -
> ?arch/arm/mach-sa1100/leds.h ? ? ? ? ? ? ? ?| ? ?1 -
> ?arch/arm/mach-sa1100/simpad.c ? ? ? ? ? ? ?| ?211 ++++++++++++++++++++++++---
> ?drivers/pcmcia/sa1100_simpad.c ? ? ? ? ? ? | ? 35 ++---
> ?7 files changed, 274 insertions(+), 170 deletions(-)
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
