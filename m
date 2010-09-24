From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 24 Sep 2010 10:12:47 -0600
Subject: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
In-Reply-To: <20100924091120.GA25312@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<20100902082759.GE14214@pengutronix.de> <4C7F777E.1090104@gmail.com>
	<20100902143908.GK14214@pengutronix.de>
	<20100917095247.GB30441@pengutronix.de>
	<AANLkTi=mMGe10rDhA6g0OZYXhSW3=M07PKr6yN8VwnnJ@mail.gmail.com>
	<20100924091120.GA25312@pengutronix.de>
Message-ID: <AANLkTimKGjz0=3KGhH-Oek9=k6OQ=738Ydcwn7D-RpdB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Grant,
>
> On Fri, Sep 24, 2010 at 01:00:14AM -0600, Grant Likely wrote:
>> > Jason Wang (4):
>> > ? ? ?ARM: mx5/clock-mx51: add spi clocks
>> > ? ? ?ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2 on the imx51_3ds board
>> > ? ? ?ARM: mx5/mx51_3ds: add eCSPI2 support on the imx51_3ds board
>> > ? ? ?ARM: mx5/mx51_3ds: add SPI NOR flash in the board init stage
>> >
>> > Uwe Kleine-K?nig (12):
>> > ? ? ?spi/imx: default to m on platforms that have such devices
>> > ? ? ?spi/imx: convert driver to use platform ids
>> > ? ? ?spi/imx: get rid of more ifs depending on the used cpu
>> > ? ? ?spi/imx: save the spi chip select in config struct, not the gpio to use
>> > ? ? ?spi/imx: add support for imx51's eCSPI and CSPI
>> > ? ? ?ARM: imx: change the way spi-imx devices are registered
>> > ? ? ?ARM: imx: use platform ids for spi_imx devices
>> > ? ? ?ARM: mx51: clean up mx51 header
>> > ? ? ?ARM: mx51: fix naming of spi related defines
>> > ? ? ?ARM: mx5: add spi_imx device registration
>> > ? ? ?ARM: mx5/clock-mx51: refactor ccgr callbacks to use common code
>> > ? ? ?ARM: mx5/clock-mx51: new macro that defines a clk with all members
>> >
>> > ?arch/arm/mach-imx/clock-imx1.c ? ? ? ? ? ? ? ? ?| ? ?2 +-
>> > ?arch/arm/mach-imx/clock-imx21.c ? ? ? ? ? ? ? ? | ? ?6 +-
>> > ?arch/arm/mach-imx/clock-imx27.c ? ? ? ? ? ? ? ? | ? ?6 +-
>> > ?arch/arm/mach-imx/devices-imx21.h ? ? ? ? ? ? ? | ? ?9 +-
>> > ?arch/arm/mach-imx/devices-imx27.h ? ? ? ? ? ? ? | ? 12 +-
>> > ?arch/arm/mach-mx25/clock.c ? ? ? ? ? ? ? ? ? ? ?| ? ?6 +-
>> > ?arch/arm/mach-mx25/devices-imx25.h ? ? ? ? ? ? ?| ? 12 +-
>> > ?arch/arm/mach-mx3/clock-imx31.c ? ? ? ? ? ? ? ? | ? ?6 +-
>> > ?arch/arm/mach-mx3/clock-imx35.c ? ? ? ? ? ? ? ? | ? ?4 +-
>> > ?arch/arm/mach-mx3/devices-imx31.h ? ? ? ? ? ? ? | ? 12 +-
>> > ?arch/arm/mach-mx3/devices-imx35.h ? ? ? ? ? ? ? | ? ?9 +-
>> > ?arch/arm/mach-mx5/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> > ?arch/arm/mach-mx5/board-mx51_3ds.c ? ? ? ? ? ? ?| ? 33 ++
>> > ?arch/arm/mach-mx5/clock-mx51.c ? ? ? ? ? ? ? ? ?| ?113 ++++-
>> > ?arch/arm/mach-mx5/devices-imx51.h ? ? ? ? ? ? ? | ? 18 +
>> > ?arch/arm/plat-mxc/devices/platform-spi_imx.c ? ?| ? 89 +++-
>> > ?arch/arm/plat-mxc/include/mach/devices-common.h | ? 11 +-
>> > ?arch/arm/plat-mxc/include/mach/iomux-mx51.h ? ? | ? ?5 +
>> > ?arch/arm/plat-mxc/include/mach/mx51.h ? ? ? ? ? | ?608 +++++++++++------------
>> > ?drivers/spi/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 16 +
>> > ?drivers/spi/spi_imx.c ? ? ? ? ? ? ? ? ? ? ? ? ? | ?394 ++++++++++++---
>> > ?21 files changed, 919 insertions(+), 453 deletions(-)
>> > ?create mode 100644 arch/arm/mach-mx5/devices-imx51.h
>>
>> I'm fine with this series.
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> What tree do you want to merge them through?
> I thought that the five patches touching drivers/spi should go via your
> tree, the others via Sascha's. ?Assuming this is OK for you, too, do you
> prefer to pick the patches out here or should I prepare a branch with
> these patches for you to pull?

You can just add my acked-by and take the whole series via Sascha.  No
sense breaking them up.

g.
