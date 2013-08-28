From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 08:49:28 +0200
Subject: [PATCH 03/18] dmaengine: PL08x: Rework LLI handling to be less
 fragile
In-Reply-To: <1376243970-6489-4-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-4-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdYYWZppS8pPZKejxe-RCOTkA786+k76gmsrn8jX+6ZP_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 7:59 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Currently memory allocated for LLIs is casted to an array of structs,
> which is fragile and also limits the driver to a single, predefined LLI
> layout, while there are some variants of PL08x, which have more fields
> in LLI (namely PL080S with its extra CCTL2).
>
> This patch makes LLIs a sequence of 32-bit words, which is just filled
> with appropriate values in appropriate order and padded with required
> amount of dummy words (currently zero, but PL080S will make better use
> of this).
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Yes exactly like this :-)

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
