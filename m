From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Jan 2015 16:23:56 -0800
Subject: [GIT PULL] Urgent omap4 legacy interrupt regression fix for
 v3.19-rc series
In-Reply-To: <20150119230950.GA7718@atomide.com>
References: <20150119230950.GA7718@atomide.com>
Message-ID: <20150120002356.GJ16883@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 03:09:51PM -0800, Tony Lindgren wrote:
> The following changes since commit 7ac72746aa9bb305fa74b44ec73eae99bbbe9b66:
> 
>   ARM: dts: Revert disabling of smc91x for n900 (2015-01-06 08:49:57 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/gic-regression-v2
> 
> for you to fetch changes up to 0fb22a8fb7f3bc1b00a36d4a97ce4f93191f7559:
> 
>   ARM: OMAP: Work around hardcoded interrupts (2015-01-17 08:56:12 -0800)
> 
> ----------------------------------------------------------------
> A rather urgent pull request to fix omap4 legacy interrupts.
> 
> The legacy interrupts on omap4 got broken when gic got changed to
> use irq_domain_add_linear() instead of the irq_domain_add_legacy(). We
> still have the hardcoded legacy IRQ numbers in use in several places,
> most notably the in the legacy DMA. It took a while to figure out
> what the problem was and how it should be fixed for the -rc series.
> 
> Also include is a regression fix for the dra7 dwc3 suspend.
> 

Merged.


-Olof
