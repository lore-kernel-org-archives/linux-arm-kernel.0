From: monstr@monstr.eu (Michal Simek)
Date: Mon, 20 Oct 2014 21:07:01 +0200
Subject: [PATCH v2 1/3] ARM: zynq: Move common.h to generic location
In-Reply-To: <3225036.9QQDRKvzZS@wuerfel>
References: <742a19eb987f3f99b42ba4b7e7ebc27bf19d7d72.1413811526.git.michal.simek@xilinx.com>
 <3225036.9QQDRKvzZS@wuerfel>
Message-ID: <54455D55.6030003@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 03:36 PM, Arnd Bergmann wrote:
> On Monday 20 October 2014 15:25:31 Michal Simek wrote:
>> include/soc/zynq/ is the right location for this header
>> to be able to share information from this header with other
>> drivers which require it.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Update pm.c added in 3.17 too - Soren pointed on it
>>
>>  arch/arm/mach-zynq/common.c                       |  2 +-
>>  arch/arm/mach-zynq/hotplug.c                      | 14 --------------
>>  arch/arm/mach-zynq/platsmp.c                      |  2 +-
>>  arch/arm/mach-zynq/pm.c                           |  2 +-
>>  arch/arm/mach-zynq/slcr.c                         |  2 +-
>>  {arch/arm/mach-zynq => include/soc/zynq}/common.h |  0
>>  6 files changed, 4 insertions(+), 18 deletions(-)
>>  delete mode 100644 arch/arm/mach-zynq/hotplug.c
>>  rename {arch/arm/mach-zynq => include/soc/zynq}/common.h (100%)
>>
> 
> NAK
> 
> Most (if not all) of that header should not be visible to drivers.
> If you need to share some symbols, make a proper header file for those,
> not one called 'common.h'.

Ok. I will split it to more files - no problem to do it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141020/a5a4c926/attachment.sig>
