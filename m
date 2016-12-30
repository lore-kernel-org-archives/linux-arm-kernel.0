From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 13:55:44 +0100
Subject: [linux-sunxi] [PATCH 1/2] drivers: pinctrl: add driver for
 Allwinner H5 SoC
In-Reply-To: <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
References: <20161223125001.1176-1-icenowy@aosc.xyz>
 <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
Message-ID: <CACRpkdYQhfid3VRcaj=7as_+Zg=pX3Svp9FJ_W_Ft8nVuoZqKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2016 at 3:33 PM, Andr? Przywara <andre.przywara@arm.com> wrote:

> So while this patch technically looks correct, I was wondering if we
> should really explore the possibility of making the whole of sunxi
> pinctrl DT controlled.
> I brought this up a while ago, but people weren't overly enthusiastic
> about it, though their argument weren't really convincing to me[1].
>
> So:
> As this "driver" here is basically a table linking GPIO bit settings
> (the actual mux value) to names and every pin we care about needs to be
> enumerated in the DT anyway, why not just add something like:
> allwinner,pinmux = <4>;
> to each pin(group) in the DT and get rid of this "driver" file here
> entirely?

I'm open to that if you can use pinctrl-single which is in the kernel
for this purpose only, and is used with both OMAPs and HiSilicon.

It recently was improved and will be improved more in this cycle,
see for example:
commit 42124bc598f64f84b3335d5a058304207695b84f
pinctrl: Introduce generic #pinctrl-cells and pinctrl_parse_index_with_args

> (...) Also I guess the common sunxi
> pinctrl driver code needs some significant rework.

I would guess is just needs replacing with pinctrl-single in that case.

Yours,
Linus Walleij
