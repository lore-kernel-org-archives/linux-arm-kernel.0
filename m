From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Jimenez)
Date: Mon, 29 Mar 2010 16:10:33 -0300
Subject: [PATCH] ARM: mach-sa1100: Put nanoEngine support back in the
	kernel.
In-Reply-To: <20100327225522.GD13203@n2100.arm.linux.org.uk>
References: <1268338199-32222-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100327225522.GD13203@n2100.arm.linux.org.uk>
Message-ID: <cecb6d8f1003291210q27c0dc47l7d81870e530bb6f0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel and Kristoffer,

On Sat, Mar 27, 2010 at 19:55, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> Please don't include defconfigs along with other code.

Ok, I have removed the defconfig and put it in a separate patch.

>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/root_dev.h>
>> +#include <linux/tty.h>
>
> Do you really need tty.h in here?

No, I don't. :) Removed.

>> +/* Flash bank 0 */
>> +static struct mtd_partition nanoengine_partitions[] = {
>> + ? ? {
>> + ? ? .name ? ? ? ? ? = "nanoEngine boot firmware and parameter table",
>
> Each '{' should indent the next line by a tab.

Ok, that was another "line over 80 characters" warning. Fixed.

I will resubmit the patch, merged with the CPU FREQ patch, which is
where it belongs. And a better changelog.

Also I have removed Kristoffer's "Acked-by" because this is a changed version.

Regards,
Marcelo.
