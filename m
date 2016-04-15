From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Apr 2016 10:29:04 +0200
Subject: [PATCH v2] pinctrl: mediatek: correct debounce time unit in
 mtk_gpio_set_debounce
In-Reply-To: <1459580269-64531-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1459580269-64531-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CACRpkdZT0xMDwwnQRvC1Q76yvBGoJnU1w_rSP8XcmKRnCQpnKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 2, 2016 at 8:57 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:

> The debounce time unit for gpio_chip.set_debounce is us but
> mtk_gpio_set_debounce regard it as ms.
> Fix this by correct debounce time array dbnc_arr so it can find correct
> debounce setting. Debounce time for first debounce setting is 500us,
> correct this as well.
>
> While I'm at it, also change the debounce time array name to
> "debounce_time" for readability.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
> This was based on v4.6-rc1
> Change since v1:
> - Improve commit message.
> - Change dbnc_arr name to debounce_time

Patch applied to fixes and tagged for stable.

Yours,
Linus Walleij
