From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Mar 2017 11:18:31 +0200
Subject: [PATCH v4 3/4] pinctrl: rockchip: split out verification of mux
 settings
In-Reply-To: <20170323105931.10455-4-john@metanate.com>
References: <20170323105931.10455-1-john@metanate.com>
 <20170323105931.10455-4-john@metanate.com>
Message-ID: <CACRpkda27uiDc_E-4Vkq8iT4FG0hXbirAjOva3w9YhacYJ8nvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 11:59 AM, John Keeping <john@metanate.com> wrote:

> We need to avoid calling regmap functions from irq handlers, so the next
> commit is going to move the call to rockchip_set_mux() into an
> irq_bus_sync_unlock handler.  But we can't return an error from there so
> we still need to check the settings from rockchip_irq_set_type() and we
> will use this new rockchip_verify_mux() function from there.
>
> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v3: unchanged
> v2: unchanged

Patch applied.

Yours,
Linus Walleij
