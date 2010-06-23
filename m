From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jun 2010 20:54:56 +0100
Subject: [PATCH 6/6] [ARM] Introduce common definition for __io()
In-Reply-To: <1277293938-25804-7-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
	<1277293938-25804-7-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20100623195456.GC25070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 07:52:18PM +0800, Eric Miao wrote:
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
> ---
>  arch/arm/include/asm/io.h                 |    4 ++++
>  arch/arm/mach-aaec2000/include/mach/io.h  |    1 -
>  arch/arm/mach-at91/include/mach/io.h      |    1 -
>  arch/arm/mach-bcmring/include/mach/io.h   |    1 -
>  arch/arm/mach-clps711x/include/mach/io.h  |    1 -
>  arch/arm/mach-cns3xxx/include/mach/io.h   |    1 -
>  arch/arm/mach-davinci/include/mach/io.h   |    1 -
>  arch/arm/mach-ep93xx/include/mach/io.h    |    1 -

Again, ebsa110 is missing.

That's because __io() is a two-state definition.  It means something
if a platform does _not_ define it.  It also means something _if_ a
platform defines it.

You can't move it to asm/io.h because that precludes the first state
from ever occuring.  It's not a simple case that those platforms can
provide some subsitute definition for __io() - they have to supply
their own inb() et.al. accessors because they need to do something
uniquely special there.
