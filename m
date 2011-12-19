From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Dec 2011 21:42:24 +0900
Subject: [PATCH] ARM: restart: move SWRST based S3C platforms to
 machine_desc hook
In-Reply-To: <201112191325.56090.heiko@sntech.de>
References: <03dc01ccbe45$80633d30$8129b790$%kim@samsung.com>
 <201112191312.34546.heiko@sntech.de>
 <03dd01ccbe48$88ed7d50$9ac877f0$%kim@samsung.com>
 <201112191325.56090.heiko@sntech.de>
Message-ID: <03de01ccbe4b$a8a5bb00$f9f13100$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:

> 
> S3C2412/S3C2416/S3C2443 use a special register to signal the reset to
> the processor and used therefore the s3c24xx_reset_hook mechanism in the
> s3c24xx-specific arch reset.
> 
> This patch introduces restart functions for these architectures,
> moves the board files to them and removes the s3c24xx_reset_hook
> infrastructure, as all users are gone.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> @Kgene: This is my first cleanup step, done before your s3c64xx mail
> arrived,
> which transforms the 2412,2416 and 2443 arches which use the special SWRST
> register to do the reset. Just if it helps :-)
> 
Heiko, thanks.

I'm looking at S5P SoCs now and of course this helps. And if possible, let
me do it with this.

As a note, we need to implement local header file before using new restart
hook and I'm thinking which one is better to us between all s3c24xx SoCs'
common or each mach-s3c24xx's one.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


>  arch/arm/mach-s3c2410/include/mach/reset.h        |   22
-------------------
> --
>  arch/arm/mach-s3c2410/include/mach/system-reset.h |    5 ----
>  arch/arm/mach-s3c2410/include/mach/system.h       |    2 -
>  arch/arm/mach-s3c2412/mach-jive.c                 |    2 +
>  arch/arm/mach-s3c2412/mach-smdk2413.c             |    3 ++
>  arch/arm/mach-s3c2412/mach-vstms.c                |    1 +
>  arch/arm/mach-s3c2412/s3c2412.c                   |   10 +++-----
>  arch/arm/mach-s3c2416/mach-smdk2416.c             |    1 +
>  arch/arm/mach-s3c2416/s3c2416.c                   |    7 +++--
>  arch/arm/mach-s3c2443/mach-smdk2443.c             |    1 +
>  arch/arm/mach-s3c2443/s3c2443.c                   |    8 +++---
>  arch/arm/plat-samsung/include/plat/s3c2412.h      |    3 ++
>  arch/arm/plat-samsung/include/plat/s3c2416.h      |    2 +
>  arch/arm/plat-samsung/include/plat/s3c2443.h      |    2 +
>  14 files changed, 27 insertions(+), 42 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c2410/include/mach/reset.h
