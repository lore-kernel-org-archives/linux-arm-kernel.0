From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 20:43:17 +0100
Subject: [PATCH 06/10] sh-pfc: Support GPIO to IRQ mapping specified IRQ
 resources
In-Reply-To: <1386732390-31724-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1386732390-31724-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CACRpkdaga82oQyhrztN0Js8ZTUXUpKV1zUreNDAfCD+ONdNA5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 4:26 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> On non-DT platforms IRQ controllers associated with the GPIOs have a
> fixed IRQ base value known at compile time. The sh-pfc driver translates
> GPIO number to IRQ numbers using a hardcoded table. This mechanism
> breaks on DT platforms, as the IRQ base values are dynamic in that case.
>
> Fix this by specifying IRQs associated with GPIOs in IRQ resources,
> populated automatically from the device tree. When IRQ resources are
> specified the driver requires one IRQ resource per GPIO able to generate
> an interrupt, and uses the translation table to compute the IRQ resource
> offset instead of the IRQ number.
>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Make things much better and only use standard bindings so
patch applied.

Yours,
Linus Walleij
