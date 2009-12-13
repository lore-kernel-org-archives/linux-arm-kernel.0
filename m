From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 13 Dec 2009 21:45:25 +0800
Subject: [GIT PULL] pxa: for 2.6.33 - pcmcia fixes + em-x270 usb fix +
	zeus support
In-Reply-To: <20091213132105.GB12645@n2100.arm.linux.org.uk>
References: <f17812d70912130517v3d2ab1dfud8ff67770ba78f46@mail.gmail.com>
	<20091213132105.GB12645@n2100.arm.linux.org.uk>
Message-ID: <f17812d70912130545o183a261dte65466e4ad47fbff@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2009 at 9:21 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Dec 13, 2009 at 09:17:14PM +0800, Eric Miao wrote:
>> Russell,
>>
>> The following changes since commit f40542532e96dda5506eb76badea322f2ae4731c:
>> ? Linus Torvalds (1):
>> ? ? ? ? Merge branch 'ixp4xx' of git://git.kernel.org/.../chris/linux-2.6
>>
>> are available in the git repository at:
>>
>> ? git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel
>>
>> Eric Miao (2):
>> ? ? ? pcmcia: export pxa2xx_drv_pcmcia_{add_one, ops} to other modules
>> ? ? ? pcmcia: fix now incorrect reference of skt->irq by using
>> skt->socket.pci_irq
>
> Please drop these two, I already either have them or a similar fix.
>

Dropped, git pull message refreshed as below. I'd expect some latency
when changes on master.kernel.org hit git.kernel.org.

The following changes since commit f40542532e96dda5506eb76badea322f2ae4731c:
  Linus Torvalds (1):
        Merge branch 'ixp4xx' of git://git.kernel.org/.../chris/linux-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Igor Grinberg (1):
      [ARM] pxa/em-x270: fix usb hub power up/reset sequence

Marc Zyngier (3):
      [ARM] pxa/zeus: basic support for Arcom Zeus SBC
      [ARM] pxa/zeus: make Viper pcmcia support more generic to support Zeus
      [ARM] pxa/zeus: default configuration for Arcom Zeus SBC.

 arch/arm/configs/zeus_defconfig               | 2032 +++++++++++++++++++++++++
 arch/arm/mach-pxa/Kconfig                     |   14 +
 arch/arm/mach-pxa/Makefile                    |    1 +
 arch/arm/mach-pxa/em-x270.c                   |   11 +-
 arch/arm/mach-pxa/include/mach/arcom-pcmcia.h |   11 +
 arch/arm/mach-pxa/include/mach/viper.h        |    2 -
 arch/arm/mach-pxa/include/mach/zeus.h         |   82 +
 arch/arm/mach-pxa/viper.c                     |   20 +-
 arch/arm/mach-pxa/zeus.c                      |  820 ++++++++++
 drivers/pcmcia/Kconfig                        |    2 +-
 drivers/pcmcia/Makefile                       |    2 +-
 drivers/pcmcia/pxa2xx_base.c                  |    3 +-
 drivers/pcmcia/pxa2xx_viper.c                 |  119 ++-
 13 files changed, 3073 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/configs/zeus_defconfig
 create mode 100644 arch/arm/mach-pxa/include/mach/arcom-pcmcia.h
 create mode 100644 arch/arm/mach-pxa/include/mach/zeus.h
 create mode 100644 arch/arm/mach-pxa/zeus.c
