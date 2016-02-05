From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 Feb 2016 17:45:12 +0800
Subject: [PATCH v3 5/5] pinctrl: sunxi: Use pin number when calling
 sunxi_pmx_set
In-Reply-To: <1454542430-16572-6-git-send-email-k@japko.eu>
References: <1454542430-16572-1-git-send-email-k@japko.eu>
 <1454542430-16572-6-git-send-email-k@japko.eu>
Message-ID: <CAGb2v67Wd_ZSJEdKm7b6dRzqAzGO3i61c1akVH+62xYnRF8Sfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2016 at 7:33 AM, Krzysztof Adamski <k@japko.eu> wrote:
> sunxi_pmx_set accepts pin number and then calculates offset by
> subtracting pin_base from it. sunxi_pinctrl_gpio_get, on the other hand,
> gets offset so we have to convert it to pin number so we won't get
> negative value in sunxi_pmx_set.
>
> This was only used on A10 so far, where there is only one GPIO chip with
> pin_base set to 0 so it didn't matter. However H3 also requires this
> workaround but have two pinmux sections, triggering problem for PL port.
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

Acked-by: Chen-Yu Tsai <wens@csie.org>

(resent as my mail setup failed to deliver)
