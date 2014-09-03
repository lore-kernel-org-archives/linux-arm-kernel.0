From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Sep 2014 09:02:46 -0600
Subject: [PATCH] pinctrl: clean up after enable refactoring
In-Reply-To: <1409742329-17411-1-git-send-email-linus.walleij@linaro.org>
References: <1409742329-17411-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <54072D96.6070906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2014 05:05 AM, Linus Walleij wrote:
> commit 2243a87d90b42eb38bc281957df3e57c712b5e56
> "pinctrl: avoid duplicated calling enable_pinmux_setting for a pin"
> removed the .disable callback from the struct pinmux_ops,
> making the .enable() callback the only remaining callback.
>
> However .enable() is a bad name as it seems to imply that a
> muxing can also be disabled. Rename the callback to .set_mux()
> and also take this opportunity to clean out any remaining
> mentions of .disable() from the documentation.

Acked-by: Stephen Warren <swarren@nvidia.com>
