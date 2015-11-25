From: shugelinux@gmail.com (Shuge)
Date: Wed, 25 Nov 2015 09:22:56 +0800
Subject: [linux-sunxi] Re: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
In-Reply-To: <20151124093202.GL32142@lukather>
References: <cover.1448263428.git.atx@atx.name>
 <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather>
 <a7d4e538-db64-476d-b5de-5222419229a2@googlegroups.com>
 <20151124093202.GL32142@lukather>
Message-ID: <56550D70.6060109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 23, 2015 at 17:32 UTC+8, Maxime Ripard wrote:
> On Mon, Nov 23, 2015 at 10:51:15PM -0800, Sugar Wu wrote:
>> On Monday, November 23, 2015 at 8:43:59 PM UTC+8, Maxime Ripard wrote:
>>>
>>> Hi, 
>>>
>>> On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote: 
>>>> Add a node describing the Security ID memory to the 
>>>> Allwinner H3 .dtsi file. 
>>>>
>>>> Signed-off-by: Josef Gajdusek <a...@atx.name <javascript:>> 
>>>> --- 
>>>>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++ 
>>>>  1 file changed, 7 insertions(+) 
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi 
>>> b/arch/arm/boot/dts/sun8i-h3.dtsi 
>>>> index 0faa38a..58de718 100644 
>>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi 
>>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi 
>>>> @@ -359,6 +359,13 @@ 
>>>>                          #size-cells = <0>; 
>>>>                  }; 
>>>>   
>>>> +                sid: eeprom at 01c14000 { 
>>>> +                        compatible = "allwinner,sun4i-a10-sid"; 
>>>> +                        reg = <0x01c14000 0x400>; 
>>>
>>> The datasheet says it's 256 bytes wide, while the size here is of 1kB, 
>>> is it intentional? 
>>
>> SID memory map is 0x01c14000 ~ 0x01c143FF, include 2048bits efuse space.
>> H3 efuse space is SID_SRAM, its range is  0x01c14200 ~ +0x100.
> 
> Interesting, what is below the 0x200 registers?
>
Some control register about SID.
offset: 0x40  SID Program/Read Control Register
offset: 0x50  SID Program Key Value Register
offset: 0x60  SID Read Key Value Register
offset: 0x70  \
offset: 0x80  SJTAG Attribute 0 Register
offset: 0x84  SJTAG Attribute 1 Register
offset: 0x88  SJTAG Select Register
offset: 0x90  SID Program Ctrol register for burned timing

>
> Thanks!
> Maxime
> 
