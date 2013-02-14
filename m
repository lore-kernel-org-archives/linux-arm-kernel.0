From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 13 Feb 2013 20:03:30 -0800 (PST)
Subject: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support again
In-Reply-To: <1360813381-3416-1-git-send-email-horms+renesas@verge.net.au>
References: <1360813381-3416-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87a9r7v8xd.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> This partially reverts 58079fa7d54a0929d304054ee759187a2ccd3cdf
> (ARM: shmobile: r8a7779: Correct TMU clock support) and fixes
> a regression introduced by that patch.
> 
> Although the documentation I have indicates that the patch above is
> correct it appears that the change causes the Marzen board to fail to boot
> as follows.
(snip)
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> @@ -161,7 +161,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
>  	CLKDEV_DEV_ID("ohci-platform.0", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
>  	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
> -	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
> +	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
>  	CLKDEV_DEV_ID("sh_tmu.2", &mstp_clks[MSTP014]), /* TMU02 */
>  	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
>  	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */

Really ???
Is MSTP value of TMU01 same as TMU00 ?

Please wail, I ask it to hardware guys.

Best regards
---
Kuninori Morimoto
