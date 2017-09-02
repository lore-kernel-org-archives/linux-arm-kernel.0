From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 1 Sep 2017 19:10:24 -0700
Subject: [PATCH 1/2] ARM: dts: Add the CLCD controller to Cygnus.
In-Reply-To: <3a947d06-53cc-bb28-86de-0ddb5c6b853c@broadcom.com>
References: <20170831185416.8181-1-eric@anholt.net>
 <3a947d06-53cc-bb28-86de-0ddb5c6b853c@broadcom.com>
Message-ID: <2e66788a-228a-b32d-eb31-24fab776ee21@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/31/2017 01:16 PM, Scott Branden wrote:
> Hi Eric,
> 
> mode is correct, location in file needs to be moved.
> 
> 
> On 17-08-31 11:54 AM, Eric Anholt wrote:
>> This doesn't yet enable it on any particular platform, as we still
>> need a panel driver for bcm911360_entphn.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> These bits are just carving off a little bit of my 911360_entphn panel
>> series, to reduce conflicts when rebasing (which I just did for
>> testing pl111 changes for cygnus regressions).  I'm waiting to get my
>> current RPi panel driver in before working on the 911360 panel again.
>>
>>   arch/arm/boot/dts/bcm-cygnus.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index 7c957ea06c66..74f73ff24aec 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -575,6 +575,16 @@
>>               status = "disabled";
>>           };
>>   +        clcd: clcd at 180a0000 {
> please place in correct address ordered location in file

I moved it right above the v3d node to keep the nodes ordered by unit
address, please check the result here:

https://github.com/Broadcom/stblinux/commit/4d1e42c6b9d28ce7b74d92258435f9d16834ae75

>> +            compatible = "arm,pl111", "arm,primecell";
>> +            reg = <0x180a0000 0x1000>;
>> +            interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "combined";
>> +            clocks = <&axi41_clk>, <&apb_clk>;
>> +            clock-names = "clcdclk", "apb_pclk";
>> +            status = "disabled";
>> +        };
>> +
>>           keypad: keypad at 180ac000 {
>>               compatible = "brcm,bcm-keypad";
>>               reg = <0x180ac000 0x14c>;
> 

-- 
Florian
