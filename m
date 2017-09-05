From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 5 Sep 2017 10:03:58 +0200
Subject: [PATCH v4 0/3] arm64: Realtek RTD1295 RTC
In-Reply-To: <20170905075900.wsroxyp6mzdzjclu@piout.net>
References: <20170904225324.29138-1-afaerber@suse.de>
 <20170905075900.wsroxyp6mzdzjclu@piout.net>
Message-ID: <12aac585-64f4-f08b-c5bf-b1f0ac124924@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.09.2017 um 09:59 schrieb Alexandre Belloni:
> On 05/09/2017 at 00:53:21 +0200, Andreas F?rber wrote:
>> Hello,
>>
>> This series adds the RTC for the Realtek RTD1295 SoC.
>> Based on my RTD1295 clk series.
>>
>> There being no public source code for RTD1295, the implementation is based on
>> register offsets seen in the vendor DT, as well as older mach-rtk119x code
>> published by QNAP.
>>
>> v4 adds a missing clk_put().
>>
>> The DT node depends on the clk series for clock index and header.
>>
>> More experimental patches at:
>> https://github.com/afaerber/linux/commits/rtd1295-next
>>
>> Have a lot of fun!
>>
>> Cheers,
>> Andreas
>>
>> v3 -> v4:
>> * Added clk_put() (Alexandre)
>>
>> v2 -> v3:
>> * Dropped spinlock (Andrew)
>> * Improved year_days vs. days_in_year readability
>>
>> v1 -> v2:
>> * Updated rtc driver to no longer use open/release (Alexandre)
>> * Cleaned up debug output (Andrew)
>> * Avoided COMPILE_TEST division errors (kbuild)
>> * Various cleanups and extensions
>>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: linux-rtc at vger.kernel.org
>> Cc: Roc He <hepeng@zidoo.tv>
>> Cc: ??? <jiang.liqin@geniatech.com>
>> Cc: devicetree at vger.kernel.org
>> Cc: Andrew Lunn <andrew@lunn.ch>
>>
>> Andreas F?rber (3):
>>   dt-bindings: rtc: Add Realtek RTD1295
>>   rtc: Add Realtek RTD1295
>>   arm64: dts: realtek: Add RTD1295 RTC node
>>
>>  .../devicetree/bindings/rtc/realtek,rtd119x.txt    |  16 ++
>>  arch/arm64/boot/dts/realtek/rtd1295.dtsi           |   6 +
>>  drivers/rtc/Kconfig                                |   8 +
>>  drivers/rtc/Makefile                               |   1 +
>>  drivers/rtc/rtc-rtd119x.c                          | 242 +++++++++++++++++++++
>>  5 files changed, 273 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
>>  create mode 100644 drivers/rtc/rtc-rtd119x.c
>>
> Applied, thanks.

Err, I am hoping you only queued patches 1-2? Please do not queue patch
3, that needs to go through my tree as per the comments - it will not build.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
