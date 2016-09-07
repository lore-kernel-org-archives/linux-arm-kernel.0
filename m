From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 00:18:13 +0200
Subject: [PATCH v2] gpio/gpiolib: Forbid irqchip default trigger if probed
 over DT
In-Reply-To: <1473235931-19079-1-git-send-email-marc.zyngier@arm.com>
References: <1473235931-19079-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdbXkbNq5JnM83doZMt5H_JSd-1fQ_kbv_k3HAe2QM71yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 10:12 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Using a default trigger is a bad idea if using DT to configure
> interrupts, as the device's interrupt specifier will always contain
> the trigger configuration.
>
> Let's warn about that particular situation, and revert to not
> having a default. Hopefully, the couple of drivers still using
> this feature will quickly be fixed.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Send the tested patch this time around...

I got it the first time, don't worry :D

Yours,
Linus Walleij
