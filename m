From: govinds@codeaurora.org (Govind Singh)
Date: Mon, 26 Nov 2018 22:28:57 +0530
Subject: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device
 node
In-Reply-To: <20181126144422.GU3175@vkoul-mobl.Dlink>
References: <20181126142133.16966-1-govinds@codeaurora.org>
 <20181126144422.GU3175@vkoul-mobl.Dlink>
Message-ID: <bcda9f6ffc58c8457e8822226b751132@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for the review.

On 2018-11-26 20:14, Vinod Koul wrote:
> Hi Govind,
> 
> On 26-11-18, 19:51, Govind Singh wrote:
>> Add device node for the ath10k SNOC platform driver probe
>> and add resources required for WCN3990 on qcs404 soc.
>> Optional clock and regulator controls are not yet available in
>> upstream, hence add them once available.
>> 
>> Signed-off-by: Govind Singh <govinds@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi 
>> b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> index 9ca4f061ecc5..1a401a32d4a1 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> @@ -958,6 +958,25 @@
>>  				status = "disabled";
>>  			};
>>  		};
>> +
>> +		wifi: wifi at 0A000000 {
> 
> Please remove leading 0 from node
> 

Sure, i will change in v2.

>> +			compatible = "qcom,wcn3990-wifi";
>> +			reg = <0x0A000000 0x800000>;
>> +			reg-names = "membase";
>> +			memory-region = <&wlan_msa_mem>;
>> +			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>>  	};
>> 
>>  	timer {
> 
> This file is sorted alphabetically and reg values. So this should be
> between blsp1_uart2 and intc node, can you please change that
> 
> Also please compile this with W=12
> 

Sure, i will change in v2.

> Lastly, I am not sure, but should the wifi node be always enabled?
> Should it not be enabled in the board dts file? Bjorn..?
> 

yes, i some how missed this.
I will mark the status disabled by default and enable from qcs404 evb 
dts.

> Thanks
