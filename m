From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Jun 2013 11:17:28 -0700
Subject: [PATCH] ARM: tegra: fix section mismatch in tegra_pmc_parse_dt
In-Reply-To: <1371854347-12091-1-git-send-email-swarren@wwwdotorg.org>
References: <1371854347-12091-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130625181728.GE10694@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 04:39:07PM -0600, Stephen Warren wrote:
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
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---

Applied to fixes-non-critical.


-Olof
