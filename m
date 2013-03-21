From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 21 Mar 2013 23:30:15 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <201303212131.07629.arnd@arndb.de>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <201303211903.52383.arnd@arndb.de> <20130321201807.7cb04978@skate>
 <201303212131.07629.arnd@arndb.de>
Message-ID: <514B89F7.3000408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 10:31 PM, Arnd Bergmann wrote:
> On Thursday 21 March 2013, Thomas Petazzoni wrote:
>> In the mean time can we do something like:
>>
>>          soc {
>>                  compatible = "simple-bus";
>>                  range =<...>;
>>
>>                  [... all the peripherals ...]
>>          };
>>
>> with the range =<...>  property converting the peripheral registers
>> base address (expressed as offsets in the reg =<...>  properties of the
>> subnodes) into the absolute physical address?
>
> Yes, that is what Rob suggested you do.

Thomas,

have a look at arch/arm/boot/dts/dove.dtsi, it uses ranges-property
and peripherals encoded as offsets.

Sebastian
