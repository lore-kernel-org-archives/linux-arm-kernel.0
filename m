From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Jul 2018 15:23:08 +0200
Subject: [PATCH v3 3/6] pinctrl: Support stopping deferred probe after
 initcalls
In-Reply-To: <20180628204344.13973-4-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
 <20180628204344.13973-4-robh@kernel.org>
Message-ID: <CACRpkdZU50xG-seDq8pZ0QLBXzn_Ygs-s1rJXGqzpfDJGbjDtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 10:43 PM Rob Herring <robh@kernel.org> wrote:

> Pinctrl drivers are a common dependency which can prevent a system
> booting even if the default or bootloader configured settings can work.
> If a pinctrl node in DT indicates that the default pin setup can be used
> with the 'pinctrl-use-default' property, then only defer probe until
> initcalls are done. If the deferred probe timeout is enabled or loadable
> modules are disabled, then we'll stop deferring probe regardless of the
> DT property. This gives platforms the option to work without their
> pinctrl driver being enabled.
>
> Dropped the pinctrl specific deferring probe message as the driver core
> can print deferred probe related messages if needed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
> - Drop pinctrl deferred probe msg in favor of driver core messages
> - Move the handling of "pinctrl-use-default" option out of driver core
> - Stop deferring probe if modules are not enabled.
>
> Linus, I reworked this a bit, so didn't add your ack.

Looks even better now:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
