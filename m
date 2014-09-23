From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 17:02:35 +0200
Subject: [PATCH] pinctrl: berlin: fix the dt_free_map function
In-Reply-To: <1410340551-24023-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1410340551-24023-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdbtoOmBE4thmegDDR1Ev+9+Neq5j8z2Nr5MDi_P7yA2hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 11:15 AM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:

> The berlin_pinctrl_dt_free_map function tries to free memory
> allocated and handled by the of subsystem. This is wrong and
> already handled by pinctrl_dt_free_maps() which calls
> of_node_put().
>
> This patch fixes the Berlin pinctrl way of freeing its maps,
> avoiding a kernel BUG(), by using the common
> pinctrl_utils_dt_free_map function instead.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Patch applied with Sebastian's ACK.

Yours,
Linus Walleij
