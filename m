From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 11:34:49 +0200
Subject: [PATCH 1/3] pinctrl: samsung: Constify wakeup driver specific data
In-Reply-To: <20170523184141.24284-1-krzk@kernel.org>
References: <20170523184141.24284-1-krzk@kernel.org>
Message-ID: <CACRpkdYN20Q3qcBtORPArCMfdTCGWNoHsyRyB9EYOXiwqN0Miw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 8:41 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Static exynos_irq_chip structures, containing driver specific data, are
> referenced only through opaque data pointer in const of_device_id table.
> The contents of pointed memory (exynos_irq_chip structure itself) is
> then copied with kmemdup() during wakeup initialization so
> exynos_irq_chip can be made const for code safenes.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

All looks good to me, Acked-by.

Expecting to get this in a pull request.

Yours,
Linus Walleij
