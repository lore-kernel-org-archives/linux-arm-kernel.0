From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Nov 2014 15:04:49 +0100
Subject: [PATCH v2 3/5] pinctrl: exynos: Fix GPIO setup failure because
 domain clock being gated
In-Reply-To: <1417011857-10419-4-git-send-email-k.kozlowski@samsung.com>
References: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
 <1417011857-10419-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdb8F8YcvFeHPvOKHjx_p4HEpimck3XRabB3oHpZTdmRQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 3:24 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> The audio subsystem on Exynos 5420 has separate clocks and GPIO. To
> operate properly on GPIOs the main block clock 'mau_epll' must be
> enabled.
>
> This was observed on Peach Pi/Pit and Arndale Octa (after enabling i2s0)
> after introducing runtime PM to pl330 DMA driver. After that commit the
> 'mau_epll' was gated, because the "amba" clock was disabled and there
> were no more users of mau_epll.
>
> The system hang just before probing i2s0 because
> samsung_pinmux_setup() tried to access memory from audss block which was
> gated.
>
> Add a clock property to the pinctrl driver and enable the clock during
> GPIO setup. During normal GPIO operations (set, get, set_direction) the
> clock is not enabled.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Waiting for Tomasz to review this.

Can this patch be applied in separation from the others?

Yours,
Linus Walleij
