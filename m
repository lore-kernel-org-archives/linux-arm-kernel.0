From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 10 May 2018 11:51:14 +0100
Subject: [PATCH] ARM: dts: vexpress: Replace '_' with '-' in node names
In-Reply-To: <CAL_Jsq+VNuvbxgFTFVouJF-_yMS90u0fd8jaXnYtKwogOP5rww@mail.gmail.com>
References: <1525884482-19855-1-git-send-email-sudeep.holla@arm.com>
 <CAL_Jsq+VNuvbxgFTFVouJF-_yMS90u0fd8jaXnYtKwogOP5rww@mail.gmail.com>
Message-ID: <f28fb5d6-1070-8cbb-e815-4baf7128b19e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/05/18 22:14, Rob Herring wrote:
> On Wed, May 9, 2018 at 11:48 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> The latest DTC throws warnings for character '_' in the node names.
>>
>> Warning (node_name_chars_strict): /sysreg at 10000/sys_led: Character '_' not recommended in node name
>> Warning (node_name_chars_strict): /sysreg at 10000/sys_mci: Character '_' not recommended in node name
>> Warning (node_name_chars_strict): /sysreg at 10000/sys_flash: Character '_' not recommended in node name
>>
>> The general recommendation is to use character '-' for all the node names.
>> This patch fixes the warnings following the recommendation.
>>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> index 7b8ff5b3b912..58e73131ecef 100644
>> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> @@ -77,19 +77,19 @@
>>                                         compatible = "arm,vexpress-sysreg";
>>                                         reg = <0x010000 0x1000>;
>>
>> -                                       v2m_led_gpios: sys_led {
>> +                                       v2m_led_gpios: sys-led {
> 
> Except this is a gpio-controller so it should have 'gpio' for its node
> name. (I have a dtc check written for that, but there are too many
> false positives.)
> 

True, sorry I didn't look at it in detail.

> But then you have 3 of them and no addressing, so you need to add reg
> property (with the register's offset and size) and unit-address.
> 

Indeed. I had a look at the history but couldn't gather much. All I
could get is that this is one of those weird mix of all functionality on
ARM Ltd platforms which fits no subsystem. Me and Lorenzo has similar
issue on TC2 platform. Pawel seem to have plumed this system control
registers block into MFD and GPIO long back.

> I'm surprised Linus W accepted these a GPIO when they are not really
> general purpose, but then lots of things slip in.
> 

I assume all these happened in early days of DT.

I will drop this for now. I will take a look if these nodes can be made
better to align with standard gpio controller nodes.

-- 
Regards,
Sudeep
