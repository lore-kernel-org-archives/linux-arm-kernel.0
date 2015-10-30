From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Oct 2015 10:42:49 +0100
Subject: [PATCH] pinctrl-zynq: Initialize early
In-Reply-To: <1445513420-23527-1-git-send-email-mike.looijmans@topic.nl>
References: <1445513420-23527-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <CACRpkdZPyOkYZuSKyZucU6KEYg=4TePRDe3H=Z3pNxr2wrdr-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 1:30 PM, Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Supplying pinmux configuration for e.g. gpio pins leads to deferred
> probes because the pinctrl device is probed much later than gpio.
> Move the init call to a much earlier stage so it probes before the
> devices that may need it.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Patch applied with S?ren's Tested-by tag.

I am liberal with initcall reordering because I think the deferred
probe mechanism is not really working.

Take some time to review Rafael Wysocki's latest device link
concept that can get initcall reordering closer to the device core.

Yours,
Linus Walleij
