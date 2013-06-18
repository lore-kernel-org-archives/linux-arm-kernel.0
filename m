From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 20:29:09 +0200
Subject: [PATCH v2 00/38] Thirty eight patches big Exynos cleanup
In-Reply-To: <44244927.ekNqhkrd4q@flatron>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <51C09E3C.5050108@samsung.com> <44244927.ekNqhkrd4q@flatron>
Message-ID: <201306182029.09790.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Tomasz Figa wrote:
> OK. Looking forward to it.
> 
> Btw. This leaves us with two things broken:
>  - sdhci-s3c checks for defined(CONFIG_SOC_EXYNOS4212), but does not check 
> for defined(CONFIG_SOC_EXYNOS4412),
>  - exynos-thermal checks for defined(CONFIG_SOC_EXYNOS4412), but does not 
> check for defined(CONFIG_SOC_EXYNOS4212).
> 
> I think this must be fixed, because selecting only Exynos4212 in kernel 
> config you end up without exynos-thermal, while selecting only Exynos4412 
> breaks sdhci-s3c.

I wonder what we actually gain by having all these fine-grained checks
in the kernel. Why not just reduce the compile-time checks to just
EXYNOS4 and EXYNOS5?

The drivers can easily implement code for all variants using
run-time checks, but I think it would be easier if building an EXYNOS4
kernel would just run on all EXYNOS4 machines.

	Arnd
