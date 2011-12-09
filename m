From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Dec 2011 15:01:04 +0100
Subject: [RFC 1/3] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <1323382390-14892-2-git-send-email-swarren@nvidia.com>
References: <1323382390-14892-1-git-send-email-swarren@nvidia.com>
 <1323382390-14892-2-git-send-email-swarren@nvidia.com>
Message-ID: <CACRpkdYDn0V7SeQuFiFDMxGkybvg6PGf7jxid8ECGB7Azkj3zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 8, 2011 at 11:13 PM, Stephen Warren <swarren@nvidia.com> wrote:

> This adds a driver for the Tegra pinmux, and required parameterization
> data for Tegra20 and Tegra30.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

This is looking good from a framework point of view (obviously,
since you've designed the framework with me you sure know what
you're doing).

What we could worry about is the amount of hard-coded chip data
which sort of correlates with the discussion with Tony on how to
provide DT info for pin control drivers.

If say this same controller appear in Tegra 4 with no changes but
different pin names, it makes sense to try to push this into the
DT as soon as possible, so as to avoid the situation Tony is
having with the OMAP muxes. If Tegra 4 will be all-new and not even
related, it doesn't.

So, just think a bit about it.

It will fit way better here than any place under
arch/arm/* in any case, so it's a great achievement!

Yours,
Linus Walleij
