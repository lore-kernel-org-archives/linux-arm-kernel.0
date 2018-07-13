From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jul 2018 10:11:31 +0200
Subject: [PATCH] pinctrl: mt7622: fix probe fail by misuse the selector
In-Reply-To: <ddd18e427de47476722c945dc622571394192331.1531374468.git.sean.wang@mediatek.com>
References: <ddd18e427de47476722c945dc622571394192331.1531374468.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdYGPw0Vaaa1_0-vmFf0wdB6Wi+NLv4jDqDxCwJF9o6G=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 7:50 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> After the commit acf137951367 ("pinctrl: core: Return selector to the
> pinctrl driver") and the commit 47f1242d19c3 ("pinctrl: pinmux: Return
> selector to the pinctrl driver"), it's necessary to add the fixes
> needed for the pin controller drivers to use the appropriate returned
> selector for a negative error number returned in case of the fail at
> these functions. Otherwise, the driver would have a failed probe and
> that causes boot message cannot correctly output and devices fail
> to acquire their own pins.
>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Fixes: acf137951367 ("pinctrl: core: Return selector to the pinctrl driver")
> Fixes: 47f1242d19c3 ("pinctrl: pinmux: Return selector to the pinctrl driver")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Applied on top of Tony's patches on the fixes branch.

Now there are fixes piling on top of fixes and I am starting to feel
insecure of pushing this to v4.18 and I feel like letting these
fixes go to v4.19 (it can be picked to stable from there).

Tony: do you think there could be more fallout like this?

Yours,
Linus Walleij
