From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 10 Jul 2017 12:12:29 +0530
Subject: [PATCH V4 6/6] iommu/arm-smmu: Add support for
 qcom,msm8996-smmu-v2 clocks
In-Reply-To: <20170710034057.o5tha22rlllbxu3y@rob-hp-laptop>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-7-git-send-email-vivek.gautam@codeaurora.org>
 <20170710034057.o5tha22rlllbxu3y@rob-hp-laptop>
Message-ID: <CAFp+6iFX=DDcK4DUC_U9h5cBa0Y1==3WKy3X6WXiQZSQ7_BNLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


On Mon, Jul 10, 2017 at 9:10 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Jul 06, 2017 at 03:07:05PM +0530, Vivek Gautam wrote:
>> qcom,msm8996-smmu-v2 is an arm,smmu-v2 implementation with
>> specific clock and power requirements. This smmu core is used
>> with multiple masters on msm8996, viz. mdss, video, etc.
>> Add bindings for the same.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 18 ++++++++++++++++++
>>  drivers/iommu/arm-smmu.c                             | 13 +++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 00331752d355..5d8e79775fae 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -17,6 +17,7 @@ conditions.
>>                          "arm,mmu-401"
>>                          "arm,mmu-500"
>>                          "cavium,smmu-v2"
>> +                        "qcom,msm8996-smmu-v2"
>>
>>                    depending on the particular implementation and/or the
>>                    version of the architecture implemented.
>> @@ -74,11 +75,16 @@ conditions.
>>  - clock-names:    Should be "tcu" and "iface" for "arm,mmu-400",
>>                    "arm,mmu-401" and "arm,mmu-500"
>>
>> +                  Should be "bus", and "iface" for "qcom,msm8996-smmu-v2"
>> +                  implementation.
>> +
>>                    "tcu" clock is required for smmu's register access using the
>>                    programming interface and ptw for downstream bus access. This
>>                    clock is also used for access to the TBU connected to the
>>                    master locally. Sometimes however, TBU is clocked along with
>>                    the master.
>> +                  "bus" clock for "qcom,msm8996-smmu-v2" is requierd for downstream
>
> s/requierd/required/

sure, will correct it.

>
>> +                  bus access and for the smmu ptw.
>>
>>                    "iface" clock is required to access the TCU's programming
>>                    interface, apart from the "tcu" clock.
>> @@ -161,3 +167,15 @@ conditions.
>>                  iommu-map = <0 &smmu3 0 0x400>;
>>                  ...
>>          };
>> +
>> +     /* Qcom's arm,smmu-v2 implementation for msm8996 */
>> +     smmu4: iommu {
>> +             compatible = "qcom,msm8996-smmu-v2";
>
> No registers?

It does have registers. Will add the complete binding example.

Thank you for the review.

Best Regards
Vivek

[snip]


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
