From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Aug 2014 08:50:17 +0200
Subject: [PATCH v2] pinctrl: rockchip: fix rk3288 gpio0 configuration
In-Reply-To: <1406872680-14641-1-git-send-email-sonnyrao@chromium.org>
References: <1543632.JNPYWq24Lp@diego>
 <1406872680-14641-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <CACRpkdZdSObKamVC+MnVuCAhGjst07kc1P6dzQNTGMWUO+QrLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 1, 2014 at 7:58 AM, Sonny Rao <sonnyrao@chromium.org> wrote:

> On rk3288, for gpio bank 0, the registers which configure pull-up,
> iomux, and drive strength don't implement the enable bits in the upper
> half of the register, unlike the other gpio configuration registers,
> and so the kernel must perform a read-modify-write of the register to
> update a particular gpio in that bank.
>
> The current code is actually clobbering the contents of the register,
> so this fixes it by using regmap_update_bits and masking out only the
> bits which require updating.  In the case of bank0 on rk3288 the upper
> enable bits will just get ignored, and the other configurations won't
> get clobbered.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
> v2: rebase onto latest pinctrl with drive strength and fix this bug on
>   iomux and drive strength as well.

Patch applied with Heikos and Dougs review tags.

Thanks!
Linus Walleij
