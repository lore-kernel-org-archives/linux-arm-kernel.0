From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 27 Feb 2012 18:01:20 +0530
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
In-Reply-To: <4F4B73C8.8070807@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com>
Message-ID: <4F4B7798.6000300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 February 2012 05:45 PM, Peter Ujfalusi wrote:
> Hi Rajendra,
>
>
> On 02/27/2012 12:35 PM, Rajendra Nayak wrote:
>> Re-sending on top of Tero's changes which are already
>> in -next and the one which adds support for twl6030
>> vdd1/2/3 SMPS [1].
>
> Would you be able to add support for V1V8, V2V1 SMPS supplies in
> twl6030? These regulators are need on SDP4430, and PandaBoards for the
> twl6040 audio codec.
> I have sent a series to add this support:
> http://marc.info/?l=linux-omap&m=132886849202915&w=2

Sure, seems quite straight forward to add DT support for those
too. I just based my patches on top of whats already in -next and
some changes from Tero. Did not notice there are more patches floating
around touching twl-regulator :)
Depending on what order Mark happens to pull them in, I am fine
re-sending adding support for the 2 twl6030 fixed regulators.

>
> Thanks,
> P?ter
>
>
>> v3 has mainly 2 differences from v2
>> -1- TWL driver now uses just one table for both dt and
>> non-dt based lookup for driver data.
>> -2- All common regulator nodes for twl4030 and twl6030 are
>> now defined in the twl4030.dtsi and twl6030.dtsi instead of
>> repeating the nodes in all board files, which also means
>> the patch ('arm/dts: twl: Pass regulator data from dt')
>> has a dependency with the series from Benoit which adds the
>> twl4030.dtsi and twl6030.dtsi files[2].
>>
>> I have tested the patches on omap4panda and omap3beagle boards.
>>
>> [1] http://marc.info/?l=linux-omap&m=133009693905864&w=2
>> [2] git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
>> 	for_3.4/dt_i2c_twl
>>
>> Rajendra Nayak (2):
>>    regulator: twl: adapt twl-regulator driver to dt
>>    arm/dts: twl: Pass regulator data from dt
>>
>>   .../bindings/regulator/twl-regulator.txt           |   66 +++++
>>   arch/arm/boot/dts/omap3-beagle.dts                 |    6 +
>>   arch/arm/boot/dts/twl4030.dtsi                     |   18 ++
>>   arch/arm/boot/dts/twl6030.dtsi                     |   60 +++++
>>   drivers/regulator/twl-regulator.c                  |  259 +++++++++++++-------
>>   5 files changed, 322 insertions(+), 87 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
