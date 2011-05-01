From: will.deacon@arm.com (Will Deacon)
Date: Sun, 01 May 2011 13:42:08 +0100
Subject: [PATCH 2/6] ARM: tegra: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <BANLkTik4u=f+pFe0mQDV6Moj=-x2JQ1SMQ@mail.gmail.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-3-git-send-email-will.deacon@arm.com>
	<BANLkTik4u=f+pFe0mQDV6Moj=-x2JQ1SMQ@mail.gmail.com>
Message-ID: <1304253728.4547.3.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

On Sun, 2011-05-01 at 08:26 +0100, Colin Cross wrote:
> On Tue, Apr 12, 2011 at 11:35 AM, Will Deacon <will.deacon@arm.com> wrote:
> > This patch updates the Tegra gpio chained IRQ handler to use the chained
> > IRQ enter/exit functions in order to function correctly on primary
> > controllers with different methods of flow control.
> >
> > This is required for the GIC to move to fasteoi interrupt handling.
> >
> > Cc: Colin Cross <ccross@android.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mach-tegra/gpio.c |    9 ++++++---
> >  arch/arm/mach-tegra/irq.c  |   12 ++++++------
> >  2 files changed, 12 insertions(+), 9 deletions(-)

[...]

> This version of the patch contains changes to gpio.c and irq.c.  If
> you drop the irq.c changes (which I will fix in my upcoming patch),

Yes please! I'm more than happy to drop the changes to irq.c. Please CC
me on your patch so that I know when it's safe to continue pushing the
fasteoi change.

> Acked-by: Colin Cross <ccross@android.com>

Cheers,

Will
