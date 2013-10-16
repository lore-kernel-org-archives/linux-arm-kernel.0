From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Oct 2013 13:46:08 +0200
Subject: [PATCH v2 4/5] pinctrl: rockchip: add rk3188 specifics
In-Reply-To: <201310160108.43199.heiko@sntech.de>
References: <201310160106.42329.heiko@sntech.de>
 <201310160108.43199.heiko@sntech.de>
Message-ID: <CACRpkdZo7bjADsG78yUw0bf1EPyqAXGh-6avt1zUkWeNOX8COQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 1:08 AM, Heiko St?bner <heiko@sntech.de> wrote:

> Besides the pull registers sitting in a separate place, the rk3188 also
> has the peculiarity that the pull registers of the first bank are split
> and the first half is sitting in the register space of the pmu.
>
> Therefore this adds a special bank-type for the first bank, to handle
> the two register sources.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Another way to do the same thing is to use drivers/mfd/syscon.c
and access it using a phandle.

But this seems to work fine as well so patch applied.

Yours,
Linus Walleij
