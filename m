From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 15:16:52 +0100
Subject: [PATCH] pinctrl: sunxi: Don't enforce bias disable (for now)
In-Reply-To: <20170123082130.15558-1-maxime.ripard@free-electrons.com>
References: <20170123082130.15558-1-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbx7nYUKasAGQS8Hc0DZ_oeSbTc3sXnsUVGga8MyvuMFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 9:21 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Commit 07fe64ba213f ("pinctrl: sunxi: Handle bias disable") actually
> enforced enforced the disabling of the pull up/down resistors instead of
> ignoring it like it was done before.
>
> This was part of a wider rework to switch to the generic pinconf bindings,
> and was meant to be merged together with DT patches that were switching to
> it, and removing what was considered default values by both the binding and
> the boards. This included no bias on a pin.
>
> However, those DT patches were delayed to 4.11, which would be fine only
> for a significant number boards having the bias setup wrong, which in turns
> break the MMC on those boards (and possibly other devices too).
>
> In order to avoid conflicts as much as possible, bring back the old
> behaviour for 4.10, and we'll revert that commit once all the DT bits will
> have landed.
>
> Tested-by: Priit Laes <plaes@plaes.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Hi Linus,
>
> This is intended as a fix for 4.10.

Patch applied for fixes with Chen-Yu's ACK.

Yours,
Linus Walleij
