From: rogerq@ti.com (Roger Quadros)
Date: Fri, 20 Sep 2013 12:22:04 +0300
Subject: [RFC PATCH 12/15] ARM: dts: omap5: add ocp2scp1 address resource
In-Reply-To: <523B0782.7050501@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379597019-15294-1-git-send-email-rogerq@ti.com>
 <523B0782.7050501@cogentembedded.com>
Message-ID: <523C13BC.10400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/19/2013 05:17 PM, Sergei Shtylyov wrote:
> On 09/19/2013 05:23 PM, Roger Quadros wrote:
> 
>> Add OCP2SCP1 module address space.
> 
>> CC: Benoit Cousson <bcousson@baylibre.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/boot/dts/omap5.dtsi |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
> 
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 06aa665..8a88a94 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -663,6 +663,7 @@
>>               #size-cells = <1>;
>>               ranges;
>>               ti,hwmods = "ocp2scp1";
>> +            reg = <0x4a080000 0x1f>;
> 
>    Are you sure length is not 0x20?

Actually there are just 4 of 32-bit registers with the last one
starting at 0x18, so I think length should be 0x1c.

I copied 0x1f from omap4.dtsi. Looks like that is wrong as well.
But it is harmless as nobody else is using that address.

I'll fix this to 0x1c in next rev.

cheers,
-roger
