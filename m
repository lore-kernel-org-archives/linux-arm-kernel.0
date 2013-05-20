From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 20:15:43 +0200
Subject: [PATCH] gpio: mxs: Use set and clear capabilities of the gpio
 controller
In-Reply-To: <1367244438-5322-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1367244438-5322-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbXHvhnmk=QfmmZiYwdVedP2P5zY12cqRtb6QfYCu3o=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 29, 2013 at 4:07 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The current driver doesn't use the set and clear registers found on the
> mxs gpio controller.
>
> This leads the generic gpio controller to be using some internal value
> to avoid looking up the value stored in the registers, making it behave
> pretty much like a cache.
>
> This raises some coherency problem when a gpio is not modified by the
> gpio controller, while it can easily be fixed by using the set and clear
> registers.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied for rc-fixes with Shawns ACK.

Yours,
Linus Walleij
