From: monstr@monstr.eu (Michal Simek)
Date: Wed, 5 Aug 2015 17:03:03 +0200
Subject: [GIT PULL] Xilinx ZynqMP DT changes for v4.3
In-Reply-To: <20150805090016.GI6390@localhost>
References: <55BB369F.4080100@monstr.eu> <20150805090016.GI6390@localhost>
Message-ID: <55C225A7.9050704@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 08/05/2015 11:00 AM, Olof Johansson wrote:
> On Fri, Jul 31, 2015 at 10:49:35AM +0200, Michal Simek wrote:
>> Hi,
>>
>> please pull these ARM64 DT patches to your tree.
>>
>> Thanks,
>> Michal
>>
>>
>> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
>>
>>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.3
>>
>> for you to fetch changes up to f49310dc62f68ae9f905f9a1e42224fa23867f47:
>>
>>   ARM64: zynqmp: Move SPI nodes to the right location (2015-07-31
>> 10:46:34 +0200)
>>
>> ----------------------------------------------------------------
>> arm: Xilinx ZynqMP dt patches for v4.3
>>
>> - Add SATA, GPIO, CAN, SMMU, USB, SPI, I2C, watchdog and sdhci for zynqmp
>> - Sort nodes in dtsi
> 
> You seem to sort these alphabetically. We normally encourage sorting by unit
> address instead. Was there some reason you chose alphabetical?

Normally if you look for something you can't remember addresses but you
remember names that's why this sorting is more natural at least for me.

I have checked APM/EXYNOS/Juno/SPR for example (and probably others) and
there is no order at all.
If this is any strict requirement to sort nodes by addresses I am happy
to send patch on the top of this series to fix it. That's why please let
me know.

There are other questions what to do with clocks for example - having
them on the bus like it is done for us and Cavium/Exynos/Seattle or
having separate node on the bus like APM.
Using soc node is another question.

I know that Grant wanted to update any guide which should cover these
stuff but I am not aware if we have any doc which describe it.

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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150805/8e2493c0/attachment.sig>
