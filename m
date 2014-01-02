From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 02 Jan 2014 10:37:21 +0100
Subject: [linux-sunxi] Re: [PATCH 3/4] ARM: dts: sun5i: Add lradc node
In-Reply-To: <20140101194532.GQ32537@lunn.ch>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <1388604610-20380-4-git-send-email-hdegoede@redhat.com>
 <20140101194532.GQ32537@lunn.ch>
Message-ID: <52C53351.7070501@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/01/2014 08:45 PM, Andrew Lunn wrote:
> On Wed, Jan 01, 2014 at 08:30:09PM +0100, Hans de Goede wrote:
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
>>   arch/arm/boot/dts/sun5i-a10s.dtsi                | 7 +++++++
>>   arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 7 +++++++
>>   arch/arm/boot/dts/sun5i-a13.dtsi                 | 7 +++++++
>>   4 files changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
>> index e53fb12..c32162e 100644
>> --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
>> +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
>> @@ -75,6 +75,13 @@
>>   			};
>>   		};
>>
>> +		lradc: lradc at 01c22800 {
>> +			allwinner,chan0-step = <200>;
>> +			/* KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME */
>> +			allwinner,chan0-keycodes = <115 114 139 28 102>;
>
> Hi Hans
>
> You might want to consider using arch/arm/boot/dts/include/dt-bindings/input/input.h
>
> and then you could have the node:
>
>> +		lradc: lradc at 01c22800 {
>> +			allwinner,chan0-step = <200>;
>> +			allwinner,chan0-keycodes = <KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME>;
>
> which is much more readable.

Ah, I did not know about that include. Good tip, will fix this in v2.

Regards,

Hans
