From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Oct 2016 22:24:29 -0700
Subject: [PATCH] bus: qcom-ebi2: depend on HAS_IOMEM
In-Reply-To: <1475445239-25006-1-git-send-email-linus.walleij@linaro.org>
References: <1475445239-25006-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161003052429.GB5655@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2016 at 11:53:59PM +0200, Linus Walleij wrote:
> After being asked to not depend on ARCH_QCOM* or similar,
> unsurprisingly compilation fails on UM as it has no I/O
> memory:
> 
> drivers/built-in.o: In function `qcom_ebi2_probe':
> >> drivers/bus/qcom-ebi2.c:333: undefined reference to
>    `devm_ioremap_resource'
> 
> Fix this by letting the Kconfig atleast depend on HAS_IOMEM.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: linux-arm-msm at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC maintainers: please apply this directly on the offending
> branch, or line it up for v4.9 fixes.

Applied to next/drivers. A Fixes: tag could have been nice, but it was
easy to find where the offender was.


-Olof
