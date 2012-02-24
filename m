From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 24 Feb 2012 12:23:05 +0100
Subject: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and board
 data
In-Reply-To: <4F470B71.1020308@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
 <1329998490-27555-5-git-send-email-rnayak@ti.com>
 <20120223185718.GZ18185@atomide.com> <4F470B71.1020308@ti.com>
Message-ID: <4F477319.7080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/24/2012 5:00 AM, Rajendra Nayak wrote:
> On Friday 24 February 2012 12:27 AM, Tony Lindgren wrote:
>>> --- a/arch/arm/boot/dts/omap3.dtsi
>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>> @@ -113,5 +113,31 @@
>>> #size-cells =<0>;
>>> ti,hwmods = "i2c3";
>>> };
>>> +
>>> + mmc1: mmc at 1 {
>>> + compatible = "ti,omap2-hsmmc";
>>> + ti,hwmods = "mmc1";
>>> + ti,dual-volt;
>>> + };
>>> +
>>> + mmc2: mmc at 2 {
>>> + compatible = "ti,omap2-hsmmc";
>>> + ti,hwmods = "mmc2";
>>> + };
>>> +
>>> + mmc3: mmc at 3 {
>>> + compatible = "ti,omap2-hsmmc";
>>> + ti,hwmods = "mmc3";
>>> + };
>>> +
>>> + mmc4: mmc at 4 {
>>> + compatible = "ti,omap2-hsmmc";
>>> + ti,hwmods = "mmc4";
>>> + };
>>> +
>>> + mmc5: mmc at 5 {
>>> + compatible = "ti,omap2-hsmmc";
>>> + ti,hwmods = "mmc5";
>>> + };
>>> };
>>> };
>>
>> These all should all be "ti,omap3-hsmmc" I guess?
>
> Well, I defined the binding such that both omap2 and omap3
> can use the same compatible "ti,omap2-hsmmc" since there is
> no difference in the way they are defined or handled. If thats
> confusing, I can have separate compatibles.
> Btw, I guess we do the same with a few other re-used IPs as well,
> I just checked and mcpsi does the same.

Yes, the goal is mainly to identify the IP version, so since OMAP3 is 
using OMAP2 IP, I do not think there is a need to add a new compatible 
string for OMAP3. The should only be documented in the binding potentially.
The advantage is that that will avoid adding an extra compatible string 
in the driver as well whereas there is no change in the IP.

Regards,
Benoit
