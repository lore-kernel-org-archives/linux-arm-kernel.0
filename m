From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 21 Nov 2014 16:25:06 +0530
Subject: [PATCH] ARM: common: edma: edma_pm_resume may be unused
In-Reply-To: <4363971.teBOlf16kG@wuerfel>
References: <4363971.teBOlf16kG@wuerfel>
Message-ID: <546F1A0A.3060203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 04:22 PM, Arnd Bergmann wrote:
> The recently introduced resume hook in the edma driver
> is not referenced when CONFIG_PM_SLEEP is not set, which
> results in a compile warning in keystone_defconfig builds.
> 
> This adds an appropriate #ifdef.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Joel Fernandes <joelf@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Fixes: a2b1175131: ("ARM: common: edma: add suspend resume hook")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm applying this as the obvious fixup on top of the next/drivers
> branch.

Thanks Arnd!

FWIW,

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
