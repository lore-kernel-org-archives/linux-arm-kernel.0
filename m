From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 16:53:09 -0700
Subject: [PATCH v2 00/16] Switch GIC users (and omap2plus) to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110927235309.GP6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

* Marc Zyngier <marc.zyngier@arm.com> [110926 07:02]:
> In order to support multiple primary interrupt controllers in the same
> image, it is necessary to use the MULTI_IRQ_HANDLER config option.
> 
> This patch series makes a first step in that direction by:
> - having the GIC code to provides a global handler,
> - make GIC users to provide this handler from their machine descriptor.
> 
> A side effect of this is that it forces OMAP2/3 platforms to be
> converted too in order to preserve the MULTI_OMAP feature. This leads
> to a certain simplification of the interrupt handling for the
> OMAP2/3/4 platforms.

That's nice :)
 
> The primary IRQ handlers have been written in C, and the performance
> degradation is hardly noticeable. Should some tests reveal a major
> increase in latency, it is always possible to restore the ASM version.
> 
> This series has been tested on VE (A9, A5, A15), PB11MP, Panda, IGEPv2
> and Harmony. Patches against next-20110926 plus my PPI series.

I gave this series a quick try, it works except with all the patches
applied omap2plus_defconfig will failt to boot on omap4. It seems that
the issue is somewhere in the GIC related patches, the last one just
enables the MULTI_IRQ..

Care to give it a try on your Panda and see if omap2plus_defconfig
works for you with this series?

Looks like disabling CONFIG_SMP made it omap4 boot again.

Regards,

Tony 
