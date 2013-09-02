From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 02 Sep 2013 18:05:10 +0400
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <1643070.uIkONXsrBj@avalon>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
 <201309010315.49763.sergei.shtylyov@cogentembedded.com>
 <1643070.uIkONXsrBj@avalon>
Message-ID: <52249B16.8010409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 05:14 PM, Laurent Pinchart wrote:

>> Define the generic R8A777x part of the Ether device node.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/boot/dts/r8a7778.dtsi |   11 +++++++++++
>>   1 file changed, 11 insertions(+)

>> Index: renesas/arch/arm/boot/dts/r8a7778.dtsi
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7778.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7778.dtsi
>> @@ -98,4 +98,15 @@
>>   		reg = <0xfffc000 0x118>;
>>   		#gpio-range-cells = <3>;
>>   	};
>> +
>> +	ether: ethernet at fde00000 {
>> +		device_type = "network";

> Documentation/devicetree/bindings/net/sh_eth.txt from "[PATCH 2/2] sh_eth: add
> device tree support" doesn't document this property, should you update it ?

    It's a standard property but completely optional for non-OF systems. I've 
not seen anybody document it but I should grep for it...

WBR, Sergei
