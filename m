From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 26 Mar 2014 19:05:41 -0500
Subject: [PATCH 2/3] dts: socfpga: Fix ethernet entries for the stmmac
In-Reply-To: <20140326221225.GP3998@book.gsilab.sittig.org>
References: <1395790482-3957-1-git-send-email-dinguyen@altera.com>
 <1395790482-3957-3-git-send-email-dinguyen@altera.com>
 <20140326221225.GP3998@book.gsilab.sittig.org>
Message-ID: <53336B55.7080605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/26/2014 05:12 PM, Gerhard Sittig wrote:
> On Tue, 2014-03-25 at 18:34 -0500, dinguyen at altera.com wrote:
>>
>> -			#size-cells = <1>;
>> -			compatible = "altr,socfpga-stmmac";
>> -			altr,sysmgr-syscon = <&sysmgr 0x60>;
>> +		gmac0: ethernet at ff700000 {
>> +			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
>>   			status = "disabled";
>> -			ranges;
>> -
>> -			gmac0: gmac0 at ff700000 {
>> -				compatible = "snps,dwmac-3.70a", "snps,dwmac";
>> -				reg = <0xff700000 0x2000>;
>> -				interrupts = <0 115 4>;
>> -				interrupt-names = "macirq";
>> -				mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
>> -				clocks = <&emac0_clk>;
>> -				clock-names = "stmmaceth";
>> -			};
>> +			altr,sysmgr-syscon = <&sysmgr 0x60>;
>> +			reg = <0xff700000 0x2000>;
>> +			interrupts = <0 115 4>;
>> +			interrupt-names = "macirq";
>> +			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
>> +			clocks = <&emac0_clk>;
>> +			clock-names = "stmmaceth";
>>   		};
>
> not strictly related to this patch, but noticed in bypassing:
>
> is the 'clocks' spec correct?  ISTR that 'emac0_clk' is the PLL
> output, while the gated clock for the EMAC IP block is named
> 'emac_0_clk' (note the extra underscore)
>

Yes, you're right. Thanks for catching that.

Dinh
>
> virtually yours
> Gerhard Sittig
>
