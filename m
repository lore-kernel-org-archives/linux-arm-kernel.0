From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 May 2017 16:56:57 +0200
Subject: [PATCH v2 resend] arm: dts: sun7i-a20-bananapi: name the GPIO
 lines
In-Reply-To: <1493795360-18629-1-git-send-email-linux@rempel-privat.de>
References: <CACRpkdZcnJ1eCNW4ZF_A4zbeCt3JcAuw-1meB_Pn7ctMy99B_g@mail.gmail.com>
 <1493795360-18629-1-git-send-email-linux@rempel-privat.de>
Message-ID: <20170504145657.yzbehfov2rgeqn5g@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 09:09:20AM +0200, Oleksij Rempel wrote:
> This names the GPIO lines on the Banana Pi board in accordance with
> the A20_Banana_Pi v1.4 Specification.
> 
> This will make these line names reflect through to userspace
> so that they can easily be identified and used with the new
> character device ABI.
> 
> Some care has been taken to name all lines, not just those used
> by the external connectors, also lines that are muxed into some
> other function than GPIO: these are named "[FOO]" so that users
> can see with lsgpio what all lines are used for.
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 60 ++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> index 91f2e5f..5b3e0ee 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -178,6 +178,66 @@
>  };
>  
>  &pio {
> +	/*
> +	 * Legend: proper name = the GPIO line is used as GPIO

I'm not convinced that a legend here is helpful in any way. No end
user is going to even search for it here.

> +	 *         NC = not connected (not routed from the SoC)

Judging from the binding documentation, this should be the same than
"".

> +	 *         "[PER]" = pin is muxed for peripheral (not GPIO)

We don't need the brackets. You have no guarantee that it is actually
muxed, and will need to get that info from somewhere else either
way. This is also not a syntax that is in the generic binding
definition.

> +	 *         "" = no idea, schematic doesn't say, could be
> +	 *              unrouted (not connected to any external pin)
> +	 *         LSEC = Low Speed External Connector
> +	 *         HSEC = High Speed External Connector

And both of those are not used.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170504/86a6ce79/attachment.sig>
