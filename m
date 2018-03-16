From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 16 Mar 2018 18:10:49 +0530
Subject: [PATCH v2 02/13] ARM: dts: ipq4019: Add a few peripheral nodes
In-Reply-To: <eb50deb1-0530-866f-502e-e675cdd1e732@arm.com>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-3-git-send-email-sricharan@codeaurora.org>
 <eb50deb1-0530-866f-502e-e675cdd1e732@arm.com>
Message-ID: <e8b8c76f-c684-de9d-a315-1051017dcdef@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 3/16/2018 5:47 PM, Marc Zyngier wrote:
> On 16/03/18 09:38, Sricharan R wrote:
>> Now with the driver updates for some peripherals being there,
>> add i2c, spi, pcie, bam, qpic-nand, scm nodes to enhance the available
>> peripheral support.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 134 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> index 10d112a..e38fffa 100644
>> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> @@ -25,7 +25,9 @@
> 
> [...]
> 
>> +		pcie0: pci at 40000000 {
>> +			compatible = "qcom,pcie-ipq4019", "snps,dw-pcie";
>> +			reg =  <0x40000000 0xf1d
>> +				0x40000f20 0xa8
>> +				0x80000 0x2000
>> +				0x40100000 0x1000>;
>> +			reg-names = "dbi", "elbi", "parf", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <0>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
>> +				  0x82000000 0 0x48000000 0x48000000 0 0x10000000>;
>> +
>> +			interrupts = <GIC_SPI 141 IRQ_TYPE_NONE>;
> 
> There is no such thing as IRQ_TYPE_NONE. Please replace this with the
> actual trigger information.

 ok, will update this.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
