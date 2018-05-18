From: collinsd@codeaurora.org (David Collins)
Date: Thu, 17 May 2018 17:16:18 -0700
Subject: [PATCH v3 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <CAD=FV=UiZEFTAtO9C0UbRO=ow5=dv6zNG-XMqhHm1Fmp2GwVcA@mail.gmail.com>
References: <cover.1526088081.git.collinsd@codeaurora.org>
 <3a4195365ab0d252fdf064d2300f45b9b777991c.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=UiZEFTAtO9C0UbRO=ow5=dv6zNG-XMqhHm1Fmp2GwVcA@mail.gmail.com>
Message-ID: <8847014e-4d27-b47a-8dc1-5b4a35123ce6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2018 02:23 PM, Doug Anderson wrote:
> On Fri, May 11, 2018 at 7:28 PM, David Collins <collinsd@codeaurora.org> wrote:
>> +                       /*
>> +                        * Default the voltage selector to an error value in the
>> +                        * case that qcom,regulator-initial-microvolt is not
>> +                        * specified in device tree since the true voltage is
>> +                        * not known.  Note that this value causes
>> +                        * devm_regulator_register() to fail in the case that
>> +                        * regulator-min-microvolt and regulator-max-microvolt
>> +                        * are specified in device tree due to
>> +                        * machine_constraints_voltage() bailing when the
>> +                        * get_voltage_sel() callback returns this error value.
>> +                        */
>> +                       vreg->voltage_selector = -EINVAL;
> 
> As per comments in other threads, adjust this comment and use
> -ENOTRECOVERABLE now.

I'll make this change.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
