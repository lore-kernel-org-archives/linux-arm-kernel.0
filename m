From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 8 Aug 2012 23:24:40 +0800
Subject: [PATCH 2/6] ARM: pxa remove irq_to_gpio from eeti_ts driver
In-Reply-To: <1344430493-5304-3-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-3-git-send-email-arnd@arndb.de>
Message-ID: <CAN1soZwzSVe2VrTOod0ZtwF9UUS7fPYSt6Vkqgg4-6csUB3mqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 8:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The irq_to_gpio function was removed from the pxa platform
> in linux-3.2, and this driver has been broken since.
>
> Without this patch, building raumfeld_defconfig results in:
>
> drivers/input/touchscreen/eeti_ts.c: In function 'eeti_ts_irq_active':
> drivers/input/touchscreen/eeti_ts.c:65:2: error: implicit declaration of function 'irq_to_gpio' [-Werror=implicit-function-declaration]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org (v3.2+)
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/mach-pxa/raumfeld.c        |    1 +
>  drivers/input/touchscreen/eeti_ts.c |    8 +++++---
>  include/linux/input/eeti_ts.h       |    1 +
>  3 files changed, 7 insertions(+), 3 deletions(-)
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
