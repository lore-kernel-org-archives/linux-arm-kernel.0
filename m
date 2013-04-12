From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 17:19:41 +0200
Subject: [PATCH 2/2] ARM: remove all trivial init_machine callbacks
In-Reply-To: <1365779468-116419-2-git-send-email-arnd@arndb.de>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <1365779468-116419-2-git-send-email-arnd@arndb.de>
Message-ID: <201304121719.41580.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 April 2013, Arnd Bergmann wrote:
> 
> -static void __init exynos4_dt_machine_init(void)
> -{
> -       of_platform_populate(NULL, of_default_bus_match_table,
> -                               exynos4_auxdata_lookup, NULL);
> -}
> -

This part was wrong, sorry. In the kernel I used as a base, we
actually still need exynos4_auxdata_lookup, so this patch actually
changes the behavior. In the for-next branch however, the auxdata
is gone.

	Arnd
