From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 17:31:54 -0800
Subject: [PATCH] ARM: OMAP2+: voltage: fixup oscillator handling when
 CONFIG_PM=n
In-Reply-To: <1352941984-11828-1-git-send-email-khilman@deeprootsystems.com>
References: <1352941984-11828-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20121115013153.GF6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121114 17:15]:
> From: Kevin Hilman <khilman@ti.com>
> 
> commit 908b75e8 (ARM: OMAP: add support for oscillator setup) added a new
> API for oscillator setup, but is broken when CONFIG_PM=n.
> 
> The new functions have dummy definitions when CONFIG_PM=n, but also have
> full implementations available, which conflict.
> 
> To fix, wrap the PM implmentations in #ifdef CONFIG_PM.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> This applies to Tony's omap-for-v3.8/pm branch, which includes my
> for_3.8-pm-voltage tag where this bug was introduced.

Thanks for fixing this quickly. Applied to omap-for-v3.8/pm-part2
and pushed out.

Regards,

Tony
