From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 18 Jun 2013 20:11:27 -0500
Subject: [PATCHv3 4/6] arm: dts: add bandgap entry for OMAP4460 devices
In-Reply-To: <51C0C014.2000402@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
 <1370637968-23299-5-git-send-email-eduardo.valentin@ti.com>
 <51C0C014.2000402@ti.com>
Message-ID: <51C1053F.7030607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

On 06/18/2013 03:16 PM, Eduardo Valentin wrote:
> Benoit
>
> On 07-06-2013 16:46, Eduardo Valentin wrote:
>> Include bandgap devices for OMAP4460 devices.
>>
>> Cc: "Beno?t Cousson" <b-cousson@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-omap at vger.kernel.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>
> Could you please have a look on patch 3 and 4 of this series? I have
> changed this one accordingly to your recommendation on v2. If nothing
> else, please let me know if they can still be queued for 3.11.

I've just applied both of them in my tree for 3.11. I'll send the pull 
request to Tony tomorrow.

Regards,
Benoit

>
> I would need to rebase patch 01 to refresh on top of the thermal tree.
>
> Thanks.
>
>>   arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
>> index 2cf227c..ea97201 100644
>> --- a/arch/arm/boot/dts/omap4460.dtsi
>> +++ b/arch/arm/boot/dts/omap4460.dtsi
>> @@ -29,4 +29,13 @@
>>   			     <0 55 0x4>;
>>   		ti,hwmods = "debugss";
>>   	};
>> +
>> +	bandgap {
>> +		reg = <0x4a002260 0x4
>> +			0x4a00232C 0x4
>> +			0x4a002378 0x18>;
>> +		compatible = "ti,omap4460-bandgap";
>> +		interrupts = <0 126 4>; /* talert */
>> +		gpios = <&gpio3 22 0>; /* tshut */
>> +	};
>>   };
>>
>
>
