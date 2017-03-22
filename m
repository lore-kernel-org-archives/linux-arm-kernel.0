From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Mar 2017 17:29:40 -0700
Subject: [PATCH] ARM: dts: Adjust moxart IRQ controller and flags
In-Reply-To: <20170318164001.4967-1-linus.walleij@linaro.org>
References: <20170318164001.4967-1-linus.walleij@linaro.org>
Message-ID: <20170322002940.GA5129@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 05:40:01PM +0100, Linus Walleij wrote:
> The moxart interrupt line flags were not respected in previous
> driver: instead of assigning them per-consumer, a fixes mask
> was set in the controller.
> 
> With the migration to a standard Faraday driver we need to
> set up and handle the consumer flags correctly. Also remove
> the Moxart-specific flags when switching to using real consumer
> flags.
> 
> Extend the register window to 0x100 bytes as we may have a few
> more registers in there and it doesn't hurt.
> 
> Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: can you please apply this directly to whatever
> DTS branch is applicable for Moxart? We are switching to a
> generic Faraday Technology interrupt controller driver that
> actually make use of the trigger flags so this needs to be
> rectified.

Applied to next/dt, thanks.

-Olof
