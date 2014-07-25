From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jul 2014 10:02:50 +0200
Subject: [PATCH v2 06/11] ARM: dts: zynq: Add DMAC for Parallella
In-Reply-To: <bc390439-9a5b-43a1-a70c-a4c6517a6cb6@BN1AFFO11FD005.protection.gbl>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-7-git-send-email-afaerber@suse.de>
 <bc390439-9a5b-43a1-a70c-a4c6517a6cb6@BN1AFFO11FD005.protection.gbl>
Message-ID: <53D20F2A.5020209@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 01:28 AM, S?ren Brinkmann wrote:
> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v2: New
>>  
>>  arch/arm/boot/dts/zynq-7000.dtsi      | 17 +++++++++++++++++
>>  arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index eed3df0..1a70277 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -223,6 +223,23 @@
>>  			};
>>  		};
>>  
>> +		dmac_s: dmac at f8003000 {
>> +			compatible = "arm,pl330", "arm,primecell";
>> +			reg = <0xf8003000 0x1000>;
>> +			status = "disabled";
> I think for this IP we can omit the 'status' property since it is always
> enabled. I don't see a reason to override it in each board DT.

Done this change myself

> 
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <0 13 4>,
>> +			             <0 14 4>, <0 15 4>,
>> +			             <0 16 4>, <0 17 4>,
>> +			             <0 40 4>, <0 41 4>,
>> +			             <0 42 4>, <0 43 4>;
>> +			#dma-cells = <1>;
>> +			#dma-channels = <8>;
>> +			#dma-requests = <4>;
>> +			clocks = <&clkc 27>;
>> +			clock-names = "apb_pclk";
>> +		};
>> +
> 
> Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>


Applied to zynq/dt branch.
https://github.com/Xilinx/linux-xlnx/commits/zynq/dt

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/a7752890/attachment-0001.sig>
