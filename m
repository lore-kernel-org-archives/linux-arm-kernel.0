From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 14:05:10 -0800
Subject: [PATCH 1/4] arch: arm: gpmc: gpmc migration support
In-Reply-To: <1358933176-12409-2-git-send-email-avinashphilip@ti.com>
References: <1358933176-12409-1-git-send-email-avinashphilip@ti.com>
 <1358933176-12409-2-git-send-email-avinashphilip@ti.com>
Message-ID: <20130201220510.GY22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Philip Avinash <avinashphilip@ti.com> [130123 01:28]:
> With recent GPMC driver conversion, usage of gpmc_save/restore_context
> can done from gpmc driver itself. Hence removes the usage from pm34xx.c.
> Also removes the conditional compilation primitives ARCH_OMAP3 for
> gpmc_save/restore_context.

Hmm I think this will break GPMC for deeper idle modes. Note that we
need to save and restore the context every time hitting off-idle, not
just for suspend and resume. Or am I missing something here?

Regards,

Tony
