From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 28 Mar 2018 15:56:23 +0200
Subject: [PATCH] thermal: exynos_tmu: avoid uninitialized variables
In-Reply-To: <20180328134520.1970967-1-arnd@arndb.de>
References: <CGME20180328134538epcas2p4bb7a1f273824995e4baeb10d9563ffda@epcas2p4.samsung.com>
 <20180328134520.1970967-1-arnd@arndb.de>
Message-ID: <11114909.7eTX8MzZjF@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 28, 2018 03:44:44 PM Arnd Bergmann wrote:
> Removing the initialization in the error case introduced
> a compile-time warning:
> 
> drivers/thermal/samsung/exynos_tmu.c: In function 'temp_to_code':
> drivers/thermal/samsung/exynos_tmu.c:304:9: error: 'temp_code' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   return temp_code;
>          ^~~~~~~~~
> drivers/thermal/samsung/exynos_tmu.c: In function 'exynos_get_temp':
> drivers/thermal/samsung/exynos_tmu.c:931:37: error: 'temp' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    *temp = code_to_temp(data, value) * MCELSIUS;
> 
> Let's assume the runtime warning is sufficient, and make it
> return a well-defined number instead of unintialized data.
> 
> Fixes: 480b5bfc16e1 ("thermal: exynos: remove parsing of samsung, tmu_default_temp_offset property")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
