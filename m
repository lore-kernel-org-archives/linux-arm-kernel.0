From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Dec 2011 00:02:29 +0100
Subject: [PATCH V2 2/2] ARM: mmp: enable pinmux in platform driver
In-Reply-To: <1323769253-22580-3-git-send-email-haojian.zhuang@marvell.com>
References: <1323769253-22580-1-git-send-email-haojian.zhuang@marvell.com>
 <1323769253-22580-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdbqj0zyRP4skGm4EX0Hx1Axe5-wkC14Y6Ee_B9TFzy39g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 10:40 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> Only enable pinmux in brownstone/aspenite/ttc dkb.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

A very appetizing and appealing patch, this is looking *very good*.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

(But I guess you need the other patch to go in as well...)

> +static struct pinmux_map brownstone_pmx_map[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name = "dkin",
> + ? ? ? ? ? ? ? .ctrl_dev_name = "mmp2-pinmux",
> + ? ? ? ? ? ? ? .function = "dkin",
> + ? ? ? ? ? ? ? .group = "dkin-2-pin",
> + ? ? ? ? ? ? ? .hog_on_boot = true,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name = "uart1",
> + ? ? ? ? ? ? ? .ctrl_dev_name = "mmp2-pinmux",
> + ? ? ? ? ? ? ? .function = "uart1",
> + ? ? ? ? ? ? ? .group = "uart1-4-pin",
> + ? ? ? ? ? ? ? .hog_on_boot = true,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name = "uart2",
> + ? ? ? ? ? ? ? .ctrl_dev_name = "mmp2-pinmux",
> + ? ? ? ? ? ? ? .function = "uart2",
> + ? ? ? ? ? ? ? .group = "uart2-4-pin",
> + ? ? ? ? ? ? ? .hog_on_boot = true,
> + ? ? ? },

Looks like we want to add
#define PINMUX_MAP_SYS_HOG_GROUP() or so with four
arguments, what do you say Stephen? Shall I try to patch  in
something like that (then this patch will look even better).

> + ? ? ? PINMUX_MAP_SYS_HOG("uart3", "mmp2-pinmux", "uart3"),
> + ? ? ? PINMUX_MAP_SYS_HOG("twsi2", "mmp2-pinmux", "twsi2"),
(...)

Thanks,
Linus Walleij
