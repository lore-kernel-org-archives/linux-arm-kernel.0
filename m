From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 27 May 2014 19:28:09 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: split SolidRun CuBox into variants
In-Reply-To: <20140527161143.GS8664@titan.lakedaemon.net>
References: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1401140009-31505-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140527161143.GS8664@titan.lakedaemon.net>
Message-ID: <5384CB29.1090204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2014 06:11 PM, Jason Cooper wrote:
> On Mon, May 26, 2014 at 11:33:29PM +0200, Sebastian Hesselbarth wrote:
>> As Mainlining effort for SolidRun CuBox has been carried out on the
>> Engineering Sample, the board DTS was reflecting this. Actually,
>> SolidRun CuBox comes in three different variants: Engineering Sample (ES),
>> production with 1GB RAM (1G), and production with 2GB RAM (2G).
>>
>> Therefore, we split the current dove-cubox.dts into a common board include
>> and one board dts for each of the above variants.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
[...]
>> ---
>>  arch/arm/boot/dts/Makefile                         |  4 +++-
>>  arch/arm/boot/dts/dove-cubox-1g.dts                | 17 ++++++++++++++++
>>  arch/arm/boot/dts/dove-cubox-2g.dts                | 17 ++++++++++++++++
>>  arch/arm/boot/dts/dove-cubox-es.dts                | 23 ++++++++++++++++++++++
>>  .../boot/dts/{dove-cubox.dts => dove-cubox.dtsi}   | 17 ----------------
>>  5 files changed, 60 insertions(+), 18 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/dove-cubox-1g.dts
>>  create mode 100644 arch/arm/boot/dts/dove-cubox-2g.dts
>>  create mode 100644 arch/arm/boot/dts/dove-cubox-es.dts
>>  rename arch/arm/boot/dts/{dove-cubox.dts => dove-cubox.dtsi} (86%)
>>
[...]
>> diff --git a/arch/arm/boot/dts/dove-cubox-2g.dts b/arch/arm/boot/dts/dove-cubox-2g.dts
>> new file mode 100644
>> index 000000000000..513b6a68eba3
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dove-cubox-2g.dts
>> @@ -0,0 +1,17 @@
>> +/dts-v1/;
>> +
>> +#include "dove-cubox.dtsi"
>> +
>> +/ {
>> +	model = "SolidRun CuBox (2G)";
>> +	compatible = "solidrun,cubox-2g", "solidrun,cubox", "marvell,dove";
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x80000000>;
> 
> Do you anticipate any other differences between the 1G and the 2G?
> Otherwise, I'm inclined to just have a "solidrun,cubox".  The bootloader
> should be setting the amount of RAM at boottime anyway.

Given the minor differences between ES and production, instead of

dove-cubox-common.dtsi
+--> dove-cubox.dts (production)
+--> dove-cubos-es.dts (engineering sample)

we could also just have an "overlay" for the ES like

dove-cubox.dts (production)
+--> dove-cubox-es.dts (engineering sample)

It is not used commonly until now, maybe just a matter of taste.

Is there any version you prefer?

Sebastian
