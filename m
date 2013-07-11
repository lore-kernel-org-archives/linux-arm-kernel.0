From: nm@ti.com (Nishanth Menon)
Date: Thu, 11 Jul 2013 09:59:16 -0500
Subject: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
In-Reply-To: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20130711145916.GA6138@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:23-20130711, Peter Ujfalusi wrote:
> OMAP4 no longer boots in legacy mode so the code here is no longer used.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/twl-common.c | 332 ++-------------------------------------
>  arch/arm/mach-omap2/twl-common.h |   8 -
>  2 files changed, 12 insertions(+), 328 deletions(-)
Could we modify the Makefile and build twl-common.o only for
CONFIG_ARCH_OMAP3?

We could get rid of all the #ifdef from the code that way. OMAP3 is the
only platform that still depends on this - Further, with this change,

commit 34a38440689b06a515104d668494e0ff8a4e1537
(regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators)
will need a relook as well. currently part of the discussion with Mark
in [1]


[1] http://marc.info/?t=137185016300003&r=1&w=2


-- 
Regards,
Nishanth Menon
