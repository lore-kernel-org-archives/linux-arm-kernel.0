From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Nov 2015 09:11:20 +0100
Subject: [linux-sunxi] [PATCH 5/5] ARM: dts: sun8i-h3-orangepi-plus:
 Enable USB host controllers
In-Reply-To: <CAGb2v669Cu6+G=P8yH-g5KbOsWTHBgnYUYf2fGt+jKXbqVAKfQ@mail.gmail.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
 <1447616777-24660-5-git-send-email-hdegoede@redhat.com>
 <CAGb2v669Cu6+G=P8yH-g5KbOsWTHBgnYUYf2fGt+jKXbqVAKfQ@mail.gmail.com>
Message-ID: <56498FA8.3050908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-11-15 04:00, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Nov 16, 2015 at 3:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> From: Reinder de Haan <patchesrdh@mveas.com>
>>
>> Enable the 3 pairs of USB host controllers used on the Orange Pi Plus.
>>
>> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
>> index e67df59..e05a409 100644
>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
>> @@ -60,6 +60,18 @@
>>          };
>>   };
>>
>> +&ehci1 {
>> +       status = "okay";
>> +};
>> +
>> +&ehci2 {
>> +       status = "okay";
>> +};
>> +
>> +&ehci3 {
>> +       status = "okay";
>> +};
>> +
>>   &mmc0 {
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>> @@ -70,8 +82,24 @@
>>          status = "okay";
>>   };
>>
>> +&ohci1 {
>> +       status = "okay";
>> +};
>
> This controller is connected to a FE1.1s USB 2.0 hub, giving us the
> four usable external USB ports. We shouldn't need to enable OHCI.

Right, my bad, I actually tested this on an orangepi pc, for which
we need to create a new dts of course, the orangepi pc does have
all 3 controllers routed directly to the outside.

>> +
>> +&ohci2 {
>> +       status = "okay";
>> +};
>
> According to the schematics, this port is never used. Please remove.

The same goes for ehci2 then, otherwise ack.

>
>> +&ohci3 {
>> +       status = "okay";
>> +};
>
> This is connected to the GL830 USB-SATA bridge. Again, OHCI isn't
> needed.

My bad again.

>> +
>>   &uart0 {
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&uart0_pins_a>;
>>          status = "okay";
>>   };
>> +
>> +&usbphy {
>> +       status = "okay";
>
> And what about power supplies / regulators?

On the orangepi pc none are needed. Jens can you test this
series (or my sunxi-wip kernel branch) on your orangepi plus ?

and send an updated version of this patch with the necessary changes?

I do not actually have an orangepi plus.

Regards,

Hans
