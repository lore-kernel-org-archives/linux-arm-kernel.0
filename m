From: sre@debian.org (Sebastian Reichel)
Date: Tue, 8 Oct 2013 02:05:16 +0200
Subject: [PATCH V3] ARM: OMAP3: Fix hardware detection for omap3630 when
 booted with device tree
In-Reply-To: <1381178629-13488-1-git-send-email-nm@ti.com>
References: <20131007192009.GA8949@atomide.com>
 <1381178629-13488-1-git-send-email-nm@ti.com>
Message-ID: <20131008000515.GA2097@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 03:43:49PM -0500, Nishanth Menon wrote:
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 39c7838..4fe5b9c 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -113,6 +113,7 @@ MACHINE_END
>  #ifdef CONFIG_ARCH_OMAP3
>  static const char *omap3_boards_compat[] __initdata = {
>  	"ti,omap3",
> +	"ti,omap343x",
            ^^^^
You used omap36xx everywhere, so I guess this should be
"ti,omap34xx"?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131008/75bf54d3/attachment.sig>
