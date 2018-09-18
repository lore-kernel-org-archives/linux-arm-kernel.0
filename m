From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 12:36:18 -0700
Subject: [PATCH v2 01/22] pinctrl: mediatek: add pinctrl-mtk-common-v2 for
 all MediaTek pinctrls
In-Reply-To: <75d8f8c745d60b49ee1ec60de7f776ef51f97f79.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <75d8f8c745d60b49ee1ec60de7f776ef51f97f79.1536404280.git.sean.wang@mediatek.com>
Message-ID: <CACRpkdaLc8i0QtpqsBJVLmcRewahRWKqkr5vys8_w0Ld0gEc7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Irregular register arrangement and distinct logic access from various
> MediaTek SoCs would cause pinctrl-mtk-common to bloat and really hard to
> maintain in the future so that the patch creates pinctrl-mtk-common-v2
> based on the core of mt7622-pinctrl.
>
> The goals pinctrl-mtk-common-v2 want to achieve are to hopefully support
> all of MediaTek SoCs, and two kinds of dt-bindings being supported,
> Linux generic pinctrl dt-binding mt7622 supports and MediaTek per-pin
> dt-binding the other SoCs support the MT8183 and MT6765 incline to make
> use of.
>
> The patch starts to refactor MT7622 pinctrl driver first with splitting
> out these portable ways from there such as table-based register operation
> and drive strength control that is common in both kinds of driver.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied, had to use some fuzzing and removed a <linux/gpio.h>
include that was not used.

Yours,
Linus Walleij
