From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Sep 2017 22:42:44 +0200
Subject: [PATCH] arm64: dts: hikey960: Update HiKey960 with GPIO line names
In-Reply-To: <20170929203020.24879-1-linus.walleij@linaro.org>
References: <20170929203020.24879-1-linus.walleij@linaro.org>
Message-ID: <CACRpkdbZgDyHd9mPrOCQ2Mk4qe8+mvN6p-XPVir4TBM239A8qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 10:30 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> This adds line names for all the GPIOs I could identify on the HiKey960
> schematic.
>
> "GPIO-A" through "GPIO-L" are the most important since they give users
> a handle to look up the standard 96boards GPIOs from the GPIO character
> device.
>
> The rest of the names are more informational, nice debug information
> for "lsgpio" so you can see that the right line is taken for the right
> function in the kernel for example.
>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Zhangfei Gao <zhangfei.gao@hisilicon.com>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I just noticed that the recently merhed Poplar board has these GPIO
lines named "LS-GPIO-A" etc.

We have to decide for one format. Either "LS-GPIO-A" or just "GPIO-A"
and change all the others (including this patch).

The namespace needs to be consistent across all 96boards.

Wei et al: what do you prefer? I can fix it up either way.

If we want it "LS-GPIO-A" then we need to patch up the old 6220
DTS as well.

Yours,
Linus Walleij
