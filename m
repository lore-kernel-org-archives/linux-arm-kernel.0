From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 3 Feb 2014 16:47:55 +0100
Subject: [PATCH 09/10] watchdog: xilinx: Add missing binding
In-Reply-To: <3121595.GbLMuGPlvA@wuerfel>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <201402031606.11753.arnd@arndb.de>
 <24ecacca-2714-4834-921c-b827c0e592a3@VA3EHSMHS003.ehs.local>
 <3121595.GbLMuGPlvA@wuerfel>
Message-ID: <4c4539fe-e810-4c0a-9a01-c1e4c67ea661@AM1EHSMHS007.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2014 04:32 PM, Arnd Bergmann wrote:
> On Monday 03 February 2014 16:13:47 Michal Simek wrote:
>> Intention wasn't to fix binding but document current one
>> which is in mainline for a long time.
> 
> Ok, I see.
> 
>> Apart of this - yes, wdt-enable-once is nowayout and wdt-interval should be timeout
>> is seconds, and clock-frequency should go out and use CCF for getting clock.
> 
> Could we make a common binding then, and document that the xilinx
> watchdog can optionally provide either one?

Do you mean to have 2 DT bindings?

This binding is used from 2011-07.
It means it was generated for all hw designs at least from this time.
I would say from DT usage on Microblaze because it is not special case
in our dt generator.

xlnx,XXX are XXX parameters which you have to setup in tools
and get synthesized. This is valid for all xilinx IPs. We have full
IP description by generating xlnx,XXX parameters directly from tools
because we know all variants which can happen.

Just back to your previous post:
"I'm not sure about the enable-once flag, which seems to just map to the
"nowayout" watchdog option that is not a hardware feature at all"
this is hw feature which you can select in tools because this is fpga. :-)

Thanks,
Michal
