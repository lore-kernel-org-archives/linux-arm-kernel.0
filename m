From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 16:11:47 +0100
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <1450792017-7120-1-git-send-email-djkurtz@chromium.org>
References: <1450792017-7120-1-git-send-email-djkurtz@chromium.org>
Message-ID: <CACRpkdbRDzXunYK5d6Ld4Z2a=0mkp4KBvgL2P-St4P65Jajamw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 2:46 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:

> Move pinctrl initialization earlier in boot so that real devices can find
> their pctldev without probe deferring.
(...)
> -module_init(mtk_pinctrl_init);
> +arch_initcall(mtk_pinctrl_init);

So I see why you're doing this (because of wanting to avoid nasty boot
probe deferrals, right?) and I'm going to apply it, because the work
with probe ordering is still in the works, but I'd like some general
ARM people to come in with opinions.

Yours,
Linus Walleij
