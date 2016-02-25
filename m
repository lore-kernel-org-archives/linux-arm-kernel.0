From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 25 Feb 2016 11:21:56 +0000
Subject: [PATCH v3 6/8] arm64: dts: qcom: fix usb digital voltage levels
In-Reply-To: <56CE3780.5060408@codeaurora.org>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1456246236-18341-1-git-send-email-srinivas.kandagatla@linaro.org>
 <56CE3780.5060408@codeaurora.org>
Message-ID: <56CEE3D4.3030407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/02/16 23:06, Stephen Boyd wrote:
> On 02/23/2016 08:50 AM, Srinivas Kandagatla wrote:
>> This patch updates the digital voltage levels from corner values to
>> microvolts as we are going to use s1 regulator directly for vddcx
>> instead of s1_corner.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>
> What's the plan for corners? Maybe we should remove the voltage setting
> from the usb driver or drop the usb node entirely on msm8916 until we
> resolve how we're going to handle corners. I'd like to avoid getting
> stuck into some DT binding ABI mess here.

Andy/Bjorn, any comments on plans on corner regulators?

Please note, that this is a patch to fix what is already in the 
mainline. Without this patch the regulator would be configured with 1uV 
or 5uV or 7uV which would obviously fail.

THB, it does not make sense to drop feature which is functional, and I 
also agree that we should cleanup some of this mess at some point in 
time once we all the bits and pieces ready.

I was surprised to see these usb bindings(qcom,vdd-levels) existed even 
before we had concept of corner regulators in mainline kernel. Which 
also suggests that this driver needs a proper relook once again.

Thanks,
srini
