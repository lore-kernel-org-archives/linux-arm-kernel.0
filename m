From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Nov 2016 10:21:10 +0100
Subject: [PATCH v3 2/3] pinctrl: sunxi: Add support for fetching pinconf
 settings from hardware
In-Reply-To: <20161111095036.11803-3-wens@csie.org>
References: <20161111095036.11803-1-wens@csie.org>
 <20161111095036.11803-3-wens@csie.org>
Message-ID: <CACRpkdZXAZj5udrACxhaamhbUuHv0FM2=cqn8jsqPAznrW0+eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 10:50 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> The sunxi pinctrl driver only caches whatever pinconf setting was last
> set on a given pingroup. This is not particularly helpful, nor is it
> correct.
>
> Fix this by actually reading the hardware registers and returning
> the correct results or error codes. Also filter out unsupported
> pinconf settings. Since this driver has a peculiar setup of 1 pin
> per group, we can support both pin and pingroup pinconf setting
> read back with the same code. The sunxi_pconf_reg helper and code
> structure is inspired by pinctrl-msm.
>
> With this done we can also claim to support generic pinconf, by
> setting .is_generic = true in pinconf_ops.
>
> Also remove the cached config value. The behavior of this was never
> correct, as it only cached 1 setting instead of all of them. Since
> we can now read back settings directly from the hardware, it is no
> longer required.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
