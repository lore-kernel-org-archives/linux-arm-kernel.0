From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Sep 2012 19:05:58 +0200
Subject: [PATCH 1/3] gpio: 74x164: Add support for the daisy-chaining
In-Reply-To: <1347309341-15447-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1347309341-15447-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347309341-15447-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbo1sj6gbucoF3WVLbHzFXtddZiUQ-=h9gn-+A4Z7qBnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 10:35 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The shift registers have an output pin that, when enabled, propagates
> the values of its internal register to the pins. If another value comes
> to the register while the output pin is disabled, this new value will
> makae the older shift into the next register in the chain.
>
> This patch adds support for daisy-chaining the registers, using the
> regular SPI chip select mechanism to manage the output pin, and the
> registers-number dt property to set the number of chained registers.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

OK cool, but I just realized that this driver was added just two
years ago by Gabor and Miguel, so I'd like to get their feedback
before continuing.

I know I already merged the DT support and stuff, but better
late than never.

Please include them on future postings of patches to this
driver... (See To: line)

Miguel, Gabor: please look at this, I hope you can get hold
of the patches. Please also check the stuff I've already merged
here:
http://git.kernel.org/?p=linux/kernel/git/linusw/linux-gpio.git;a=shortlog;h=refs/heads/devel

Yours,
Linus Walleij
