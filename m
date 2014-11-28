From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Nov 2014 09:06:59 +0100
Subject: [PATCH v2 2/2] pinctrl: rockchip: Fix enable/disable/mask/unmask
In-Reply-To: <1416437493-25588-3-git-send-email-dianders@chromium.org>
References: <1416437493-25588-1-git-send-email-dianders@chromium.org>
 <1416437493-25588-3-git-send-email-dianders@chromium.org>
Message-ID: <CACRpkdYjg3aVavgsS1Ccq5QEh1MFXafBn3zkF_hTTtm+rmt+og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 11:51 PM, Doug Anderson <dianders@chromium.org> wrote:

> The Rockchip pinctrl driver was only implementing the "mask" and
> "unmask" operations though the hardware actually has two distinct
> things: enable/disable and mask/unmask.  It was implementing the
> "mask" operations as a hardware enable/disable and always leaving all
> interrupts unmasked.
>
> I believe that the old system had some downsides, specifically:
> - (Untested) if an interrupt went off while interrupts were "masked"
>   it would be lost.  Now it will be kept track of.
> - If someone wanted to change an interrupt back into a GPIO (is such a
>   thing sensible?) by calling irq_disable() it wouldn't actually take
>   effect.  That's because Linux does some extra optimizations when
>   there's no true "disable" function: it does a lazy mask.
>
> Let's actually implement enable/disable/mask/unmask properly.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v2:
> - Spread out code (heiko)

Patch applied.

Yours,
Linus Walleij
