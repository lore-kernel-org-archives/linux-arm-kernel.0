From: eric@anholt.net (Eric Anholt)
Date: Mon, 12 Oct 2015 13:57:22 -0700
Subject: [PATCH v3 7/7] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <561A70C6.4070602@lategoodbye.de>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-8-git-send-email-eric@anholt.net>
 <561A70C6.4070602@lategoodbye.de>
Message-ID: <87zizn4xfx.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <info@lategoodbye.de> writes:

> Am 09.10.2015 um 23:27 schrieb Eric Anholt:
>> VC4 is the GPU (display and 3D) present on the 2835.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> v2: Sort by register address, mark HDMI as disabled by default in the
>>      SoC file and enable it from -rpi.
>>
>> v3: Add references to the pixel/HSM clocks for HDMI.  Rename
>>      compatibility strings and clean up node names.
>>
>>   arch/arm/boot/dts/bcm2835-rpi.dtsi |  4 ++++
>>   arch/arm/boot/dts/bcm2835.dtsi     | 42 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
>> index 3572f03..dcaaee2 100644
>> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
>> @@ -56,6 +56,10 @@
>>   	status = "okay";
>>   };
>>
>> +&hdmi {
>> +	status = "okay";
>> +};
>> +
>>   &sdhci {
>>   	status = "okay";
>>   	bus-width = <4>;
>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>> index 1e61eb7..21e354a9 100644
>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>> @@ -1,4 +1,5 @@
>>   #include <dt-bindings/pinctrl/bcm2835.h>
>> +#include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/clock/bcm2835.h>
>>   #include "skeleton.dtsi"
>>
>> @@ -149,6 +150,18 @@
>>   			status = "disabled";
>>   		};
>>
>> +		pixelvalve at 7e206000 {
>> +			compatible = "brcm,bcm2835-pixelvalve0";
>> +			reg = <0x7e206000 0x100>;
>> +			interrupts = <2 13>; /* pwa2 */
>
> According to BCM2835-ARM-Peripherals this should be pwa0.
>
> Is it just a typo?
> What does pwa mean?

Just a typo.  I don't know what pwa means, either, it's just a string so
you can search for it in the docs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/ec727731/attachment.sig>
