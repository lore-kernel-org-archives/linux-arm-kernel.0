From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Jun 2013 22:42:54 +0200
Subject: [PATCH 8/8] ARM: ux500: move cpuidle drivers to drivers/cpuidle/
In-Reply-To: <1372241747-21083-9-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
 <1372241747-21083-9-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CACRpkda4NqFaniYP=bXZar+_0nM0c4b7OuKy4D_vYdfSORGQTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:15 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

--- a/arch/arm/mach-ux500/cpuidle
-#include "db8500-regs.h"
-#include "id.h"
> +++ b/drivers/cpuidle/cpuidle-ux500.c
(...)
> +#include "../../arch/arm/mach-ux500/db8500-regs.h"
> +#include "../../arch/arm/mach-ux500/id.h"

Well that was creative. NACK.

If you want to move the driver you need to come up with
proper interfaces making the move clean, not just move the files
and make them compile somewhere else I think.

Yours,
Linus Walleij
