From: stwiss.opensource@diasemi.com (Opensource [Steve Twiss])
Date: Tue, 15 Jul 2014 10:07:57 +0000
Subject: [RFC V1] devicetree: Dialog Semiconductor consolidate existing
 vendor prefixes to standardise on 'dlg'
In-Reply-To: <20140714162101.GM26465@leverpostej>
References: <201407141616.s6EGG7uK022881@swsrvapps-01.diasemi.com>
 <20140714162101.GM26465@leverpostej>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B269FA@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14 July 2014 17:21, Mark Rutland wrote:
>From: Mark Rutland [mailto:mark.rutland at arm.com]
>
>On Mon, Jul 14, 2014 at 05:07:20PM +0100, Opensource [Steve Twiss] wrote:
>> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
>>
>> This patch series updates the device tree vendor prefix for
>> Dialog Semiconductor
>>
>> Various methods are currently used throughout the kernel: 'diasemi',
>> 'dialog' and 'dlg'. Others have also been suggested.
>>
>> This patch set aims to consolidate the usage of the vendor prefix to
>> use a common standard. The prefix 'dlg' is used.
>>
>> This e-mail is in response to the previous thread here:
>>
>> - https://lkml.org/lkml/2014/6/11/262
>
>In that response, Rob pointed out the old forms should be marked
>deprecated, but the patch seems to outright remove them.
>
>Are we sure this doesn't break an existing DTB anywhere?
>
>Thanks,
>Mark.

Hi Mark,

Rob said that the old forms should be marked as deprecated, but I didn't
deprecate any "dialog" or "diasemi" entries in this patch because I have
only made two types of change:

(1) definitions of "diasemi" or "dialog" that have not been used in the kernel;
(2) definitions of "diasemi" or "dialog" that are incompatible with existing driver code.

In both of these cases they cannot affect any working DTB.

Actually -- I will need to resend a V2 to this patch because I did miss out two
files for DA9210 which reference the unused compatible flag "diasemi" and I
might as well fix those while I am doing this change.

I will resend those changes all my "working" in my next patch RFC V2.

Regards,
Steve

