From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Feb 2013 17:51:34 -0800
Subject: [PATCH 1/1] ARM: tegra: Fix build error w/ ARCH_TEGRA_114_SOC
 w/o ARCH_TEGRA_3x_SOC
In-Reply-To: <51129B80.9090907@wwwdotorg.org>
References: <1360167030-14159-1-git-send-email-hdoyu@nvidia.com>
 <51129B80.9090907@wwwdotorg.org>
Message-ID: <20130210015134.GA24767@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 11:05:52AM -0700, Stephen Warren wrote:
> On 02/06/2013 09:10 AM, Hiroshi Doyu wrote:
> > This patch fixes the build error when ARCH_TEGRA_114_SOC is enabled
> > and ARCH_TEGRA_3x_SOC is disabled.
> > 
> > This provides Tegra114 with its own tegra114_init_early() instead of
> > making use of tegra30_init_early() so that T114 build doesn't depend
> > on T3x anymore.
> 
> Olof, Arnd,
> 
> This patch fixes the (well, an) issue for me. Can you apply it directly
> to the arm-soc tree. I believe it should apply on top of the
> tegra-for-3.9-soc-t114 pull request I sent.

Ok, applied -- I presumed your acked-by so I added it.

> Let me know if you need a resend, although it was CC'd to LAKML, so I
> assume you have it in your email history.

No resend needed -- it had a bit of fuzz when applied though.

> BTW, I anticipate a few more fixes coming down the line:
> 
> 1) Clock-related patch from Laxman so that UART C clock on Cardhu is set
> up correctly for Bluetooth. v1 was posted already, but I think a v2 is
> needed here.
> 
> 2) Another fix for Tegra20+Tegra114 w/o Tegra30 build fix from Hiroshi,
> related to drivers/amba/tegra-ahb.c, although there aren't any
> dependencies there, so perhaps that can go through Russell since he
> maintains that tree.
> 
> 3) Something related to fb2229a "ARM: 7634/1: uncompress debug support
> for multiplatform build" since that breaks tegra_defconfig, but I
> haven't had a chance to look into that yet.
> 
> 4) Something related to a boot failure related to crash in
> tegra_timer_interrupt(), which I'm just about to go investigate.
> 
> Hopefully that's it...

Above sounds reasonable, thanks for the heads up.


-Olof
