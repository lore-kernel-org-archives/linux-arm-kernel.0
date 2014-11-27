From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 27 Nov 2014 08:56:16 +0800
Subject: [PATCH v9 4/4] ARM: dts: rockchip: add suspend settings for
 rk3288-evb-rk808
In-Reply-To: <CAD=FV=V29zCpcEHE+rq6q_6SOZ_NOJgc5FiwmJ9jnRZK4mMUhw@mail.gmail.com>
References: <1416900743-29204-1-git-send-email-zyw@rock-chips.com>	<1416900743-29204-5-git-send-email-zyw@rock-chips.com>
 <CAD=FV=V29zCpcEHE+rq6q_6SOZ_NOJgc5FiwmJ9jnRZK4mMUhw@mail.gmail.com>
Message-ID: <547676B0.9030001@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/27/2014 06:52 AM, Doug Anderson wrote:
> Chris,
>
> On Mon, Nov 24, 2014 at 11:32 PM, Chris Zhong <zyw@rock-chips.com> wrote:
>>                          vcc_ddr: DCDC_REG3 {
>>                                  regulator-always-on;
>>                                  regulator-boot-on;
>>                                  regulator-name = "vcc_ddr";
>> +                               regulator-suspend-mem-enabled;
> The "regulator-suspend-mem-enabled" is not an upstream property and
> isn't doing anything.  It should be removed.
>
> Possibly this is something Heiko could do when applying  (depends on
> what he wants) if no other spins are required.
>>                          vcc_18: LDO_REG7 {
>> @@ -128,6 +163,11 @@
>>                                  regulator-min-microvolt = <1800000>;
>>                                  regulator-max-microvolt = <1800000>;
>>                                  regulator-name = "vcc_18";
>> +                               regulator-suspend-mem-microvolt = <1800000>;
> Another non-upstream property: regulator-suspend-mem-microvolt
Ah, missed these two. I should remove all the regulator-suspend-mem-*, 
they are from Gerrit.
Thank you.
>
>
>
