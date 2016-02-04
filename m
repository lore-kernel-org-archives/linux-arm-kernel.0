From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Feb 2016 13:24:04 -0800
Subject: [PATCH] ARM: nomadik: fix up SD/MMC DT settings
In-Reply-To: <1454332737-631-1-git-send-email-linus.walleij@linaro.org>
References: <1454332737-631-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160204212404.GA10600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 02:18:57PM +0100, Linus Walleij wrote:
> The DTSI file for the Nomadik does not properly specify how the
> PL180 levelshifter is connected: the Nomadik actually needs all
> the five st,sig-dir-* flags set to properly control all lines out.
> 
> Further this board supports full power cycling of the card, and
> since this variant has no hardware clock gating, it needs a
> ridiculously low frequency setting to keep up with the ever
> overflowing FIFO.
> 
> The pin configuration set-up is a bit of a mystery, because of
> course these pins are a mix of inputs and outputs. However the
> reference implementation sets all pins to "output" with
> unspecified initial value, so let's do that here as well.
> 
> Cc: stable at vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: this fixes the non-working SD/MMC card on the
> Nomadik please apply this directly for fixes if Ulf is OK with
> it.

Thanks, applied.


-Olof
