From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 May 2015 14:22:00 +0200
Subject: [PATCH 1/6] ARM: sunxi: Introduce Allwinner H3 support
In-Reply-To: <5549EBB5.8040806@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-2-git-send-email-jenskuske@gmail.com>
 <20150506100446.GA11057@lukather> <5549EBB5.8040806@gmail.com>
Message-ID: <20150506122200.GE11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 12:23:49PM +0200, Jens Kuske wrote:
> On 06/05/15 12:04, Maxime Ripard wrote:
> > Hi,
> > 
> > On Wed, May 06, 2015 at 11:31:28AM +0200, Jens Kuske wrote:
> >> The Allwinner H3 is a quad-core Cortex-A7-based SoC. It is very similar
> >> to other sun8i family SoCs like the A23.
> >>
> >> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
> >>  arch/arm/mach-sunxi/Kconfig                     | 2 +-
> >>  arch/arm/mach-sunxi/sunxi.c                     | 3 ++-
> >>  3 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> >> index 42941fd..3cb4b94 100644
> >> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> >> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> >> @@ -9,4 +9,5 @@ using one of the following compatible strings:
> >>    allwinner,sun6i-a31
> >>    allwinner,sun7i-a20
> >>    allwinner,sun8i-a23
> >> +  allwinner,sun8i-h3
> >>    allwinner,sun9i-a80
> >> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> >> index 81502b9..47ac5b4 100644
> >> --- a/arch/arm/mach-sunxi/Kconfig
> >> +++ b/arch/arm/mach-sunxi/Kconfig
> >> @@ -35,7 +35,7 @@ config MACH_SUN7I
> >>  	select SUN5I_HSTIMER
> >>  
> >>  config MACH_SUN8I
> >> -	bool "Allwinner A23 (sun8i) SoCs support"
> >> +	bool "Allwinner A23 / H3 (sun8i) SoCs support"
> > 
> > I'd prefer that we have something similar to sun9i, just mentionning
> > the family here, instead of an ever-growing list of SoCs.
> > 
> > This used to be easy to maintain, with the new naming scheme, we
> > already have at least 4 SoCs part of sun8i.
> 
> According to Allwinners new naming scheme A20/A31/A31s are also part of
> sun8i (sun8iw[1,2]), but I think we can agree to use sun8i for the new
> SoCs, starting from A23.

Yep, we can't really change the family half-way, and using sun8i for
the newer SoCs (A23, A33, A83, H3, V*, etc.) works just as well.


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/32569df5/attachment.sig>
