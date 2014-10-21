From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 21 Oct 2014 12:00:18 +0200
Subject: [PATCH 2/2] ARM: dts: exynos4412-trats: Add suspend configuration
 for max77686 regulators
In-Reply-To: <1413883424.26980.7.camel@AMDC1943>
References: <1413879912-26606-1-git-send-email-k.kozlowski@samsung.com>
 <1413879912-26606-3-git-send-email-k.kozlowski@samsung.com>
 <54461FC0.9020904@samsung.com> <1413883424.26980.7.camel@AMDC1943>
Message-ID: <54462EB2.2070302@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/21/2014 11:23 AM, Krzysztof Kozlowski wrote:
>> >  
>> >  				ldo9_reg: ldo9 {
>> > @@ -295,7 +311,9 @@
>> >  					regulator-name = "CAM_ISP_MIPI_1.2V";
>> >  					regulator-min-microvolt = <1200000>;
>> >  					regulator-max-microvolt = <1200000>;
>> > -					regulator-mem-idle;
>> > +					regulator-state-mem {
>> > +						regulator-on-in-suspend;
>> 
>> CAM_ISP_MIPI_1.2V is used for camera, I think this regulator should turn off in suspend state
>> because camear could not be used in suspend state.
> 
> LDO9 does not support off in suspend mode controlled by PWRREQ. It
> supports only switching to low power mode if PWRREQ level goes low.
> 
> Thus the driver does not provide set_suspend_enable or
> set_suspend_disable for LDO0. Do you want to add such function to the
> max77686 driver which will explicitly disable the regulator (write 0x0
> to control reg)?
> 
> 

I think for those regulators you can just use regulator_disable_regmap()
as the .set_suspend_disable function handler?

Best regards,
Javier
