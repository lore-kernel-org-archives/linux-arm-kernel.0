From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 20 Jan 2011 21:06:35 +0530
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
In-Reply-To: <4D385155.4050301@gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
Message-ID: <43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robherring2 at gmail.com]
> Sent: Thursday, January 20, 2011 8:44 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; Russell King; linux-
> omap at vger.kernel.org; Linus Walleij
> Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
> to speed-up boot
>
> On 01/20/2011 03:42 AM, Santosh Shilimkar wrote:
> > On some architectures, secondary cores shares clock with primiary
> > core and hence scale together. Hence secondary core lpj
> calibration
> > is not necessary and can be skipped to save considerable time.
> >
> > This can speed up the secondary cpu boot and hotplug cpu online
> > paths.
> >
> > Discussion thread:
> > 	http://www.spinics.net/lists/arm-kernel/msg111124.html
> >
>
> There's already one way to do this with pre-calculated lpj.
>
How about the hot-plug path? This is not for just boot.

> Also, this isn't multi-platform friendly. You could accomplish the
> same
> thing using the clock api to get the core frequency of each core and
> only calculate lpj if the frequency is different.
May be but what's wrong with the obvious approach which is
completely non-intrusive.
Why is not multi-platform friendly ?
Archs can choose not to select this option.

Regards,
Santosh
