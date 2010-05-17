From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 22:20:13 +0900
Subject: [PATCH 2/3] ARM: Samsung: move common I2C0 device helpers to
	machine	directories
In-Reply-To: <1274077795-30873-3-git-send-email-m.szyprowski@samsung.com>
References: <1274077795-30873-1-git-send-email-m.szyprowski@samsung.com>
	<1274077795-30873-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <004801caf5c3$b28ad030$17a07090$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> I2C0 device helper depend on GPIO pin defines that are SoC specific.
> This patch copies the dummy i2c0 setup code to the respective mach-s5p*
> directories, so each SoC will be able to implement using its own
> defines.

One more, moving from plat-s5p/ is better than creating.

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5p6440/Makefile     |    1 +
>  arch/arm/mach-s5p6440/setup-i2c0.c |   25 +++++++++++++++++++++++++
>  arch/arm/mach-s5p6442/Makefile     |    1 +
>  arch/arm/mach-s5p6442/setup-i2c0.c |   25 +++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/Makefile     |    1 +
>  arch/arm/mach-s5pv210/setup-i2c0.c |   25 +++++++++++++++++++++++++
>  arch/arm/plat-s5p/Makefile         |    1 -
>  arch/arm/plat-s5p/setup-i2c0.c     |   25 -------------------------
>  8 files changed, 78 insertions(+), 26 deletions(-)
>  create mode 100644 arch/arm/mach-s5p6440/setup-i2c0.c
>  create mode 100644 arch/arm/mach-s5p6442/setup-i2c0.c
>  create mode 100644 arch/arm/mach-s5pv210/setup-i2c0.c
>  delete mode 100644 arch/arm/plat-s5p/setup-i2c0.c
> 

(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
