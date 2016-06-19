From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sun, 19 Jun 2016 10:53:13 -0700
Subject: [PATCH v3 0/5] i.MX L2-cache code cleanups and performance tweaks
In-Reply-To: <114981982.VXDIiN0rdz@wuerfel>
References: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
 <114981982.VXDIiN0rdz@wuerfel>
Message-ID: <CAHQ1cqGQm1jXAx0C97qODGEOM_r91aRZ50c_p5vJfHifOL3hiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 One more question, less about your patches than the existing code:
>
> After going through the current users of l2x0_init for board files,
> I noticed that imx35 enables l2x0 for both dts and all the board files
> and has an arm,l210-cache node in its dts, but imx31 only enables
> it for the board file and in the dt case doesn't init the cache nor
> does it have the dts node.
>
> I'm guessing this is a bug on i.mx31 dt support, right?

I would agree that it is. OTOH, I can't find any i.MX31 boards that
use device tree. The only file that references imx31.dtsi is
imx31-bug.dts, but at the same time that board has a dedicated board
file (mach-bug.c) so I wonder if it was ever used.

It looks like Sacha was the author of i.MX31, Sascha do you have any
comment on this?

There's also another small cleanup opportunity in collapsing
imx31_dt_timer_init() and mx31_clocks_init_dt() into a single function
given how the latter always returns 0 and can be converted to void.

I am more than happy to make both changes and include them in the set,
but I only have i.MX6 HW, and would only be able to do a compile-test,
so I am not sure if I should.

Thanks,
Andrey Smirnov
