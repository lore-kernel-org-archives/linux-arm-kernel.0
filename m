From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 15:25:43 +0000
Subject: [PATCH 0/9] More ux500 multiplatform stuff
In-Reply-To: <CACRpkdbdmJrM48dPyV3zWpi6QLnVYcSTnkZbTDTXRSrd+pyVew@mail.gmail.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <201303221334.07330.arnd@arndb.de>
 <CACRpkdbdmJrM48dPyV3zWpi6QLnVYcSTnkZbTDTXRSrd+pyVew@mail.gmail.com>
Message-ID: <201303221525.43901.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Linus Walleij wrote:

> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index bc8f870..8eb8c49 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -2680,7 +2680,7 @@ static int db8500_irq_init(struct device_node
> *np, int irq_base)
>         int i;
> 
>         /* In the device tree case, just take some IRQs */
> -       if (!np)
> +       if (np)
>                 irq_base = 0;
> 
>         db8500_irq_domain = irq_domain_add_simple(

I think I dreamed about this bug last night but didn't remember
until now, and I had not looked there to confirm ;-)

> After this the U8500 and U8520 boot to prompt with all the patches
> applied!

Ah, very good.

	Arnd
