From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 7 Sep 2012 13:48:30 +0800
Subject: [PATCH] ARM: ep93xx: Fix build error due to 'SZ_32M' undeclared
In-Reply-To: <5049346B.5020205@gmail.com>
References: <1346675368.15950.0.camel@phoenix> <5049346B.5020205@gmail.com>
Message-ID: <CAF+7xWko4wokuU-OiMYq3a2RJyaSb=qXM+LOpJCKHYpEB1Xi2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Axel,
>
> The patch looks fine. I notice that the other ep93xx boards are also
> using the SZ_ defines, but are indirectly including linux/sizes.h via
> asm/memory.h, which in turn is indirectly included via asm/io.h. That
Seems this is also true for other platforms ( e.g. mach-pxa, mach-ux500, etc)

> seems a bit flaky, so I wonder if we should just explicitly include
> <linux/sizes.h> in all the board files which use the SZ_ macros as per
> the patch below. Thoughts?
I'm 50/50 on this.
But if we do these changes, this patch is more than a build fix.

Regards,
Axel
