From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 12:48:05 -0700
Subject: [PATCH] ARM: nomadik: fix up double inversion in DT
In-Reply-To: <1406283522-6764-1-git-send-email-linus.walleij@linaro.org>
References: <1406283522-6764-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140730194805.GD18384@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 12:18:42PM +0200, Linus Walleij wrote:
> The GPIO pin connected to card detect was inverted twice: once by
> the argument to the GPIO line itself where it was magically marked
> as active low by the flag GPIO_ACTIVE_LOW (0x01) in the third cell,
> and also marked active low AGAIN by explicitly stating
> "cd-inverted" (a deprecated method).
> 
> After commit 78f87df2b4f8760954d7d80603d0cfcbd4759683
> "mmc: mmci: Use the common mmc DT parser" this results in the
> line being inverted twice so it was effectively uninverted, while
> the old code would not have this effect, instead disregarding the
> flag on the GPIO line altogether, which is a bug. I admit the
> semantics may be unclear but inverting twice is as good a
> definition as any on how this should work.
> 
> So fix up the buggy device tree. Use proper #includes so the DTS
> is clear and readable.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please either apply this directly for fixes, and if
> that is too late, tag it for v3.16+ stable.

Applied to fixes, Arnd must have missed it earlier.


-Olof
