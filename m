From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2016 12:18:35 -0700
Subject: [PATCH] ARM: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
In-Reply-To: <1464869416-5642-1-git-send-email-linus.walleij@linaro.org>
References: <1464869416-5642-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160603191835.GC3761@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 02:10:16PM +0200, Linus Walleij wrote:
> This replaces:
> 
> - "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
>   now be selected directly.
> 
> - "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
>   is now selectable by everyone, so we need not declare our
>   intent to select it.
> 
> When ordering the symbols the following rationale was used:
> if the selects were in alphabetical order, I moved select GPIOLIB
> to be in alphabetical order, but if the selects were not
> maintained in alphabetical order, I just replaced
> "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB".
> 
> Cc: Michael B??sch <m@bues.ch>
> Cc: arm at kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC maintainers:
> Please apply this patch directly for cleanups.

Thanks, applied to next/cleanup for 4.8!


-Olof
