From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 May 2014 00:08:19 +0000 (UTC)
Subject: [PATCH 0/2] OMAP2+: optional clock handling fixes
In-Reply-To: <1398233465-8845-1-git-send-email-rnayak@ti.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1405080000400.23579@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On Wed, 23 Apr 2014, Rajendra Nayak wrote:

> The patches fix some opt clock handling in gpio and in
> hwmod.
> 
> Rajendra Nayak (2):
>   gpio: omap: prepare and unprepare the debounce clock
>   ARM: OMAP2+: hwmod: Don't leave the optional clocks in
>     clk_prepare()ed state
> 
>  arch/arm/mach-omap2/omap_hwmod.c |   13 ++-----------
>  drivers/gpio/gpio-omap.c         |   10 +++++-----
>  2 files changed, 7 insertions(+), 16 deletions(-)

Can these patches be merged separately?  Looks to me that the two options 
are either to:

A. to merge them together, or 

B. to merge patch 1 first, then patch 2

Or will things break if only patch 1 is merged?


If we merge them together, I'd say the best situation would be to take 
them through the OMAP tree, since the changes are all OMAP-specific.  In 
that case we'll want an ack for the first patch from the GPIO maintainers, 
Linus Walleij <linus.walleij@linaro.org> and Alexandre Courbot 
<gnurou@gmail.com>.

Otherwise the path of least resistance would be (B) - you can get patch 1 
merged via the GPIO tree.  The GPIO maintainers can then provide a 
stable branch for us to base our changes on, or we can wait until the 
change reaches Linus.  Then we can subsequently merge patch 2 via the  
OMAP side.

Thoughts?


- Paul
