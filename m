From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 13 Jan 2015 13:32:41 +0100
Subject: [PATCH 1/2] ARM: dts: sun8i: Add lradc node to sun8i-a23.dtsi
In-Reply-To: <54B50B69.6000002@cogentembedded.com>
References: <1421146024-17957-1-git-send-email-hdegoede@redhat.com>
 <54B50B69.6000002@cogentembedded.com>
Message-ID: <54B51069.3000506@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13-01-15 13:11, Sergei Shtylyov wrote:
> Hello.
>
> On 1/13/2015 1:47 PM, Hans de Goede wrote:
>
>> The A23 has the same lradc controller as previous Allwinner SoCs.
>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun8i-a23.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>
>> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
>> index a31842d..c2ceafb 100644
>> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
>> @@ -419,6 +419,13 @@
>>               interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>>           };
>>
>> +        lradc: lradc at 01c22800 {
>> +            compatible = "allwinner,sun4i-a10-lradc-keys";
>
>     If this is a keyboard controller, its node name should probably be "keyboard", according to the ePAPR standard...

I'm not sure this qualifies as a keyboard controller, more over we
already have the same name in all other sun?i-a*.dtsi files, so if
we fix this it should be fixed by a follow up patch, and be fixed
everywhere.

Regards,

Hans
