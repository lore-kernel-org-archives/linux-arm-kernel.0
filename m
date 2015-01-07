From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jan 2015 09:16:26 -0800
Subject: [PATCH] arch: arm: mach-omap2: omap_hwmod.c: Remove some unused
 functions
In-Reply-To: <1417973047-12972-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1417973047-12972-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20150107171626.GA13010@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se> [141207 09:23]:
> Removes some functions that are not used anywhere:
> omap_hwmod_pad_route_irq() omap_hwmod_no_setup_reset()
> omap_hwmod_read_hardreset() omap_hwmod_del_initiator_dep()
> omap_hwmod_enable_clocks() omap_hwmod_reset() omap_hwmod_ocp_barrier()
> omap_hwmod_disable_clocks() omap_hwmod_add_initiator_dep()
> 
> This was partially found by using a static code analysis program called cppcheck.

Nice, we should probably run cppcheck for unused functions on
regular basis as we're slowly removing the legacy booting
support in favor of device tree based booting.

Paul, I'm applying all your arch/arm/*omap*/ cppcheck patches
into omap-for-v3.20/cleanup branch that can then be used as a
base for other branches in case of conflicts.

Richard, I've also unified the subject lines to start with
ARM: OMAP2+: and so on to make my pull requests will look
a bit nicer.

Regards,

Tony
