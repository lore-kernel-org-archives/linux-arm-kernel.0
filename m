From: hechtb@gmail.com (Bastian Hecht)
Date: Tue, 19 Mar 2013 11:30:19 +0100
Subject: [PATCH] ARM: shmobile: r8a7740: Add CPU Core Standby Mode
In-Reply-To: <20130319032051.GA18272@verge.net.au>
References: <1362419645-3116-1-git-send-email-hechtb+renesas@gmail.com>
 <1362419645-3116-2-git-send-email-hechtb+renesas@gmail.com>
 <20130306164032.GN17833@n2100.arm.linux.org.uk>
 <20130319032051.GA18272@verge.net.au>
Message-ID: <CABYn4sym+Yv11G7Y3hWgwhe8rNK=qGkVuQA9ewwqYj55V7JX_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

2013/3/19 Simon Horman <horms@verge.net.au>:
> On Wed, Mar 06, 2013 at 04:40:33PM +0000, Russell King - ARM Linux wrote:
>> On Mon, Mar 04, 2013 at 06:54:05PM +0100, Bastian Hecht wrote:
>> > diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
>> > index 40b87aa..ee3d713 100644
>> > --- a/arch/arm/mach-shmobile/pm-r8a7740.c
>> > +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
>> > @@ -10,9 +10,29 @@
>> >   */
>> >  #include <linux/console.h>
>> >  #include <linux/suspend.h>
>> > +#include <asm/io.h>
>>
>> It's spelled linux/io.h, not asm/io.h
>
> Bastian, other than the requested change above, what is the status of this
> patch?

Yep thanks Russell, will fix it in upcoming versions.

Simon, I'm still tinkering with the L2 - it shouldn't be needed to be
flushed, but I found out that at some point it gets disabled (ROM boot
loader?). Further I've got additional sleep modes ready. I will post a
v2 when the L2 issue is clear. Maybe early next week.

Thanks,

 Bastian

> Also, please CC me on shmobile patches.