>>
>> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
>> ---
>> Checks performed with linux-next/next-20140714/scripts/checkpatch.pl
>>  trivial-devices.txt       total: 0 errors, 0 warnings, 89 lines checked
>>  da9210.txt                total: 0 errors, 0 warnings, 21 lines checked
>>  vendor-prefixes.txt       total: 0 errors, 0 warnings, 149 lines checked
>>  imx53-smd.dts             total: 0 errors, 2 warnings, 279 lines checked
>>  imx6qdl-phytec-pfla02.dtsi total: 0 errors, 2 warnings, 357 lines checked
>>  da9055-core.c             total: 0 errors, 0 warnings, 428 lines checked
>>
>> This patch applies against linux-next and next-20140714
>>
>> Regards,
>> Steve Twiss, Dialog Semiconductor Ltd.
>>
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 +-
>>  .../devicetree/bindings/regulator/da9210.txt       |  4 ++--
>>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>  arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
>>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-
>>  drivers/mfd/da9055-core.c                          | 26 +++++++++++-----------
>>  6 files changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> index 37803eb..a02b8a1 100644
>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> @@ -44,7 +44,7 @@ dallas,ds1775		Tiny Digital Thermometer and
>Thermostat
>>  dallas,ds3232		Extremely Accurate I??C RTC with Integrated Crystal and
>SRAM
>>  dallas,ds4510		CPU Supervisor with Nonvolatile Memory and
>Programmable I/O
>>  dallas,ds75		Digital Thermometer and Thermostat
>> -dialog,da9053		DA9053: flexible system level PMIC with
>multicore support
>> +dlg,da9053		DA9053: flexible system level PMIC with multicore
>support
>>  epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK
>MODULE
>>  epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>>  fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
>> diff --git a/Documentation/devicetree/bindings/regulator/da9210.txt
>b/Documentation/devicetree/bindings/regulator/da9210.txt
>> index f120f22..3297c53 100644
>> --- a/Documentation/devicetree/bindings/regulator/da9210.txt
>> +++ b/Documentation/devicetree/bindings/regulator/da9210.txt
>> @@ -2,7 +2,7 @@
>>
>>  Required properties:
>>
>> -- compatible:	must be "diasemi,da9210"
>> +- compatible:	must be "dlg,da9210"
>>  - reg:		the i2c slave address of the regulator. It should be 0x68.
>>
>>  Any standard regulator properties can be used to configure the single da9210
>> @@ -11,7 +11,7 @@ DCDC.
>>  Example:
>>
>>  	da9210 at 68 {
>> -		compatible = "diasemi,da9210";
>> +		compatible = "dlg,da9210";
>>  		reg = <0x68>;
>>
>>  		regulator-min-microvolt = <900000>;
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 5d27e5a..35a833e 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -37,6 +37,7 @@ dallas	Maxim Integrated Products (formerly Dallas
>Semiconductor)
>>  davicom	DAVICOM Semiconductor, Inc.
>>  denx	Denx Software Engineering
>>  digi	Digi International Inc.
>> +dlg	Dialog Semiconductor
>>  dlink	D-Link Corporation
>>  dmo	Data Modul AG
>>  ebv	EBV Elektronik
>> diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-
>smd.dts
>> index 5ec1590..1d32557 100644
>> --- a/arch/arm/boot/dts/imx53-smd.dts
>> +++ b/arch/arm/boot/dts/imx53-smd.dts
>> @@ -265,7 +265,7 @@
>>  	};
>>
>>  	pmic: dialog at 48 {
>> -		compatible = "dialog,da9053", "dialog,da9052";
>> +		compatible = "dlg,da9053", "dlg,da9052";
>>  		reg = <0x48>;
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> index 2694aa8..0e50bb0 100644
>> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> @@ -83,7 +83,7 @@
>>  	};
>>
>>  	pmic at 58 {
>> -		compatible = "dialog,da9063";
>> +		compatible = "dlg,da9063";
>>  		reg = <0x58>;
>>  		interrupt-parent = <&gpio4>;
>>  		interrupts = <17 0x8>; /* active-low GPIO4_17 */
>> diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
>> index caf8dcf..b4d920c 100644
>> --- a/drivers/mfd/da9055-core.c
>> +++ b/drivers/mfd/da9055-core.c
>> @@ -296,73 +296,73 @@ static struct resource da9055_ld05_6_resource = {
>>
>>  static const struct mfd_cell da9055_devs[] = {
>>  	{
>> -		.of_compatible = "dialog,da9055-gpio",
>> +		.of_compatible = "dlg,da9055-gpio",
>>  		.name = "da9055-gpio",
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.id = 1,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.id = 2,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.id = 3,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.id = 4,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.id = 5,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.id = 6,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.id = 7,
>>  		.resources = &da9055_ld05_6_resource,
>>  		.num_resources = 1,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-regulator",
>> +		.of_compatible = "dlg,da9055-regulator",
>>  		.name = "da9055-regulator",
>>  		.resources = &da9055_ld05_6_resource,
>>  		.num_resources = 1,
>>  		.id = 8,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-onkey",
>> +		.of_compatible = "dlg,da9055-onkey",
>>  		.name = "da9055-onkey",
>>  		.resources = &da9055_onkey_resource,
>>  		.num_resources = 1,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-rtc",
>> +		.of_compatible = "dlg,da9055-rtc",
>>  		.name = "da9055-rtc",
>>  		.resources = da9055_rtc_resource,
>>  		.num_resources = ARRAY_SIZE(da9055_rtc_resource),
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-hwmon",
>> +		.of_compatible = "dlg,da9055-hwmon",
>>  		.name = "da9055-hwmon",
>>  		.resources = &da9055_hwmon_resource,
>>  		.num_resources = 1,
>>  	},
>>  	{
>> -		.of_compatible = "dialog,da9055-watchdog",
>> +		.of_compatible = "dlg,da9055-watchdog",
>>  		.name = "da9055-watchdog",
>>  	},
>>  };
>> --
>> end-of-patch for RFC V1
>>
>>
