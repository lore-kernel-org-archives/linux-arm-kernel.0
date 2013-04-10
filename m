From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Apr 2013 21:37:02 +0200
Subject: [PATCH 3/5] gpio/omap: optimise interrupt service routine
In-Reply-To: <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
Message-ID: <CACRpkdZ46vq6GOtS31DYSVZj44GawxT-PabqRr=0nmam6kBsTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:

> The OMAP GPIO interrupt service routine is checking each bit in the
> GPIO interrupt status register to see which bits are set. It is not
> efficient to check every bit especially if only a few bits are set.
> Therefore, instead of checking every bit use the __ffs() function,
> which returns the location of the first set bit, to find all the set
> bits.
>
> This optimisation was suggested-by and developed in collaboration
> with Felipe Balbi.
>
> Cc: Felipe Balbi <balbi@ti.com>
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Patch applied with Felipe's Reviewed-by tag.

Thanks,
Linus Walleij
