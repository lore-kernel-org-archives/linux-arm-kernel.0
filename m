From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 18 Aug 2014 16:24:24 -0700
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53F2255E.7090208@wwwdotorg.org>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <53EF76CF.9050808@suse.de> <53F2255E.7090208@wwwdotorg.org>
Message-ID: <CAL1qeaH-WfA-DLKwuXA_hBPHYuXksAibLq__zisrT9ALaRGdAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 9:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/16/2014 09:20 AM, Andreas F?rber wrote:
>>
>> Hi,
>>
>> Am 13.08.2014 21:14, schrieb Dylan Reid:
>>>
>>> The Acer Chromebook 13, codenamed Big, contains an NVIDIA tegra124
>>> processor and is similar to the Venice2 reference platform.
>>>
>>> The keyboard, USB 2, audio, HDMI, sdcard, and emmc have been tested
>>> and work on the 1266x768 models.  The HD models haven't yet been
>>> tested.
>>>
>>> WiFi does not work yet, it needs at least some PMIC changes to enable
>>> the 32k clock.
>>>
>>> The elan trackpad is not yet functional but hopefully will be soon as
>>> there are patches under review.
>>>
>>> There is also an issue on reboot because the TPM isn't reset.  It will
>>> cause the stock firmware to enter recovery mode.  This can be worked
>>> around by an EC-reset, press the refresh and power keys at the same
>>> time.
>
>
>>> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> b/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> new file mode 100644
>>> index 0000000..79f1852
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
>>> @@ -0,0 +1,1136 @@
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/input/input.h>
>>> +#include "tegra124.dtsi"
>>> +
>>> +/ {
>>> +       model = "Acer Chromebook 13";
>>> +       compatible = "google,nyan-big", "nvidia,tegra124";
>>
>>
>> In light of v1 and the above commit message referring to this as Google
>> Big, shouldn't this be "google,big", "nvidia,tegra124" and optionally
>> "google,nyan" as secondary string, independent of the new file name?
>
>
> Despite this board having been derived from Nyan, it isn't Nyan, so I don't
> think Nyan should be part of any compatible value, nor a separate compatible
> value.

"google,nyan-big" is the compatible string that the bootloader on
these devices looks for.  It's also the convention we are now using
for our ARM devices, as Olof has already mentioned.
