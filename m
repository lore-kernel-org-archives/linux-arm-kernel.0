From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Feb 2015 12:11:41 -0800
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <54EF7D74.7060906@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
 <54EF748B.3090404@codeaurora.org> <54EF7D74.7060906@linaro.org>
Message-ID: <54EF7DFD.9020609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/15 12:09, Srinivas Kandagatla wrote:
>
>
> On 26/02/15 19:31, Stephen Boyd wrote:
>> On 02/22/15 23:54, Srinivas Kandagatla wrote:
>>> +            pm8921_s5: pm8921-s5 {
>>> +                compatible    = "qcom,rpm-pm8921-ftsmps";
>>> +                reg        = <QCOM_RPM_PM8921_SMPS5>;
>>> +            };
>>> +
>>> +            pm8921_s6: pm8921-s6 {
>>> +                compatible    = "qcom,rpm-pm8921-ftsmps";
>>> +                reg        = <QCOM_RPM_PM8921_SMPS6>;
>>> +            };
>>> +
>>
>> There's no RPM control for S5 and S6. Please remove. Also, has this been
>> tested?
>>
> Ahh. these are SAW regulators, I will remove it from the list.
> Obviously, I did not test all the regulators.

There are some more that don't seem to match what we have downstream.
L26 is also SAW related, and the usb and hdmi switches are "locally"
controlled via ssbi pmic writes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
