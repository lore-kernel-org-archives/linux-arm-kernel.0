From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Feb 2016 23:04:26 +0100
Subject: [PATCH] pinctrl: sunxi: set pin function as input on export
In-Reply-To: <1454942242-25690-1-git-send-email-krzysztof.adamski@tieto.com>
References: <1454942242-25690-1-git-send-email-krzysztof.adamski@tieto.com>
Message-ID: <CACRpkdbd4f3yj2MnR6PU5SuhV5Tj4HzWLc0UX8jQkcJp7MoTig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2016 at 3:37 PM, Krzysztof Adamski
<krzysztof.adamski@tieto.com> wrote:

> Default function of a pin in sunxi SoCs is "disabled". By default gpios
> exported by sysfs are set as input and indeed, when reading "direction"
> file you will get "in". The "value" pin won't return proper value,
> though, confusing user of this interface.
>
> This patch sets direction of a GPIO as input when exporting it.
>
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@tieto.com>

As maxime says it's not a sunxi problem.

So maybe it is wrong to set pins to either input or output when
exporting them, I suspect they should be exported as is.

Also: the sysfs ABI is deprecated. I suggest you invest your time
in working on the new chardev ABI.

Yours,
Linus Walleij
