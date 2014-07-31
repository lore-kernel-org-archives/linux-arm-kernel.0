From: collinsd@codeaurora.org (David Collins)
Date: Thu, 31 Jul 2014 13:53:59 -0700
Subject: [PATCH v3 2/4] mfd: pm8xxx-spmi: document DT bindings for Qualcomm
 SPMI PMICs
In-Reply-To: <53DA054D.2050508@mm-sol.com>
References: <1406205921-7452-1-git-send-email-svarbanov@mm-sol.com>
 <1406205921-7452-3-git-send-email-svarbanov@mm-sol.com>
 <53D81EE1.7040309@codeaurora.org> <53DA054D.2050508@mm-sol.com>
Message-ID: <53DAACE7.70500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 01:58 AM, Stanimir Varbanov wrote:
> On 07/30/2014 01:23 AM, David Collins wrote:
>> On 07/24/2014 05:45 AM, Stanimir Varbanov wrote:
>>> Document DT bindings used to describe the Qualcomm SPMI PMICs.
>>> Currently the SPMI PMICs supported are pm8941, pm8841 and pma8084.
>>>
>>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>>
>> (...)
>>> +Required properties for peripheral child nodes:
>>> +- compatible:      Should contain "qcom,pm8xxx-xxx", where "xxx" is
>>> +                   peripheral name. The "pm8xxx" can be any of supported PMICs,
>>> +                   see example below.
>>
>> I don't think that this binding document should be imposing any formatting
>> restrictions on the compatible strings for QPNP peripheral drivers.  The
>> QPNP peripheral drivers in the downstream msm-3.10 tree [1] do not specify
>> per-PMIC compatible strings.  This is because ideally, a given QPNP
>> peripheral represents a hardware block that is identical in interface and
>> operation between PMICs.
>>
> 
> Isn't "hardware block that is identical in interface and operation
> between PMICs" exactly the meaning of *compatible* property?
> 
> No *compatible* property, no platform device. We must have this property
> for every peripheral driver.

I am not suggesting that we remove the compatible property for peripheral
device nodes.  I agree that these nodes need to have a compatible
property.  My concern is that this binding document should not require the
peripheral nodes to have compatible property values that are PMIC specific.

For example, in the downstream msm-3.10 branch the power-on peripheral
uses the same compatible string regardless of what PMIC the peripheral is
found on: "qcom,qpnp-power-on" [1].  There is no reason for the driver to
care about what PMIC the peripheral is found on.  Therefore, it does not
make sense to force it to support compatible strings like
"qcom,pm8941-power-on", "qcom,pm8841-power-on", "qcom,pma8084-power-on", etc.

Every QPNP PMIC peripheral has its own set of type and version registers
that allow software to auto-detect its capabilities at runtime.

Take care,
David

[1]:
https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/Documentation/devicetree/bindings/platform/msm/qpnp-power-on.txt?h=msm-3.10

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
