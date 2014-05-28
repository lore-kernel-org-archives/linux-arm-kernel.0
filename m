From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 28 May 2014 15:18:51 -0500
Subject: [PATCH] ARM: dts: qcom: Update msm8960 device trees
In-Reply-To: <20140528200948.GI2012@joshc.qualcomm.com>
References: <1401301643-20191-1-git-send-email-galak@codeaurora.org>
 <20140528200948.GI2012@joshc.qualcomm.com>
Message-ID: <7C29E7CF-F9A4-4BCE-99AC-2C12FD22258F@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 28, 2014, at 3:09 PM, Josh Cartwright <joshc@codeaurora.org> wrote:

> On Wed, May 28, 2014 at 01:27:23PM -0500, Kumar Gala wrote:
>> * Move SoC peripherals into an SoC container node
>> * Move serial enabling into board file (qcom-msm8960-cdp.dts)
>> * Cleanup cpu node to match binding spec, enable-method and compatible
>>  should be per cpu, not part of the container
>> * Drop interrupts property from l2-cache node as its not part of the
>>  binding spec
>> 
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
>> arch/arm/boot/dts/qcom-msm8960-cdp.dts |   6 ++
>> arch/arm/boot/dts/qcom-msm8960.dtsi    | 165 +++++++++++++++++----------------
>> 2 files changed, 93 insertions(+), 78 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
>> index a58fb88..8e77ed7 100644
>> --- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
>> +++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
>> @@ -3,4 +3,10 @@
>> / {
>> 	model = "Qualcomm MSM8960 CDP";
>> 	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
>> +
>> +	soc {
>> +		serial at 16440000 {
>> +			status = "ok";
>> +		};
>> +	};
>> };
> 
> Is now the time put these serial nodes under a GSBI parent node?

Yeah, I?ll make the change to the 8960 & 8660 dts

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
