From: monstr@monstr.eu (Michal Simek)
Date: Wed, 05 Feb 2014 10:25:27 +0100
Subject: [PATCH 09/10] watchdog: xilinx: Add missing binding
In-Reply-To: <201402042027.15898.arnd@arndb.de>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <3121595.GbLMuGPlvA@wuerfel>
 <4c4539fe-e810-4c0a-9a01-c1e4c67ea661@AM1EHSMHS007.ehs.local>
 <201402042027.15898.arnd@arndb.de>
Message-ID: <52F20387.3090709@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 08:27 PM, Arnd Bergmann wrote:
> On Monday 03 February 2014, Michal Simek wrote:
>> On 02/03/2014 04:32 PM, Arnd Bergmann wrote:
>>> On Monday 03 February 2014 16:13:47 Michal Simek wrote:
>>>> Intention wasn't to fix binding but document current one
>>>> which is in mainline for a long time.
>>>
>>> Ok, I see.
>>>
>>>> Apart of this - yes, wdt-enable-once is nowayout and wdt-interval should be timeout
>>>> is seconds, and clock-frequency should go out and use CCF for getting clock.
>>>
>>> Could we make a common binding then, and document that the xilinx
>>> watchdog can optionally provide either one?
>>
>> Do you mean to have 2 DT bindings?
>>
>> This binding is used from 2011-07.
>> It means it was generated for all hw designs at least from this time.
>> I would say from DT usage on Microblaze because it is not special case
>> in our dt generator.
> 
> I certainly wasn't suggesting to break the binding, quite the contrary.
> What I tried to say is that the properties look like they should be
> useful for different kinds of watchdogs, not just xilinx, so it would
> be good to have a common definition using generic strings.
> 
> The xilinx driver would definitely have to keep supporting the traditional
> property names, but it could also support the generic names in the
> future.

No problem with to do in future.

>> xlnx,XXX are XXX parameters which you have to setup in tools
>> and get synthesized. This is valid for all xilinx IPs. We have full
>> IP description by generating xlnx,XXX parameters directly from tools
>> because we know all variants which can happen.
>>
>> Just back to your previous post:
>> "I'm not sure about the enable-once flag, which seems to just map to the
>> "nowayout" watchdog option that is not a hardware feature at all"
>> this is hw feature which you can select in tools because this is fpga. :-)
> 
> Ah, so you mean the properties are not settings that the driver
> programs into the hardware, but they are hardware properties that the
> driver reports to user space?

yes, they are hardware properties which you can choose based on your
configuration. Every user just decides if this watchdog can be started just
once and how long it takes in synthesis time. There is no option to program
this by software.

I am not quite sure what you mean by reports to user space.
If you mean to get timeout through ioctl for example - then yes it is working
through standard watchdog ioctl interface and timeout is calculated
from hardware setup.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/99e851c4/attachment-0001.sig>
