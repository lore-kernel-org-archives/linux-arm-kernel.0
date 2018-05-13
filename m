From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 13 May 2018 17:23:34 +0300
Subject: [PATCH v3 3/3] tty: implement led triggers
In-Reply-To: <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
Message-ID: <CAHp75Vf0RmAU8Qvk13JkFJob95pBEv27o4k8FVKo+0vs-SxYRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2018 at 1:05 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> The rx trigger fires when data is pushed to the ldisc by the driver. This
> is a bit later than the actual receiving of data but has the nice benefit
> that it doesn't need adaption for each driver and isn't in the hot path.
>
> Similarly the tx trigger fires when data was copied from userspace and is
> given to the ldisc.

>  #include <uapi/linux/tty.h>
>  #include <linux/rwsem.h>
>  #include <linux/llist.h>
> +#include <linux/leds.h>

Even for unordered lists of inclusions I would still try to put new
lines in "somehow" ordered positions.
For example here, I would rather put it before llist.h.

-- 
With Best Regards,
Andy Shevchenko
