From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Aug 2011 15:23:05 +0200
Subject: [PATCH] mach-davinci: fix cache flush build error
In-Reply-To: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
References: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdYhrTt9N1coaYvsv7KNiRySRzTmRPPL2qAWU0bjFwgjCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 2, 2011 at 5:48 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> The TNET variant of DaVinci compiles some code that it shares
> with other DaVinci variants, however it has a V6 CPU rather than
> an ARM926T, thus the hardcoded call to arm926_flush_kern_cache_all()
> in sleep.S will obviously fail, and we need to build with the
> v6_flush_kern_cache_all() call instead. This was triggered by
> manually altering the DaVinci config to build the TNET version.
>
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Arnd can you pick this patch to some suitable arm-soc branch like fixes?
Atleast it makes the DaVinci variants compile one by one.

Thanks,
Linus Walleij
