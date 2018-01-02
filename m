From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jan 2018 10:16:35 +0100
Subject: [PATCH 0/3] [v11] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <20171228161556.GG7997@codeaurora.org>
References: <1513797033-9494-1-git-send-email-timur@codeaurora.org>
 <CACRpkdYtMbACG0D2zjgw-kN_3pb_VDGH_3DDhyMQD92eE5P0Gw@mail.gmail.com>
 <20171227020142.GZ7997@codeaurora.org>
 <CACRpkda5FQg3W4rnxihVB9y2yv-oF1CwBzFJsKB8cxzQ+zoHNg@mail.gmail.com>
 <20171228161556.GG7997@codeaurora.org>
Message-ID: <CACRpkdYhryd2qKxagw+orpUQaYCKU-x6RH5OB+pr_PTfzBaPng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 5:15 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Patch 1 is still needed. Without that patch, we'll be poking each
> GPIO to figure out the direction at boot without checking any
> valid mask or calling the request APIs.

Aha, I just thought you'd augment that code to take valid GPIOs
into account.

Anyways, I left the patch in, so no worries.

> I don't see the part in
> debugfs where we show the direction of a GPIO if it hasn't been
> requested. Don't we skip over the unrequested GPIOs because of
> this code in gpiolib_dbg_show()?
>
>         if (!test_bit(FLAG_REQUESTED, &gdesc->flags)) {
>                 ...
>                 continue;
>         }

Yes you're right. This is more for lsgpio and the chardev side
of things for inspecting lines really.

Yours,
Linus Walleij
