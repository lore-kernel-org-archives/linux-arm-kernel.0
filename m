From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 20 May 2013 03:08:54 +0000
Subject: [PATCH v3] clocksource: add MVF600 pit timer support
In-Reply-To: <20130520022747.GA25113@S2101-09.ap.freescale.net>
References: <1368684924-1560-1-git-send-email-b35083@freescale.com>
 <20130520022747.GA25113@S2101-09.ap.freescale.net>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CB223@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Monday, May 20, 2013 10:28 AM
>To: Lu Jingchang-B35083
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>john.stultz at linaro.org; tglx at linutronix.de; s.hauer at pengutronix.de
>Subject: Re: [PATCH v3] clocksource: add MVF600 pit timer support
>
>On Thu, May 16, 2013 at 02:15:24PM +0800, Jingchang Lu wrote:
>> Add Freescale Vybrid MVF600 period interrupt timer support.
>>
>> Signed-off-by: Jingchang Lu <b35083@freescale.com>
>> ---
>> v3:
>>   move the pit driver to drivers/clocksource.
>>
>>  drivers/clocksource/Kconfig            |   5 +
>>  drivers/clocksource/Makefile           |   1 +
>>  drivers/clocksource/mvf600_pit_timer.c | 224
>> +++++++++++++++++++++++++++++++++
>
>This is a driver for PIT, a timer IP block found on mvf family.  Even
>though we prefer to use particular SoC name to specify the compatibility
>and version of the block, all the versions of the IP block should be
>ideally supported by single PIT driver.  This is just like we have drivers
>spi-imx and i2c-imx support all SPI and I2C controllers found on IMX SoCs.
>That said, I suggest you use family name "mvf" to name the driver, Kconfig
>symbol etc. and use "mvf600" only in compatible string.
>
[Lu Jingchang-B35083] 
  I am not sure MVF5xx and MVF7xx have the same PIT block, if you have information that it is the same on other Vybrid SoCs, it is ok to change the driver name to mvf. Thanks!
>>  3 files changed, 230 insertions(+)
>> +
>> +	/* choose PIT2 as clocksource, PIT3 as clockevent dev */
>
>Reading the comment, I have a natural question - what PIT0 and PIT1 are
>used for?
>
[Lu Jingchang-B35083] 
PIT0 and PIT1 can be chained to build a 64-bit timer, so PIT2 and PIT3 are selected as the clocksource and clockevent device, and leave PIT0 and PIT1 unused for anyone else who needs them. Thanks!
>
