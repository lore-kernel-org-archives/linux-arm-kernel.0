From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 18 Mar 2011 16:00:03 +0300
Subject: [PATCH] omap3: beaglexm: fix user button.
In-Reply-To: <1300365890-28544-1-git-send-email-javier.martin@vista-silicon.com>
References: <1300365890-28544-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <4D835753.1040308@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-03-2011 15:44, Javier Martin wrote:

> User push button in Beagleboard xM is 4 instead of 7.

> Signed-off-by: Javier Martin<javier.martin@vista-silicon.com>
[...]

> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 46d814a..abf87d1 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -615,6 +615,10 @@ static void __init omap3_beagle_init(void)
>   	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>   	omap3_beagle_init_rev();
>   	omap3_beagle_i2c_init();
> +	/* xM version uses pin 4 instead of 7 for user button */
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +		gpio_buttons[0].gpio = 4;
> +	}

    I think checkpatch.pl should warn about unneeded {}.

WBR, Sergei
