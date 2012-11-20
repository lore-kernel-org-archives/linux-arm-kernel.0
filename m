From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 20 Nov 2012 08:50:17 +0800
Subject: [PATCH 1/2] ARM: dts: support pinctrl single in aspenite
In-Reply-To: <50AAA773.2090807@wwwdotorg.org>
References: <1353049345-6954-1-git-send-email-haojian.zhuang@gmail.com>
 <50AAA773.2090807@wwwdotorg.org>
Message-ID: <CAN1soZyWJKo+Tg3iArE8t+Ra1cUcizxQqQm3JdbxgGF4GKA0MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 5:41 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/16/2012 12:02 AM, Haojian Zhuang wrote:
>> Support pinctrl-single driver in aspenite DTS file.
>
>> diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
>
>> +                     pmx: pinmux at d401e000 {
>
>> +                             range0: range at d401e04c {
>> +                                     /* GPIO0 ~ GPIO15 */
>> +                                     reg = <0xd401e04c 0x40>;
>> +                                     /* gpio base & gpio func */
>> +                                     pinctrl-single,gpio = <0 5>;
>
> So I see that the "0" here is the first GPIO number, but what is the
> "5"? The comment says GPIO 0..15, but I don't see anywhere that the "16"
> count of GPIOs/pins is defined.
>
GPIO base number & GPIO function mode is followed by pinctrl-single,gpio.
So 0 is GPIO base number, and 5 is GPIO function mode.

GPIO0~GPIO15 is already covered by reg property.

0x40 >>2 = 0x10 (because they're 32-bit registers). So 16 count of GPIOs/pins
are mentioned at here.
