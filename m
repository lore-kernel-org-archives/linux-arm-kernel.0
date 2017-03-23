From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 11:22:54 +0100
Subject: [PATCH] ARM: gemini: don't select SERIAL_OF_PLATFORM
In-Reply-To: <20170321205310.188381-1-arnd@arndb.de>
References: <20170321205310.188381-1-arnd@arndb.de>
Message-ID: <CACRpkdYfi2_Tu+RD+s=xR8pHkp0bQ96pB4BSJdA1bO4kdwku5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 9:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> We cannot select the option when SERIAL_8250 is not also set:
>
> warning: (ARCH_GEMINI) selects SERIAL_OF_PLATFORM which has unmet direct dependencies (TTY && HAS_IOMEM && SERIAL_8250 && OF)
>
> This removes the 'select' statement, requiring that users enable the
> option manually. Alternatively, we could make it a conditional
> 'select SERIAL_OF_PLATFORM if SERIAL_8250' or also select a handful
> of other symbols that it depends on.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Will you apply this directly to the interestingly misspelled
"gemeni/multiplatform" branch in the ARM SoC tree
directly?

I will send pull requests on top of that branch later
for more features.

Yours,
Linus Walleij
