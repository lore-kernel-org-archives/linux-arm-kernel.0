From: collinsd@codeaurora.org (David Collins)
Date: Wed, 18 Apr 2018 14:44:10 -0700
Subject: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=UxabaHPa-pkGBvQDcmh7e+bqMRX4WdMS8xfhAQSKD9gg@mail.gmail.com>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=UxabaHPa-pkGBvQDcmh7e+bqMRX4WdMS8xfhAQSKD9gg@mail.gmail.com>
Message-ID: <0a52dfe6-d1e1-9171-aa20-8e55e47919f4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2018 01:06 PM, Doug Anderson wrote:
> [...]
>> +- qcom,regulator-initial-voltage
> 
> nit: regulator framework tends to include "microvolt" in the name to
> make it really obvious in the device tree what the units are.  Can you
> do that too?

Sure, I'll change the name to be: qcom,regulator-initial-microvolt.


>> +- qcom,drms-mode-threshold-currents
> 
> Could use microamp in the name of the property too...

Ok, I'll change the name to be: qcom,drms-mode-max-microamps.


>> +                       qcom,allowed-drms-modes =
>> +                               <RPMH_REGULATOR_MODE_LPM
>> +                                RPMH_REGULATOR_MODE_HPM>;
>> +                       qcom,drms-mode-threshold-currents = <10000 1000000>;
> 
> optional nit: to make it match downstream drivers, does it make sense
> to change this to:
> 
>   <9999 999999>
> 
> ...so if a driver used to request exactly 10000 mA that it will end up
> with the same mode (no idea if drivers actually do that).

I'd prefer to leave the example with <10000 1000000> as it looks cleaner
to me and the example numbers are arbitrary.  It would also be good to use
<10000 1000000> in actual board DT files.  We can address consumers
expecting legacy behavior for 10000 uA requests as needed.

Take care,
David


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
