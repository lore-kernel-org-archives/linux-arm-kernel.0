From: monstr@monstr.eu (Michal Simek)
Date: Fri, 22 Aug 2014 07:52:49 +0200
Subject: [PATCH 9/9] ARM: zynq: Rename 'zynq_platform_cpu_die'
In-Reply-To: <9c7c26e1-4098-4252-a719-fb7b7205be61@BN1AFFO11FD006.protection.gbl>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-10-git-send-email-soren.brinkmann@xilinx.com>
 <4ac42f4d-72bf-4a8d-a997-094f129d7c74@BN1AFFO11FD020.protection.gbl>
 <9c7c26e1-4098-4252-a719-fb7b7205be61@BN1AFFO11FD006.protection.gbl>
Message-ID: <53F6DAB1.9020001@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2014 09:02 PM, S?ren Brinkmann wrote:
> On Thu, 2014-08-21 at 02:28PM +0200, Michal Simek wrote:
>> On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
>>> Match the naming pattern of all other SMP ops and rename
>>> zynq_platform_cpu_die --> zynq_cpu_die.
>>>
>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>> ---
>>>  arch/arm/mach-zynq/platsmp.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
>>> index 04e578718aa2..95933c5e70e1 100644
>>> --- a/arch/arm/mach-zynq/platsmp.c
>>> +++ b/arch/arm/mach-zynq/platsmp.c
>>> @@ -138,7 +138,7 @@ static int zynq_cpu_kill(unsigned cpu)
>>>   *
>>>   * Called with IRQs disabled
>>>   */
>>> -static void zynq_platform_cpu_die(unsigned int cpu)
>>> +static void zynq_cpu_die(unsigned int cpu)
>>>  {

Sorry for incorrect place - I mean to use kernel-doc here not below. :-)


>>>  	zynq_slcr_cpu_state_write(cpu, true);
>>>  
>>> @@ -158,7 +158,7 @@ struct smp_operations zynq_smp_ops __initdata = {
>>>  	.smp_boot_secondary	= zynq_boot_secondary,
>>>  	.smp_secondary_init	= zynq_secondary_init,
>>>  #ifdef CONFIG_HOTPLUG_CPU
>>> -	.cpu_die		= zynq_platform_cpu_die,
>>> +	.cpu_die		= zynq_cpu_die,
>>>  	.cpu_kill		= zynq_cpu_kill,
>>>  #endif
>>>  };
>>
>> Will be good if you can move fix that kernel-doc format for this function
>> too. It is just nice to have thing.
> 
> All these SMP-ops should be documented in the header defining that
> struct, shouldn't they?

This struct is not necessary. I have added comment to wrong place.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140822/70a267ca/attachment.sig>
