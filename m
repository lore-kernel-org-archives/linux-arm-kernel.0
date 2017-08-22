From: icenowy@aosc.io (icenowy at aosc.io)
Date: Tue, 22 Aug 2017 13:14:09 +0800
Subject: [PATCH 2/2] ARM: sunxi: add support for R40 SoC
In-Reply-To: <20170821093405.n4bum7j6nswnv6wr@flea.lan>
References: <20170820052957.34597-1-icenowy@aosc.io>
 <20170820052957.34597-2-icenowy@aosc.io>
 <20170821093405.n4bum7j6nswnv6wr@flea.lan>
Message-ID: <0809ae2d75f210b9bfee49b383f226b2@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-21 17:34?Maxime Ripard ???
> Hi,
> 
> On Sun, Aug 20, 2017 at 01:29:57PM +0800, Icenowy Zheng wrote:
>> Allwinner R40 is a new SoC, with Quad Core Cortex-A7 and peripherals
>> like A20.
>> 
>> Add support for it.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  Documentation/arm/sunxi/README                  | 6 ++++++
>>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>>  3 files changed, 8 insertions(+)
>> 
>> diff --git a/Documentation/arm/sunxi/README 
>> b/Documentation/arm/sunxi/README
>> index d7b1f016bd62..4fa836782e46 100644
>> --- a/Documentation/arm/sunxi/README
>> +++ b/Documentation/arm/sunxi/README
>> @@ -75,6 +75,12 @@ SunXi family
>>          + Datasheet
>>            
>> http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
>> 
>> +      - Allwinner R40 (sun8i)
>> +        + Datasheet
>> +          
>> https://github.com/tinalinux/docs/raw/r40-v1.y/R40_Datasheet_V1.0.pdf
>> +        + User Manual
>> +          
>> https://github.com/tinalinux/docs/raw/r40-v1.y/Allwinner_R40_User_Manual_V1.0.pdf
>> +
> 
> Please sort it by alphabetical order.

I prefer to sort it by the wafer ID (the number after w in the official 
ID).

The current document can be explained to follow the alphabetical order
or the wafer ID.

P.S. there's some error in the V3s datasheet position, and if it's fixed
we can still continue to make the two kinds of order both meaningful ;-)

> 
>>      * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
>>        - Allwinner A80
>>          + Datasheet
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt 
>> b/Documentation/devicetree/bindings/arm/sunxi.txt
>> index f35c6ada5a65..e4beec3d9ad3 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
>> @@ -14,6 +14,7 @@ using one of the following compatible strings:
>>    allwinner,sun8i-a83t
>>    allwinner,sun8i-h2-plus
>>    allwinner,sun8i-h3
>> +  allwinner-sun8i-r40
>>    allwinner,sun8i-v3s
>>    allwinner,sun9i-a80
>>    allwinner,sun50i-a64
>> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
>> index 7ab353fb25f2..311e6c4fc4f4 100644
>> --- a/arch/arm/mach-sunxi/sunxi.c
>> +++ b/arch/arm/mach-sunxi/sunxi.c
>> @@ -66,6 +66,7 @@ static const char * const sun8i_board_dt_compat[] = 
>> {
>>  	"allwinner,sun8i-h2-plus",
>>  	"allwinner,sun8i-h3",
>>  	"allwinner,sun8i-v3s",
>> +	"allwinner,sun8i-r40",
> 
> And same thing here.
> 
> Thanks!
> Maxime
