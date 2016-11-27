From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 27 Nov 2016 22:25:28 +0100
Subject: [PATCH] ARM: dts: mvebu: Fix armada-385-turris-omnia stdout-path
In-Reply-To: <1480275444-4220-1-git-send-email-afaerber@suse.de>
References: <71af60f5-b657-cab4-32a8-00a604fc656e@suse.de>
 <1480275444-4220-1-git-send-email-afaerber@suse.de>
Message-ID: <20161127212528.wmqbwciz5ltnfws3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 08:37:24PM +0100, Andreas F?rber wrote:
> Specify the baudrate.
> 
> Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> Cc: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

You said with plain &uart0 the kernel uses a wrong baud rate? That's
strange. For me it works and I think it's the intended behaviour to
dermine the baud rate setup by the bootloader and use this.

I'd prefer it this way over hard coding the baud rate.

>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index f53cb8b73610..2eff012287d4 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -52,7 +52,7 @@
>  	compatible = "cznic,turris-omnia", "marvell,armada385", "marvell,armada380";
>  
>  	chosen {
> -		stdout-path = &uart0;
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	memory {

This has the downside to depend on the alias. Not sure this is
considered modern. An alternative would be:

	stdout-path = "/soc/internal-regs/serial at 12000:115200n8";

(maybe there even exists syntactic sugar to express this using &uart0?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
