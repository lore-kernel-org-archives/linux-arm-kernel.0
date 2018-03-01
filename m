From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Mar 2018 23:33:01 +0100
Subject: [PATCH] pinctrl: samsung: Validate alias coming from DT
In-Reply-To: <20180220181751.20826-1-krzk@kernel.org>
References: <20180220181751.20826-1-krzk@kernel.org>
Message-ID: <CACRpkdbAhPdpRTx0P3yvazGgRvtUMmJ-qese1LFoCqNSPuR+sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 7:17 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Driver uses alias from Device Tree as an index of pin controller data
> array.  In case of a wrong DTB or an out-of-tree DTB, the alias could be
> outside of this data array leading to out-of-bounds access.
>
> Depending on binary and memory layout, this could be handled properly
> (showing error like "samsung-pinctrl 3860000.pinctrl: driver data not
> available") or could lead to exceptions.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 30574f0db1b1 ("pinctrl: add samsung pinctrl and gpiolib driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Issue is present since first version of this driver so this should be
> backported as far as possible.
>
> Tested on Odroid HC1 (Exynos5422). Tests on S3C24xx, S3C64xx, Exynos
> ARM64 and any other chips are highly appreciated.
>
> Linus,
> I can take it through samsung/pinctrl tree and later send you again as
> pull request... or you can apply it directly as I do not have any other
> pinctrl patches queued so far.

Patch applied for fixes with all the tags.

Yours,
Linus Walleij
