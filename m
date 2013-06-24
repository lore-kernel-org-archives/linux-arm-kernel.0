From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 24 Jun 2013 10:40:00 +0800
Subject: [PATCH] ARM: tegra: fix section mismatch in tegra_pmc_parse_dt
In-Reply-To: <1371854347-12091-1-git-send-email-swarren@wwwdotorg.org>
References: <1371854347-12091-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1372041600.12718.4.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-06-22 at 06:39 +0800, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> tegra_pmc_parse_dt() references __initconst data. Fix it to be __init.
> This matches its only usage; a call from tegra_pmc_init() which is
> already __init. This fixes:
> 
> WARNING: vmlinux.o(.text.unlikely+0x580): Section mismatch in reference
> from the function tegra_pmc_parse_dt() to the (unknown reference)
> .init.rodata:(unknown)
> 
Hi Stephen,

Just curious, I don't see this warning message on my system. Does this
cause by some other patch or something else?

Thanks,
Joseph
