From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Aug 2013 12:02:00 +0200
Subject: [PATCH v3 1/3] arm: mvebu: add missing of_node_put() to fix
 reference leak
In-Reply-To: <1377510981-1793-2-git-send-email-jszhang@marvell.com>
References: <1377510981-1793-1-git-send-email-jszhang@marvell.com>
 <1377510981-1793-2-git-send-email-jszhang@marvell.com>
Message-ID: <20130826120200.2269ba82@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jisheng Zhang,

On Mon, 26 Aug 2013 17:56:19 +0800, Jisheng Zhang wrote:

> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index 97cbb80..8a1ae83 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -64,6 +64,7 @@ static void __init armada_370_xp_mbus_init(void)
>  			ARMADA_370_XP_MBUS_WINS_SIZE,
>  			of_translate_address(dn, &sdram_wins_offs),
>  			ARMADA_370_XP_SDRAM_WINS_SIZE);
> +	of_node_put(dn);
>  }

With the integration of Ezequiel patches that add DT support to the
mvebu-mbus driver, this chunk of the code is no longer needed, as of
linux-next.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
