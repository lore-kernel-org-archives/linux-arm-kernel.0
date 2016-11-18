From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:25:41 -0800
Subject: [PATCH] ARM: integrator: drop EBI access use syscon
In-Reply-To: <1478679126-5460-1-git-send-email-linus.walleij@linaro.org>
References: <1478679126-5460-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161118072541.GD1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 09:12:06AM +0100, Linus Walleij wrote:
> The EBI lookup is not longer in use: this has been moved to the
> NAND chip driver. The syscon node is better accessed indirectly
> using the regmap like the NAND chip driver does, so let's use
> the syscon to set the modem control signals RTS/CTS through the
> dedicated syscon register.
> 
> We also migrate the decoder status "SC_DEC" register that
> enumerate the logic modules using syscon.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this patch directly to the tree
> wherever it fits. I do not plan to send more Integrator patches
> this merge window.

Thanks, applied!


-Olof
