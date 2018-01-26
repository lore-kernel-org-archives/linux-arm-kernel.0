From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Jan 2018 14:01:39 +0100
Subject: [PATCH] pinctrl: msm: allow the gpio base to be configurable
In-Reply-To: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
References: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkda6FLfUhqOPqJfCHm1PHOWg=CY=wOCDyrd78eMx+-zrZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

thanks for the patch!

On Thu, Jan 25, 2018 at 10:20 PM, Timur Tabi <timur@codeaurora.org> wrote:

> Add an integer to the msm_pinctrl_soc_data struct that pinctrl-msm
> client drivers can use to specify the gpio base.  This is useful
> if the client driver wants to register multiple TLMM devices, because
> each one needs a distinct base.

Sorry, but NACK.

> pinctrl-msm currently sets the base to 0, which ensures that GPIOs
> of the first TLMM are numbered 0..n-1.  It could specify -1 as the
> base, which would tell gpiolib to choose a unique base, but this
> has the side-effect of choosing a non-zero base for all TLMMs:

This is a feature not a bug. It encourages people not to
depend on the global GPIO numberspace.

Just set it to -1.

> gpiochip_find_base: found new base at 437
(...)
> gpiochip_find_base: found new base at 362

These are awesome bases, just beautiful. Use this.

If you don't like seeing GPIO base numbers like this: use things
like the chardev and the tools in tools/gpio or libgpiod when
developing, and you will never see them. They should not make
a difference anyway.

Yours,
Linus Walleij
