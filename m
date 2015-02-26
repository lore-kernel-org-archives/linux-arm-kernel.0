From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 26 Feb 2015 13:20:17 -0800
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <54EF7DFD.9020609@codeaurora.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
 <54EF748B.3090404@codeaurora.org> <54EF7D74.7060906@linaro.org>
 <54EF7DFD.9020609@codeaurora.org>
Message-ID: <CAJAp7OjYicY2dZ3V9n_dGS_V3EPjH4SrniqOUBxdZn+EmyW7gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 12:11 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/26/15 12:09, Srinivas Kandagatla wrote:
>>
>>
>> On 26/02/15 19:31, Stephen Boyd wrote:
>>> On 02/22/15 23:54, Srinivas Kandagatla wrote:
>>>> +            pm8921_s5: pm8921-s5 {
>>>> +                compatible    = "qcom,rpm-pm8921-ftsmps";
>>>> +                reg        = <QCOM_RPM_PM8921_SMPS5>;
>>>> +            };
>>>> +
>>>> +            pm8921_s6: pm8921-s6 {
>>>> +                compatible    = "qcom,rpm-pm8921-ftsmps";
>>>> +                reg        = <QCOM_RPM_PM8921_SMPS6>;
>>>> +            };
>>>> +
>>>
>>> There's no RPM control for S5 and S6. Please remove. Also, has this been
>>> tested?
>>>
>> Ahh. these are SAW regulators, I will remove it from the list.
>> Obviously, I did not test all the regulators.
>
> There are some more that don't seem to match what we have downstream.
> L26 is also SAW related, and the usb and hdmi switches are "locally"
> controlled via ssbi pmic writes.
>

According to msm-3.4 all three are controlled by pm8xxx-regulator, but
they are also exposed through the RPM - which I think I tested (a year
ago or so).

Regards,
Bjorn
