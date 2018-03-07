From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:42:57 +0100
Subject: [PATCH] ARM: ux500: Fix PMU IRQ regression
In-Reply-To: <20180307132033.4534-1-linus.walleij@linaro.org>
References: <20180307132033.4534-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a1iD_pPfpTw6R9TuPKf5sowfODgiROgjy9Zuc1qN=dg-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 2:20 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Commit 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")
> deleted some code to bounce and work around the weird PMU
> IRQs in the DB8500 ASIC, but did a semantic mistake:
> since the auxdata was now unused, the call to
> of_platform_populate() was removed, but this does not
> work: the default platform population will only kick in
> if .init_machine() is assigned NULL, and since the U8540
> was still using the callback that was not the case.
>
> Fix this by reinstating the call to of_platform_populate(),
> but pass NULL as auxdata.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please pick this up directly for fixed if
> Mark is OK with the fix. It'd be nice to have in v4.16 since
> it is a boot regression.

Applied to fixes, thanks!

        Arnd
