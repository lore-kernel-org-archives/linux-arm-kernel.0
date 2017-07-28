From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Fri, 28 Jul 2017 11:31:21 +0530
Subject: [PATCH 2/2] arm64: dts: Add device node for pmi8994 gpios
In-Reply-To: <f0ad95d2-f79e-c3d4-1ac6-48d5d6e21956@codeaurora.org>
References: <1501137036-20155-1-git-send-email-vivek.gautam@codeaurora.org>
 <1501137036-20155-2-git-send-email-vivek.gautam@codeaurora.org>
 <f0ad95d2-f79e-c3d4-1ac6-48d5d6e21956@codeaurora.org>
Message-ID: <CAFp+6iHecyKSGLRrsA=4-9TZmtkMrDzxtKijQ8+gab0EGsBkjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 2:30 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/26/2017 11:30 PM, Vivek Gautam wrote:
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/pmi8994.dtsi | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
>> index d3879a4e8076..3b04ca63c31e 100644
>> --- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
>> @@ -8,6 +8,23 @@
>>               reg = <0x2 SPMI_USID>;
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>> +
>> +             pmi8994_gpios: gpios at c000 {
>> +                     compatible = "qcom,pmi8994-gpio";
>
>
> Please also include the generic "qcom,spmi-gpio" compatible. We really
> don't need to add the "qcom,pmi8994-gpio" one to the driver right now so
> I would leave that out of the driver but leave it here in the dtsi file
> of course.

Sure, will add the "qcom,spmi-gpio" compatible as well, and will drop the
"qcom,pmi8994-gpio" from the driver.
Thanks.

regards
Vivek

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
