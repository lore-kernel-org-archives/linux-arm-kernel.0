From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 21 Nov 2011 16:29:19 +0200
Subject: [PATCH 06/10] arm/tegra: prepare pinmux code for multiple
 tegra variants
In-Reply-To: <20111118214116.GC31678@quad.lixom.net>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-7-git-send-email-pdeschrijver@nvidia.com>
 <20111118214116.GC31678@quad.lixom.net>
Message-ID: <20111121142919.GN19069@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 10:41:16PM +0100, Olof Johansson wrote:
> On Thu, Nov 17, 2011 at 06:19:20PM +0200, Peter De Schrijver wrote:
> > This patch modifies the pinmux code to be useable for multiple tegra variants.
> > Some tegra20 specific constants will be replaced by variables which will be
> > initialized to the appropriate value at runtime.
> >
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/board-harmony-pcie.c     |    1 +
> >  arch/arm/mach-tegra/board-harmony-pinmux.c   |    1 +
> >  arch/arm/mach-tegra/board-paz00-pinmux.c     |    1 +
> >  arch/arm/mach-tegra/board-trimslice-pinmux.c |    1 +
> >  arch/arm/mach-tegra/include/mach/pinmux.h    |   25 +++----
> >  arch/arm/mach-tegra/pinmux-tegra20-tables.c  |   15 +++-
> >  arch/arm/mach-tegra/pinmux.c                 |  105 ++++++++++++++-----------
> >  7 files changed, 86 insertions(+), 63 deletions(-)
> >
> > diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
> > index 6db7d69..bd402d0 100644
> > --- a/arch/arm/mach-tegra/board-harmony-pcie.c
> > +++ b/arch/arm/mach-tegra/board-harmony-pcie.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/mach-types.h>
> >
> >  #include <mach/pinmux.h>
> > +#include <mach/pinmux-tegra20.h>
> 
> Boards shouldn't have to include this. The idea is that you should only
> have to do board code against the pinmux.h interface, which internally
> abstracts it for tegra 20 vs tegra 30.

The pinmux naming is still SoC specific. Unless we move this to devicetree
(which should be part of a different patchset), I don't see how we can solve
this, except by renaming all the pingroups. That would cause a lot more
changes though.

Cheers,

Peter.
