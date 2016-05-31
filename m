From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 12:55:24 +0200
Subject: [PATCH 15/17] pinctrl: uniphier: allow to have pinctrl node under
 syscon node
In-Reply-To: <1464681923-7469-16-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
 <1464681923-7469-16-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZ3tLp3LeR6Q1YvgvKN8B0NuRzfcg_K+smo3_-TGCvr8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 10:05 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Currently, the UniPhier pinctrl driver itself is a syscon, but it
> turned out much more reasonable to make it a child node of a syscon
> because our syscon node consists of a bunch of system configuration
> registers, not only pinctrl, but also phy, and misc registers.
> It is difficult to split the node.
>
> To allow to migrate to the new DT structure, this commit adds new
> compatible strings to not disturb the existing DT.  After a while,
> the old binding will be removed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied, I guess if there is too much fuzz about the DT
bindings getting incompatible I would have to revert it.

Yours,
Linus Walleij
