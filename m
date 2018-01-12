From: monstr@monstr.eu (Michal Simek)
Date: Fri, 12 Jan 2018 07:44:57 +0100
Subject: [GIT PULL] ARM64: Xilinx ZynqMP SoC patches for v4.16
In-Reply-To: <20180112012847.iqol2xb2iro6wauk@localhost>
References: <84cfd3d5-f0e7-23dc-0e33-430a1f2dbdb0@monstr.eu>
 <20180112012847.iqol2xb2iro6wauk@localhost>
Message-ID: <011f77e4-040b-a864-168f-bc198a523536@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.1.2018 02:28, Olof Johansson wrote:
> On Mon, Jan 08, 2018 at 02:02:18PM +0100, Michal Simek wrote:
>> Hi guys,
>>
>> please consider to pull these 3 patches to your tree. I have discussed
>> it with Arnd that this could be probably fine even it is a little bit late.
>>
>> Thanks,
>> Michal
>>
>>
>> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>>
>>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>>
>> are available in the git repository at:
>>
>>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-4.16
>>
>> for you to fetch changes up to cee8113a295acfc4cd25728d7c3d44e6bc3bbff9:
>>
>>   soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
>> (2018-01-08 13:42:47 +0100)
>>
>> ----------------------------------------------------------------
>> arm: Xilinx ZynqMP SoC patches for v4.16
>>
>> - Create drivers/soc/xilinx folder structure
>> - Add ZynqMP vcu init driver
>>
>> ----------------------------------------------------------------
>> Dhaval Shah (2):
>>       dt-bindings: soc: xilinx: Add DT bindings to xlnx_vcu driver
>>       soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
>>
>> Michal Simek (1):
>>       soc: xilinx: Create folder structure for soc specific drivers
>>
> 
> Merged, but you should probably add a platform config option for Xilinx
> and use that instead of obj-y to descend into the directory?

Do you think change like this?

-obj-y                          += xilinx/
+obj-$(CONFIG_ARCH_ZYNQMP)      += xilinx/

Just a note. This folder is supposed to be used by arm64/arm32 and
microblaze that's why I didn't put there any single config because it
doesn't exist. If you suggest to introduce new config option to label
xilinx platforms we can talk about it.
Argument against it could be also using these drivers by openrisc or
mips (mipsfpga) which are also fpga based.
Anyway I am happy to hear what you suggest.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180112/f08a841a/attachment.sig>
