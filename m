From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 May 2018 10:02:13 +0200
Subject: [PATCH] ARM: dts: vexpress: Replace '_' with '-' in node names
In-Reply-To: <CAL_Jsq+VNuvbxgFTFVouJF-_yMS90u0fd8jaXnYtKwogOP5rww@mail.gmail.com>
References: <1525884482-19855-1-git-send-email-sudeep.holla@arm.com>
 <CAL_Jsq+VNuvbxgFTFVouJF-_yMS90u0fd8jaXnYtKwogOP5rww@mail.gmail.com>
Message-ID: <CACRpkdYSwLKEchYSOMAUaN_pXBz9VNSf=LX+84Z+mEMozL01Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2018 at 11:14 PM, Rob Herring <robh+dt@kernel.org> wrote:
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
> But then you have 3 of them and no addressing, so you need to add reg
> property (with the register's offset and size) and unit-address.
>
> I'm surprised Linus W accepted these a GPIO when they are not really
> general purpose, but then lots of things slip in.

I guess is was back in this day when we had a finger constantly
on the fastforward button for DT conversion, and a few not so
elegant things slipped in.

I was annoyed by this thing later, especially since others started
to use it as a consistency argument "well you allowed this so
now allow this other crazy thing that looks the same" :D

I suspect I either was not CC:ed or I just sucked at shepherding
this, I try to do better these days.

Yours,
Linus Walleij
