From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jul 2014 09:59:23 +0200
Subject: [PATCH v2 05/11] ARM: dts: zynq: Add QSPI for Parallella
In-Reply-To: <ddb38ce5-9e31-4c94-967c-7784c7fba75c@BN1BFFO11FD028.protection.gbl>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-6-git-send-email-afaerber@suse.de>
 <ddb38ce5-9e31-4c94-967c-7784c7fba75c@BN1BFFO11FD028.protection.gbl>
Message-ID: <53D20E5B.9070501@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 01:18 AM, S?ren Brinkmann wrote:
> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
>> Prepare SPI0 and SPI1 while at it.

Patch subject is incorrect. You are adding SPI and QSPI.

>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v2: New
>>  
>>  arch/arm/boot/dts/zynq-7000.dtsi      | 37 +++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index 8fd826a..eed3df0 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -122,6 +122,30 @@
>>  			interrupts = <0 50 4>;
>>  		};
>>  
>> +		spi0: spi at e0006000 {
>> +			compatible = "xlnx,zynq-spi-r1p6";
>> +			reg = <0xe0006000 0x1000>;
>> +			status = "disabled";
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <0 26 4>;
>> +			clocks = <&clkc 25>, <&clkc 34>;
>> +			clock-names = "ref_clk", "pclk";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		spi1: spi at e0007000 {
>> +			compatible = "xlnx,zynq-spi-r1p6";
>> +			reg = <0xe0007000 0x1000>;
>> +			status = "disabled";
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <0 49 4>;
>> +			clocks = <&clkc 26>, <&clkc 35>;
>> +			clock-names = "ref_clk", "pclk";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
> Until here things look good.
> 
>>  		gem0: ethernet at e000b000 {
>>  			compatible = "cdns,gem";
>>  			reg = <0xe000b000 0x4000>;
>> @@ -140,6 +164,19 @@
>>  			clock-names = "pclk", "hclk", "tx_clk";
>>  		};
>>  
>> +		qspi: qspi at e000d000 {
>> +			compatible = "xlnx,zynq-spi-r1p6";
>> +			reg = <0xe000d000 0x1000>;
>> +			status = "disabled";
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <0 19 4>;
>> +			clocks = <&clkc 10>, <&clkc 43>;
>> +			clock-names = "ref_clk", "pclk";
>> +			num-cs = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
> I'm not sure what the status of this driver is. I think QSPI is still
> under review on the mailing lists and I don't think we should add this
> yet.

Driver for qspi is not in the mainline yet but it doesn't mean
that this fragment won't work.
Harini: Can you please correct me if I am wrong?

I would prefer to send two separate patches.

1. just add SPI to zynq
2. if Harini confirms that it is working I think that make sense to enable
at least simple mode for qspi. That's why not a problem to add it too.
It means qspi patch with enabling for your board as second patch.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/ece305c0/attachment.sig>
