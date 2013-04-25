From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:57:50 +0200
Subject: [PATCH 4/9 v2] crypto: ux500/cryp - Prepare clock before enabling
 it
In-Reply-To: <20130419122226.GB3432@gmail.com>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-5-git-send-email-lee.jones@linaro.org>
 <20130419122226.GB3432@gmail.com>
Message-ID: <CACRpkdZT-XFyDExKVppWi4NEN7XptSex10LCtAHOpZD71nom3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 2:22 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Slight change of plan for v2.
>
> Now we're doing a seperate clk_prepare(), as the clk_enable() in the
> previous patch turned out to be called inside a spin_lock().
>
> Arnd, can you confirm your Ack please?
>
> ----
>
> crypto: ux500/cryp - Prepare clock before enabling it
>
> If we fail to prepare the ux500-cryp clock before enabling it the
> platform will fail to boot. Here we insure this happens.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Same formatting problems as the other prepare/enable
patch. Include Ulf Hansson.

(Apart from this it looks OK.)

Yours,
Linus Walleij
