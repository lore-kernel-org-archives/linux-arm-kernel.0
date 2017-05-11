From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 09:29:38 +0200
Subject: [PATCH 2/2] pinctrl: add ZTE ZX pinctrl driver support
In-Reply-To: <1493038873-18354-3-git-send-email-shawnguo@kernel.org>
References: <1493038873-18354-1-git-send-email-shawnguo@kernel.org>
 <1493038873-18354-3-git-send-email-shawnguo@kernel.org>
Message-ID: <CACRpkdaA6TsQqF1-88R5DJ5VYf6P1wGhsLR8Oee-hxH4sJ0Gng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 3:01 PM, Shawn Guo <shawnguo@kernel.org> wrote:

> From: Shawn Guo <shawn.guo@linaro.org>
>
> The pin controller on ZTE ZX platforms is kinda of hybrid.  It consists
> of a main controller and an auxiliary one.  For example, on ZX296718 SoC,
> the main controller is TOP_PMM and the auxiliary one is AON_IOCFG.  Both
> controllers work together to control pin multiplexing and configuration.
>
> For most of pins, the pinmux function is controlled by main controller
> only, and this type of pins are meant by term 'TOP pins'.  For other
> pins, the pinmux is controlled by both main and auxiliary controllers,
> as the available multiplexing functions for the pin spread in both
> controllers.  This type of pins are called 'AON pins'.  Though pinmux
> implementation is quite different, pinconf is same for both types of
> pins.  Both are controlled by auxiliary controller, i.e. AON_IOCFG on
> ZX296718.
>
> The patch adds the ZTE ZX core pinctrl driver to support this hybrid
> pin controller as well as ZX296718 SoC specific pin data.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Excellent work as usual Shawn.
Patch applied for v4.13.

Yours,
Linus Walleij
