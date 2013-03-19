From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 19 Mar 2013 22:50:51 +0100
Subject: [PATCHv2] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <20130319211607.GE21478@lunn.ch> (Andrew Lunn's message of "Tue,
 19 Mar 2013 22:16:07 +0100")
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
 <87mwtzcgbl.fsf@natisbad.org> <20130319211607.GE21478@lunn.ch>
Message-ID: <87d2uvcb44.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Andrew Lunn <andrew@lunn.ch> writes:

> On Tue, Mar 19, 2013 at 08:58:22PM +0100, Arnaud Ebalard wrote:
>> Hi,
>> 
>> Add support for NETGEAR ReadyNAS Duo v2 (Hardware specs available
>> here: http://natisbad.org/NAS/).
>
> Hi Arnaud
>
> Thats a nice description of the hardware. There is another device
> using the same power supply controller, the USI Topkick. A few of the
> maintainers have these, so there would be the possibility of
> cooperating on a driver. It does not seem that complex a device. The
> topkick also seems to do Wake-on-LAN using this controller. There was
> a patch added recently which may allow this to work, depending on the
> PHY.

Does not come as a surprise. Netgear's 2.6.31.8 kernel contains a lot of
the following:
 
 This kernel which derived from kernel-2.6.31-topkick1281p2 used for
 both Netgear DUOv3 and NV+v4. It is based on kernel 2.6.31.8 and
 Marvell 5.1.3 patch. Specially the USB3.0 driver come from kernel
 2.6.39.

Note: everything in it is marked DUOv3 even though the device is branded
      Duo v2. Don't know why.

>> index 13482ea..511cd7d 100644
>> --- a/arch/arm/configs/kirkwood_defconfig
>> +++ b/arch/arm/configs/kirkwood_defconfig
>> @@ -35,6 +35,7 @@ CONFIG_MACH_NETSPACE_LITE_V2_DT=y
>>  CONFIG_MACH_NETSPACE_MINI_V2_DT=y
>>  CONFIG_MACH_OPENBLOCKS_A6_DT=y
>>  CONFIG_MACH_TOPKICK_DT=y
>> +CONFIG_MACH_READYNAS_DT=y
>>  CONFIG_MACH_TS219=y
>>  CONFIG_MACH_TS41X=y
>>  CONFIG_MACH_DOCKSTAR=y
>
> Keeping with alphabetic ordering, it should be one place higher....

Damned, I saw TS followed by DOCKSTAR and thought the rule did not
apply. Will resend a v3 with corrected ordering ...


>> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mv643xx_eth.h>
>> +#include <linux/delay.h>
>> +#include <asm/io.h>
>> +#include <mach/kirkwood.h>
>> +#include "common.h"
>
> Now that the msleep() has gone, delay.h is probably not needed.  Maybe
> also io.h is not needed any more with the regulator DT?

... and that one too. Good catch.

Thanks,

a+
