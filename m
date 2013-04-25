From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:46:22 +0200
Subject: [PATCH 32/32] ARM: ux500: Move SDI (MMC) and UART devices under
 more descriptive heading
In-Reply-To: <1366279934-30761-33-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-33-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbxwPh+j_=CBFeH83n0XHSbcShnZ7Reb54+5cWYL-j3-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now DMA DT bindings exist and are in use by he MMC and UART drivers, it
> should be possible to remove them from the auxdata structure. However,
> after doing so the drivers fail. Something must be reliant on the dev
> name applied by using auxdata; probably common clk.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

You can remove "probably" from that sentence. Common clock is
still relying on dev_name() to match the device name.

There are some example of how to fix this, I recently sent a patch
series fixing DT probed clocks for the Nomadik, check it out.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
