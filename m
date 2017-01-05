From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 5 Jan 2017 05:42:54 -0600
Subject: [PATCH 08/12] ARM: dts: socfpga: Add NAND device tree for Arria10
In-Reply-To: <73a8b5ga1v.fsf@pengutronix.de>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
 <1483575694-29599-9-git-send-email-dinguyen@kernel.org>
 <73a8b5ga1v.fsf@pengutronix.de>
Message-ID: <7b15c95e-6d9f-bb2e-8c73-2f01dc3c8af2@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/05/2017 02:55 AM, Steffen Trumtrar wrote:

>> +#include "socfpga_arria10_socdk.dtsi"
>> +
>> +/ {
>> +	soc {
>> +		nand: nand at ffb90000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			status = "okay";
>> +
>> +			compatible = "denali,denali-nand-dt", "altr,socfpga-denali-nand";
>> +			reg = <0xffb90000 0x72000>, <0xffb80000 0x10000>;
>> +			reg-names = "nand_data", "denali_reg";
>> +			interrupts = <0 99 4>;
>> +			dma-mask = <0xffffffff>;
>> +			clocks = <&nand_clk>;
> 
> This belongs into the socfpga_arria10.dtsi.
> 

Ah yes, you're right. Thanks for the review.

Dinh
