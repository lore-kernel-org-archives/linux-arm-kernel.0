From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Jan 2013 21:59:16 -0800
Subject: [PATCH] timer: vt8500: Move timer code to drivers/clocksource
In-Reply-To: <1358225583.5576.1.camel@gitbox>
References: <1358140171-25390-1-git-send-email-linux@prisktech.co.nz>
 <1358140171-25390-2-git-send-email-linux@prisktech.co.nz>
 <50F433A9.8020105@wwwdotorg.org> <1358225583.5576.1.camel@gitbox>
Message-ID: <CAOesGMi-wfedDRE8M8-Gxe6e6J2Qbjc0NhkM7=n442dO8hm9dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 8:53 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On Mon, 2013-01-14 at 09:34 -0700, Stephen Warren wrote:
>> On 01/13/2013 10:09 PM, Tony Prisk wrote:
>> > This patch moves arch-vt8500/timer.c into drivers/clocksource and
>> > updates the necessary Kconfig/Makefile options.
>>
>> > diff --git a/include/linux/vt8500_timer.h b/include/linux/vt8500_timer.h
>>
>> > +#ifndef __VT8500_TIMER_H
>> > +#define __VT8500_TIMER_H
>> > +
>> > +#include <asm/mach/time.h>
>> > +
>> > +void vt8500_timer_init(void);
>> > +
>> > +#endif
>>
>> Is VT8500 DT-only? If so, it'd be nice not to add this header, but
>> instead use CLOCKSOURCE_OF_DECLARE() inside the driver C file.
>
> Agreed - I didn't like the header when I added it but I didn't know of
> another way and based in on the sunxi code.
>
> Unfortunately Olof already pulled it into arm-soc, so I will try get
> another patch done to undo it :)

Ack, I saw the comments but somehow blanked when it came to pulling
it. Incremental patches on top are fine though.

Sorry Stephen, I didn't mean to ignore your comments. :)


-Olof
