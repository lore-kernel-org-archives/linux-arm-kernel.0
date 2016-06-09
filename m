From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Jun 2016 00:15:13 -0700
Subject: [PATCH] ARM: OMAP2: Enable Errata 430973 for OMAP3
In-Reply-To: <1463700017-18527-1-git-send-email-nm@ti.com>
References: <1463700017-18527-1-git-send-email-nm@ti.com>
Message-ID: <20160609071512.GK22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160519 16:23]:
> Enable Erratum 430973 similar to commit 5c86c5339c56 ("ARM:
> omap2plus_defconfig: Enable ARM erratum 430973 for omap3") - Since
> multiple defconfigs can exist from various points of view (multi_v7,
> omap2plus etc.. it is always better to enable the erratum from the
> Kconfig selection point of view so that downstream kernels dont have
> to rediscover this all over again.

This should safe to select now. Note that proc-v7.S still does not
do anything with multiarch to configure it. So the bootloader still
needs to enable it, or it needs to be done in the machine init like
n900 does.

So applying into omap-for-v4.7/fixes as it can solve some mysterious
app crashers with armhf at least.

Regards,

Tony
