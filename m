From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Dec 2011 13:52:43 +0100
Subject: [PATCH 3/3] pinctrl: Don't create a device for each pin controller
In-Reply-To: <1323475145-26430-3-git-send-email-swarren@nvidia.com>
References: <1323475145-26430-1-git-send-email-swarren@nvidia.com>
 <1323475145-26430-3-git-send-email-swarren@nvidia.com>
Message-ID: <CACRpkdYSvgh9sY1WnWURh-O3u=d+Uu8X+GiAprJaVbEcTA2i7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 10, 2011 at 12:59 AM, Stephen Warren <swarren@nvidia.com> wrote:

> Pin controllers should already be instantiated as a device, so there's
> no need for the pinctrl core to create a new struct device for each
> controller.
>
> This allows the controller's real name to be used in the mux mapping
> table, rather than e.g. "pinctrl.0", "pinctrl.1", etc.

Hey cool, this "just works" on U300!

And it is what we want for future device tree work I highly suspect.

I'll push the change to linux-next!

Thanks,
Linus Walleij
