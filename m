From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 27 May 2014 18:30:41 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: split SolidRun CuBox into variants
In-Reply-To: <20140527161143.GS8664@titan.lakedaemon.net>
References: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1401140009-31505-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140527161143.GS8664@titan.lakedaemon.net>
Message-ID: <5384BDB1.6000107@gmail.com>
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
>> diff --git a/arch/arm/boot/dts/dove-cubox-1g.dts b/arch/arm/boot/dts/dove-cubox-1g.dts
>> new file mode 100644
>> index 000000000000..eebd3f7ca7e6
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dove-cubox-1g.dts
>> @@ -0,0 +1,17 @@
>> +/dts-v1/;
>> +
>> +#include "dove-cubox.dtsi"
>> +
>> +/ {
>> +	model = "SolidRun CuBox (1G)";
>> +	compatible = "solidrun,cubox-1g", "solidrun,cubox", "marvell,dove";
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x40000000>;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
>> +	};
>> +};
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

No, there is no known difference between 1G and 2G except doubled RAM.
I'll squash the two back into a single non-ES dts.

About the board specific compatibles, I am not so sure if we should
keep them at all. "solidrun,cubox" for all three variants should be
enough. checkpatch is already choking on every unknown compatible it
sees and documenting each individual board clearly doesn't scale well.

>> +	};
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/dove-cubox-es.dts b/arch/arm/boot/dts/dove-cubox-es.dts
>> new file mode 100644
>> index 000000000000..5fc17ce34c98
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dove-cubox-es.dts
>> @@ -0,0 +1,23 @@
>> +/dts-v1/;
>> +
>> +#include "dove-cubox.dtsi"
>> +
>> +/ {
>> +	model = "SolidRun CuBox (ES)";
>
> "Engineering Sample" ?

Hmm, I guess those who have it know about ES=="Engineering Sample" but
as I have to do a v2 anyway, I'll fix it up.

Thanks!

Sebastian
