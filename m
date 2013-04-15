From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 15 Apr 2013 12:01:43 +0530
Subject: [PATCH 1/7] clk: exynos: prepare for multiplatform
In-Reply-To: <1365775405-115297-2-git-send-email-arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
 <1365775405-115297-2-git-send-email-arnd@arndb.de>
Message-ID: <CAJuYYwRfoU1y_3qbZtdhdyRugPD_QCYWr_LuesOXzq+-jmxouw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 April 2013 19:33, Arnd Bergmann <arnd@arndb.de> wrote:
> The new common clock drivers for exynos are using compile
> time constants and soc_is_exynos* macros to provide backwards
> compatibility for pre-DT systems, which is not possible with
> multiplatform kernels. This moves all the necessary
> information back into platform code and removes the mach/*
> header inclusions.


Since kgene has submitted a patch to remove pre-dt Exynos support
which looks like it will be accepted, we could just remove the use of
soc_is_xyz() instead of continuing to support non-dt Exynos.

Thanks,
Thomas.
