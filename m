From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Jun 2013 10:00:23 +0200
Subject: [PATCH] ARM: smp_twd: twd_update_frequency need be run on all
 online CPUs
In-Reply-To: <1371079180-22344-1-git-send-email-r64343@freescale.com>
References: <1371079180-22344-1-git-send-email-r64343@freescale.com>
Message-ID: <CACRpkdanMh=etQncxr7ekyiA_78buN6_sjvP5zEuoKbS3-JPFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 1:19 AM, Jason Liu <r64343@freescale.com> wrote:

> When the local timer freq changed, the twd_update_frequency function
> should be run all the CPUs include itself, otherwise, the twd freq will
> not get updated and the local timer will not run correcttly.
>
> smp_call_function will run functions on all other CPUs, but not include
> himself, this is not correct,use on_each_cpu instead to fix this issue.
>
> Signed-off-by: Jason Liu <r64343@freescale.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org

Mike Turquette wrote this code, so let him look at it.

But it makes sense to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please mark this for stable and put it into Russell's patch tracker
after allowing some time for others to have a look.

Yours,
Linus Walleij
