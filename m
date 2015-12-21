From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 21 Dec 2015 11:40:05 +0100
Subject: [linux-sunxi] Re: [PATCH 1/5] ARM: dts: sun4i: Add touchscreen
 node to inet9f-rev03 tablet dts file
In-Reply-To: <CAGb2v67tBGSZTwVk4uQ97tqah3x83xFEPJn=rM-dBV9xgyFMAw@mail.gmail.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v67tBGSZTwVk4uQ97tqah3x83xFEPJn=rM-dBV9xgyFMAw@mail.gmail.com>
Message-ID: <5677D705.4070206@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-12-15 06:57, Chen-Yu Tsai wrote:
> On Sun, Dec 20, 2015 at 7:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Add a node describing the focaltech ft5406ee8 touchscreen found on
>> inet-9f-rev03 / qware qw tb-g100 tablets.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
>> index ca49b0d..d39067e 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
>> @@ -253,6 +253,16 @@
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&i2c2_pins_a>;
>>          status = "okay";
>> +
>> +       ft5406ee8: touchscreen at 38 {
>> +               compatible = "edt,edt-ft5406";
>> +               reg = <0x38>;
>> +               interrupt-parent = <&pio>;
>> +               interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
>> +               pinctrl-names = "default";
>
> Name only and no references?

My bad (and even copy and pasted it to the 2 others), this line needs
to be dropped. I'll send a v2.

Regards,

Hans
