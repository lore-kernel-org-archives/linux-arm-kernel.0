From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Apr 2017 10:01:52 +0200
Subject: [PATCH v2 02/30] pinctrl: mediatek: reuse pinctrl driver for
 mt7623
In-Reply-To: <1493198774-4478-3-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
 <1493198774-4478-3-git-send-email-sean.wang@mediatek.com>
Message-ID: <CACRpkdbR-k3wgD+7KoV6d7yg1uduXpa9MO0+woEibQYPeYzgYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 11:25 AM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> mt7623 pinctrl driver can be compatible with mt2701 one,
> so the patch reuses the driver and deletes those redundant
> ones.
>
> Cc: John Crispin <john@phrozen.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Partly correct.

>         "mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
> -       "mediatek,mt7623-pinctrl", compatible with mt7623 pinctrl.

NO don't do this.

"compatible" means exactly this: this hardware is compatible with
this driver. That is why we have it!

So instead of mt7623 pretending to be mt2701, let the mt2701 driver
list that it is compatible with mt7623, simple.

So patch pinctrl-mt2701.c mt2701_pctrl_match[] instead.

Yours,
Linus Walleij
