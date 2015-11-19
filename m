From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Nov 2015 16:07:51 -0800
Subject: [PATCH 3/3] ARM64: dts: enable clock support for Broadcom NS2
In-Reply-To: <564D11C0.409@broadcom.com>
References: <1447888430-4451-1-git-send-email-jonmason@broadcom.com>
 <1447888430-4451-4-git-send-email-jonmason@broadcom.com>
 <564D11C0.409@broadcom.com>
Message-ID: <564D12D7.7090407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/15 16:03, Ray Jui wrote:
> 
> 
> On 11/18/2015 3:13 PM, Jon Mason wrote:
>> Add device tree entries for clock support for Broadcom Northstar 2 SoC
>>
>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
>> ---
>>   arch/arm64/boot/dts/broadcom/ns2.dtsi | 80
>> ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 79 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> index 9610822..a510d3a 100644
>> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> @@ -31,6 +31,7 @@
>>    */
>>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/bcm-ns2.h>
>>
>>   /memreserve/ 0x84b00000 0x00000008;
>>
>> @@ -109,6 +110,33 @@
>>                        <&A57_3>;
>>       };
>>
>> +    clocks {
> 
> Is this a new convention? That is, group all clocks without a base
> register address in a node named "clocks", but at the same time, put all
> other clocks with base register address under a bus node.

I do not think that is new, lots of platforms do that. The clock
providers/controllers would typically be in the 'bus' nodes because it
has a register interface, while the synthetic clocks would be under
'clocks'.
-- 
Florian
