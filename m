From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Nov 2012 20:08:38 +0900
Subject: [PATCH] ARM: EXYNOS: Avoid early use of of_machine_is_compatible()
In-Reply-To: <CAOesGMj9nw4230jBMyWR8L6c21iKvH-YHAQf8=MdTE-ANrZpgA@mail.gmail.com>
References: <1354045994-8977-1-git-send-email-dianders@chromium.org>
 <CAOesGMjyXZwKjycyVcEV0ty0LCM_i61QxykYPhAvXxx2rhgP+A@mail.gmail.com>
 <50B53E37.40303@samsung.com>
 <CAOesGMivs=NA6hcTYWO-MWUeUjVGZ0h258z1MpeexXGtVf9h-g@mail.gmail.com>
 <18d701cdcd28$74198d70$5c4ca850$%kim@samsung.com>
 <20121128060553.GA18166@quad.lixom.net>
 <CAD=FV=WvDWrT_vCT8W48mKFU4O2n-_yDz+SpFpqx3B25tvmRKA@mail.gmail.com>
 <CAOesGMj9nw4230jBMyWR8L6c21iKvH-YHAQf8=MdTE-ANrZpgA@mail.gmail.com>
Message-ID: <1d7701cdceeb$0c441fc0$24cc5f40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Wed, Nov 28, 2012 at 8:16 AM, Doug Anderson <dianders@chromium.org>
> wrote:
> > Olof / Kukjin,
> >

[...]

> >>
> >> I really don't like splitting an if/else with an ifdef like this, it's
> fragile
> >> code and can be hard to follow.
> >
> > Agree.

Definitely, same here ;-)

> >> There's also a second build error with exynos_defconfig in the
> >> exynos5-dt.c board file due to a missing include. Teaches me to just
> apply
> >> patches without trying to build. :(
> >
> > In the tree I was testing against (the arm-soc/for-next branch at
> > 659b19ca3a77e2ac32fe84d95242653c75dd07c7) I see the include file in
> > the exynos5-dt.c file already.  In my tree it was added by "2eae613b:
> > ARM: EXYNOS: Add MFC device tree support".
> >
> > Your patch applies cleanly on mine but I end up with:
> >
> >   #include <linux/of_platform.h>
> >   #include <linux/of_fdt.h>
> >   #include <linux/serial_core.h>
> >   #include <linux/io.h>
> >   #include <linux/memblock.h>
> >   #include <linux/of_fdt.h>
> 
> Sigh, this is because people add includes out of alphabetical order.

Yeah.

> We'll just have to fix it up later, 

Sure, I will after release 3.8-rc1.

[...]
> 
> I've pushed out the branch with the patch applied (with the above
changed).
> 
Thanks for your fix.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
