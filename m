From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 14 Nov 2014 16:59:55 +0400
Subject: [PATCH RESEND] ARM: sa1100 collie: use gpio-charger instead of
 pda-power
In-Reply-To: <1415258831-17239-1-git-send-email-dbaryshkov@gmail.com>
References: <1415258831-17239-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CALT56yM_Z2FzUfvtRfvUTgHCH4yvuSbt0xdPn=tDt_uByTYt=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-06 10:27 GMT+03:00 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>:
> Use gpio-charger driver instead of pda-power: it automatically cares
> about used gpio and since collie does not differentiate between usb and
> ac chargers, pda-power is an overkill for it.
>
> As a bonus this allows us to remove gpio_to_irq calls from machine init
> call - it is fragile. These gpio_to_irq calls will fail if gpios are
> registered later, via device driver mechanisms.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-sa1100/collie.c | 55 ++++++-------------------------------------
>  1 file changed, 7 insertions(+), 48 deletions(-)

Russell, still no reaction from your side. Can I submit this patch to
your patch tracker?

-- 
With best wishes
Dmitry
