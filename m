From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 12 Sep 2018 11:31:01 +0100
Subject: [PATCH 04/11] dts: qcom: Update coresight bindings for hardware
 ports
In-Reply-To: <20180912101753.GB3353@leoy-ThinkPad-X240s>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-5-git-send-email-suzuki.poulose@arm.com>
 <20180912101753.GB3353@leoy-ThinkPad-X240s>
Message-ID: <98004d69-8be3-ab3f-b622-92236489e9c2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 12/09/18 11:17, leo.yan at linaro.org wrote:
> Hi Suzuki,
> 
> On Tue, Sep 11, 2018 at 11:17:05AM +0100, Suzuki K Poulose wrote:
>> Switch to updated coresight bindings for hw ports
>>
>> Cc: Andy Gross <andy.gross@linaro.org>
>> Cc: David Brown <david.brown@linaro.org>
>> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8916.dtsi | 98 ++++++++++++++++++++++-------------
>>   1 file changed, 63 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> index 7b32b89..5bed52b 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> @@ -1099,10 +1099,11 @@
>>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>>   			clock-names = "apb_pclk", "atclk";
>>   
>> -			port {
>> -				tpiu_in: endpoint {
>> -					slave-mode;
>> -					remote-endpoint = <&replicator_out1>;
>> +			out-ports {
> 
> Here should be in-ports for tpiu node?
> 
> BTW, if upper comment is valid, this means the DT binding doc also
> gives wrong example for tpiu node [1].

You are right on both counts.

> 
> I tested this patch with upper changing to 'in-ports', etm with perf
> mode can work well on DB410c board.
> 

Thanks a lot for the testing. I will fix both the problems.

Suzuki
