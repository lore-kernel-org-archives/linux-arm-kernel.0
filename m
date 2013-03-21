From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 13:10:47 +0100
Subject: [PATCH 2/6] clk: ux500: pass clock base adresses in init call
In-Reply-To: <1363866553-15054-3-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-3-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1728049.C7hP24pAtu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013 12:49:09 Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The ux500 clock driver was including <mach/db8500-regs.h>
> which will not work when building for multiplatform support
> since <mach/*> is going away.
> 
> Pass the base adresses in the init call instead.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

It would be nicer to read the base addresses from DT properties and
convert the driver to use CLK_OF_DECLARE(), but this works too,
and it leaves the non-DT path alone for now.

Acked-by: Arnd Bergmann <arnd@arndb.de>
