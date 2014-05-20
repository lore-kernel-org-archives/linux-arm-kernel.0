From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 May 2014 17:34:42 -0700
Subject: [PATCH v2] ARM: OMAP2+: Remove suspend_set_ops from common pm
 late init
In-Reply-To: <1399919601-15543-1-git-send-email-d-gerlach@ti.com>
References: <1399919601-15543-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20140520003442.GC15793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [140512 11:34]:
> In omap2_common_pm_late_init suspend_set_ops was called to set common
> suspend handling functions for all omap platforms. This created two
> problems. First, these suspend ops were being set for all platforms,
> regardless of whether or not suspend support has been integrated so in
> the case of AM33XX, suspend to mem was presented as available but
> failed every time. Second, some platforms will need to define a
> completely separate set of suspend ops, such as AM33XX, due to
> differences from previous omap platforms so there is no need to
> always set the common omap ops.
> 
> This patch moves the suspend_set_ops call from omap2_common_pm_late_init
> into a separate function that then gets called in the omap*_pm_init
> functions for each platform.

Gets rid of some ifdefs too. Applying into omap-for-v3.16/soc
thanks.

Tony
