From: woogyom.kim@gmail.com (Milo Kim)
Date: Thu, 1 Sep 2016 22:06:12 +0900
Subject: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
In-Reply-To: <20160831162002.GI14379@lukather>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-2-woogyom.kim@gmail.com>
 <20160831162002.GI14379@lukather>
Message-ID: <998fe271-138b-ea4a-99ac-4cd75eefc9c4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2016 01:20 AM, Maxime Ripard wrote:
> Hi Milo,
>
> On Wed, Aug 31, 2016 at 05:25:17PM +0900, Milo Kim wrote:
>> H3 PA5 pin is assigned for single PWM channel.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index fdf9fdb..05d0c4b 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -360,6 +360,13 @@
>>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>  			};
>>
>> +			pwm0_pin_a: pwm0 at 0 {
>> +				allwinner,pins = "PA5";
>> +				allwinner,function = "pwm0";
>> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +			};
>> +
>
> Is it used on any boards?
>
> If not, we have the policy of not merging the pinctrl nodes that are
> not used by anyone to avoid bloating the DT for no particular reason.

Yes, I have. It's Nano Pi M1 which was derived from Orange Pi PC.
The board DTS is ready to be sent out, but I'm not sure which is better.

	a) Send new board DTS file in other patch thread

	[PATCH v3 0/4] Add PWM feature in Allwinner H3
	[PATCH v3 1/4] ARM: dts: sun8i: Add PWM pin in H3
	..
	[PATCH v3 4/4] pwm: sunxi: Add H3 support

	[PATCH] ARM: dts: sun8i: Add Nano Pi M1 support

Or

	b) Include the DTS in next patch-set v3
	[PATCH v3 0/4] Add PWM feature in Allwinner H3
	[PATCH v3 1/4] ARM: dts: sun8i: Add PWM pin in H3
	[PATCH v3 2/4] ARM: dts: sun8i: Add PWM controller node in H3
	[PATCH v3 3/4] ARM: dts: sun8i: Add Nano Pi M1 support
	...

I'd like to have your opinion.

Best regards,
Milo
