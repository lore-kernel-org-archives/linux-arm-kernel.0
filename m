From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 18:45:10 +0100
Subject: [PATCH] serial: pl010/pl011: move clk_enable from console write
 to setup
In-Reply-To: <1359475526-17523-1-git-send-email-walimisdev@gmail.com>
References: <1359475526-17523-1-git-send-email-walimisdev@gmail.com>
Message-ID: <CACRpkdbEMO0wuDDXcd6oW6Jnn3LBhATBdcoHJEAdg7MrU6h-jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 5:05 PM, Liming Wang <walimisdev@gmail.com> wrote:

> There seems no need to call clk_enable in every console writing. And we
> can move clk_enable to setup function to enable the clock only once.
> Also combine the clk_enable and clk_prepare to clk_prepare_enable.
>
> Signed-off-by: Liming Wang <walimisdev@gmail.com>

NAK.

Consider the case where the console outputs nothing or
a string every 30 minutes. Why should we not gate off the
clock between these sporadic prints?

Yours,
Linus Walleij
