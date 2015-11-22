From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Nov 2015 13:15:00 +0100
Subject: [PATCH V4 07/26] coresight: moving PM runtime operations to core
 framework
In-Reply-To: <1447440317-1977-8-git-send-email-mathieu.poirier@linaro.org>
References: <1447440317-1977-1-git-send-email-mathieu.poirier@linaro.org>
 <1447440317-1977-8-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CACRpkdb50speJbhRYO5=nNzeo4tY00eKmsJZnbz_wc35ng-0Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 7:44 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:

> Moving PM runtime operations in Coresight devices enable() and
> disable() API to the framework core when a path is setup.  That
> way the runtime core doesn't have to be involved everytime a
> path is enabled.  It also avoids calling runtime PM operations
> in IRQ context.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Looks reasonable. The PM runtime part of coresight is not very
aggressive anyways, and I think the most important thing it does
is assure it does not consume any power (clocks etc) when it's
not in use.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Linus Walleij
