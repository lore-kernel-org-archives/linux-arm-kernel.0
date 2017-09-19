From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Sep 2017 10:15:50 +0200
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <20170919070422.GI3349@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
Message-ID: <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 9:04 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Perhaps we can add another hook for our purposes here that
> tells gpiolib that the gpio is not usable and to skip it. The
> semantics would be clear, it's just about probing availability of
> this pin as a gpio and doesn't mux any pins.

Oh we already have that I think, Mika Westerberg and Andy Shevcheno
implemented that for anyone using CONFIG_GPIOLIB_IRQCHIP, and
this driver does. Timur please check: irq_need_valid_mask, irq_valid_mask
usage.

Helpful commits:
commit 49c03096263871a68c9dea3e86b7d1e163d2fba8
"pinctrl: baytrail: Do not add all GPIOs to IRQ domain"

Then you can see in commits:
commit 7036502783729c2aaf7a3c24c89087c58721430f
"pinctrl: cherryview: Add a quirk to make Acer Chromebook keyboard work again"
commit 2a8209fa68236ad65363dba03db5dbced520268a
"pinctrl: cherryview: Extend the Chromebook DMI quirk to Intel_Strago systems"

How this valid mask is used to work around specific ACPI
issues on Intel chips.

I bet a million to one that you have the same problems as them,
and then we should also deal with it the same way.

Sorry for not seeing the obvious connection earlier.

Yours,
Linus Walleij
