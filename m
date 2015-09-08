From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Sep 2015 16:14:30 +0200
Subject: [PATCH] gpio: omap: Fix GPIO numbering for deferred probe
In-Reply-To: <1441301487-6238-1-git-send-email-tony@atomide.com>
References: <1441301487-6238-1-git-send-email-tony@atomide.com>
Message-ID: <CACRpkdZFyt5KvfYu2GwdmMJmQtG1MiNXVkqHLRD=nZauK2ww3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2015 at 7:31 PM, Tony Lindgren <tony@atomide.com> wrote:

> If gpio-omap probe fails with -EPROBE_DEFER, the GPIO numbering
> keeps increasing. Only increase the gpio count if gpiochip_add()
> was successful as otherwise the numbers will increase for each
> probe attempt.
>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied with Grygorii's review tag.

Yours,
Linus Walleij
