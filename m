From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 11:14:00 -0400
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: dts: sun5i: Add backlight node
 to sun5i-q8-common.dtsi
In-Reply-To: <CAGb2v66Bg60p8T3dzF6ymo-rTEMK4yUVZsuaOjCXapPBQRn6eg@mail.gmail.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
 <1442752251-20744-6-git-send-email-hdegoede@redhat.com>
 <CAGb2v66Bg60p8T3dzF6ymo-rTEMK4yUVZsuaOjCXapPBQRn6eg@mail.gmail.com>
Message-ID: <55FECD38.9010503@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/20/2015 10:46 AM, Chen-Yu Tsai wrote:
> On Sun, Sep 20, 2015 at 8:30 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> All A13 based q8 formfactor tablets use the same backlight setup, add
>> a backlight devicetree node for controlling the backlight on these devices.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/sun5i-q8-common.dtsi | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
>> index 0641d68..76a5204 100644
>> --- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
>> +++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
>> @@ -41,11 +41,22 @@
>>    */
>>   #include "sunxi-q8-common.dtsi"
>>
>> +#include <dt-bindings/pwm/pwm.h>
>> +
>>   / {
>>          aliases {
>>                  serial0 = &uart1;
>>          };
>>
>> +       backlight: backlight {
>> +               compatible = "pwm-backlight";
>> +               pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
>> +               brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
>> +               default-brightness-level = <8>;
>> +               /* TODO: backlight uses axp gpio1 as enable pin */
>> +               /* TODO: backlight is powered by AXP209 DCDC1SW */
>
> There's no DCDC1SW on AXP209. The reference design shows the backlight
> regulator is powered directly from IPSOUT,

Ah, right, I'll do a v2 dropping this comment line.

 > but the PWM pullup is powered
> by LCD-VCC,  which itself is enabled by AXP209 GPIO0.
>
> Would that be the case, or maybe closer, given we don't have schematics?

gpio0 needs to be driven high to get the backlight to lite up, that
is pretty much all I know.

Regards,

Hans
