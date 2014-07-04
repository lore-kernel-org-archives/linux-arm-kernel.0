From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 22:15:54 +0200
Subject: [PATCH 00/19] ARM: SAMSUNG: S5PV210 platform clean-up
In-Reply-To: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
Message-ID: <12714831.uRzVr7yNEz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014 19:48:00 Tomasz Figa wrote:
> This huge series is a (hopefully final) attempt to convert Samsung S5PV210
> into a DT-only and multiplatform-aware platform. It consists of several
> steps to gradually replace legacy code with one meeting current standards
> and then finally remove unused remnants.
> 
> Patches 1-6 migrate the platform to fully use the Common Clock Framework
> and get rid of legacy private clock code, of which s5pv210 was the last
> user. Then patch 7 adds generic PHY driver for USB PHY on S5PV210 to allow
> USB to be supported when using DT. Further three patches (8-10) add DT
> support for mach-s5pv210 and necessary DT sources for currently supported
> boards. Patch 11 removes board files and code directly related to them,
> effectively making s5pv210 a DT-only platform. In next step, patches 12-15
> prepare remaining code for multiplatform enablement, which is finally done
> in patch 16. Patches 17-19 are a final clean-up, which remove a lot of
> unused code left after making the last S5P platform DT-only.
> 
> Build tested patch by patch on following configs:
>  - s3c2410_defconfig (with DT support enabled),
>  - s3c6400_defconfig (with DT support enabled),
>  - s5pv210_defconfig (with DT support enabled after patches adding it),
>  - exynos_defconfig,
>  - exynos_defconfig with S5PV210 enabled in multiplatform configuration.
> 
> Boot tested on s5pv210-goni board.
> 
> Note that support for smdkc110, smdkv210 and torbreck boards is provided
> by moving data from existing board files to new device tree sources. No
> testing was performed due to mentioned board not being available anymore.
> However I believe we agreed on this approach, because apparently there
> are no active users of them. See the RFC from August 2013 asking for
> removal of the whole platform [1].
> 
> [1] http://www.mail-archive.com/linux-samsung-soc%40vger.kernel.org/msg21882.html
> 
> 
Great work, everything

Acked-by: Arnd Bergmann <arnd@arndb.de>

I hope we can get this into linux-next soon so we can do some more
cleanups on top.

	Arnd
