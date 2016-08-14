From: robh+dt@kernel.org (Rob Herring)
Date: Sun, 14 Aug 2016 12:32:49 -0500
Subject: [PATCH RFC] Revert "of/irq: Mark initialised interrupt
 controllers as populated"
In-Reply-To: <E1bYVVh-0001eq-BI@rmk-PC.armlinux.org.uk>
References: <E1bYVVh-0001eq-BI@rmk-PC.armlinux.org.uk>
Message-ID: <CAL_JsqJNE7rGaL54HfmGEkaScZ7krf_iM55UrKw6mwWdLHv6Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 13, 2016 at 4:45 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:
> This reverts commit 15cc2ed6dcf91a8658e084be4e140147161819d7, which
> causes a regression with iMX6 power domains.  iMX6 GPC contains both an
> interrupt controller and power domains.  The iMX6 GPC code is setup to
> register an interrupt controller using IRQCHIP_DECLARE(), but then to
> register the power domains using the platform device.
>
> This commit prevents the platform device being created, thereby breaking
> iMX6 power domain support.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Please argue amongst yourselves about how to fix this regression caused
> by this commit...

There's already a fix for this in my tree and -next. I will be sending
to Linus soon.

Rob
