From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 23 Mar 2016 18:04:09 -0700
Subject: [PATCH 04/12] ARM: dts: dragonboard-600c: add board support with
 serial
In-Reply-To: <56F2FCD0.1000708@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762442-9492-1-git-send-email-srinivas.kandagatla@linaro.org>
 <56F2F78E.8050002@codeaurora.org> <56F2FCD0.1000708@linaro.org>
Message-ID: <CAOCOHw7TyzDf4jvAMChOFFEgsL4Z1+CcESLOuckT=Q7W9hQvCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 1:30 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 23/03/16 20:07, Stephen Boyd wrote:
>>
>> On 03/23/2016 12:47 PM, Srinivas Kandagatla wrote:
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>>> b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>>> new file mode 100644
>>> index 0000000..e96aab6
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
>>> @@ -0,0 +1,36 @@
>>> +#include "qcom-apq8064-v2.0.dtsi"
>>> +
>>> +/ {
>>> +       model = "Qualcomm Technologies, Inc. APQ8064 DragonBoard600c";
>>> +       compatible = "qcom,apq8064-dragonboard600c", "qcom,apq8064";
>>
>>
>> Does the bootloader look at this string at all or is it using appended
>> DTB design? I'm mostly worried about having that
>
> Not at least on APQ8064 bootloaders, as they are still missing DT support.
> Currently we append dtb to the kernel.
>>
>> qcom,apq8064-dragonboard600c part. It should probably be
>> qcom,apq8064-sbc or something like that instead.
>
> Will do that in next version.
>

This "sbc" isn't that just the abbreviation for "single board
computer"? I find it hard to believe this is _the_ 8064 sbc or the
only 8064 sbc.

Also, if I make a product based of this board, with some minor
changes, is that still the sbc?

I think the compatible should be "qcom,apq8064-db600c",
"qcom,apq8064-sbc", "qcom,apq8064"

Regards,
Bjorn
