From: simon@sequanux.org (Simon Guinot)
Date: Thu, 17 Nov 2011 10:14:11 +0100
Subject: [PATCH] ARM: kirkwood: reorder machine_desc initializers
In-Reply-To: <1321465262-23075-1-git-send-email-cvubrugier@lacie.com>
References: <1321465262-23075-1-git-send-email-cvubrugier@lacie.com>
Message-ID: <20111117091411.GA31811@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

On Wed, Nov 16, 2011 at 06:41:02PM +0100, Christophe Vu-Brugier wrote:
> The initializers in MACHINE_START should appear in the same order
> as they are declared in struct machine_desc to reflect the order in
> which they are called.
> 
> Signed-off-by: Christophe Vu-Brugier <cvubrugier@lacie.com>
> ---
> This patch is based on the 'reset' branch. It depends on the following
> commit:
> 
>  2f82cc8 ARM: restart: kirkwood: use new restart hook
> 
>  arch/arm/mach-kirkwood/d2net_v2-setup.c        |    2 +-
>  arch/arm/mach-kirkwood/db88f6281-bp-setup.c    |    2 +-
>  arch/arm/mach-kirkwood/dockstar-setup.c        |    2 +-
>  arch/arm/mach-kirkwood/guruplug-setup.c        |    2 +-
>  arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c |    2 +-
>  arch/arm/mach-kirkwood/netspace_v2-setup.c     |    6 +++---
>  arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    4 ++--
>  arch/arm/mach-kirkwood/openrd-setup.c          |    6 +++---
>  arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    2 +-
>  arch/arm/mach-kirkwood/rd88f6281-setup.c       |    2 +-
>  arch/arm/mach-kirkwood/sheevaplug-setup.c      |    4 ++--
>  arch/arm/mach-kirkwood/t5325-setup.c           |    2 +-
>  arch/arm/mach-kirkwood/ts219-setup.c           |    2 +-
>  arch/arm/mach-kirkwood/ts41x-setup.c           |    2 +-
>  14 files changed, 20 insertions(+), 20 deletions(-)

Maybe this patch could be extended to all the Orion SoCs ?
Some boards in mach-dove, mach-mv78xx0 and mach-orion5x have the same
symptom...

Regards,

Simon

> 
> diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-kirkwood/d2net_v2-setup.c
> index 6e1bac9..c3d867e 100644
> --- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
> +++ b/arch/arm/mach-kirkwood/d2net_v2-setup.c
> @@ -222,10 +222,10 @@ static void __init d2net_v2_init(void)
>  
>  MACHINE_START(D2NET_V2, "LaCie d2 Network v2")
>  	.atag_offset	= 0x100,
> -	.init_machine	= d2net_v2_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= d2net_v2_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
> index d933593..815ec88 100644
> --- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
> +++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
> @@ -98,10 +98,10 @@ subsys_initcall(db88f6281_pci_init);
>  MACHINE_START(DB88F6281_BP, "Marvell DB-88F6281-BP Development Board")
>  	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= db88f6281_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= db88f6281_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
> index 61d9a55..7a48e76 100644
> --- a/arch/arm/mach-kirkwood/dockstar-setup.c
> +++ b/arch/arm/mach-kirkwood/dockstar-setup.c
> @@ -103,10 +103,10 @@ static void __init dockstar_init(void)
>  
>  MACHINE_START(DOCKSTAR, "Seagate FreeAgent DockStar")
>  	.atag_offset	= 0x100,
> -	.init_machine	= dockstar_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= dockstar_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
> index bdaed38..58e7da8 100644
> --- a/arch/arm/mach-kirkwood/guruplug-setup.c
> +++ b/arch/arm/mach-kirkwood/guruplug-setup.c
> @@ -122,10 +122,10 @@ static void __init guruplug_init(void)
>  MACHINE_START(GURUPLUG, "Marvell GuruPlug Reference Board")
>  	/* Maintainer: Siddarth Gore <gores@marvell.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= guruplug_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= guruplug_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
> index 85f6169..00d90d1 100644
> --- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
> +++ b/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
> @@ -164,10 +164,10 @@ subsys_initcall(mv88f6281gtw_ge_pci_init);
>  MACHINE_START(MV88F6281GTW_GE, "Marvell 88F6281 GTW GE Board")
>  	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= mv88f6281gtw_ge_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= mv88f6281gtw_ge_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
> index e6bba01..3001c18 100644
> --- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
> +++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
> @@ -259,11 +259,11 @@ static void __init netspace_v2_init(void)
>  #ifdef CONFIG_MACH_NETSPACE_V2
>  MACHINE_START(NETSPACE_V2, "LaCie Network Space v2")
>  	.atag_offset	= 0x100,
> -	.init_machine	= netspace_v2_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= netspace_v2_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> @@ -271,11 +271,11 @@ MACHINE_END
>  #ifdef CONFIG_MACH_INETSPACE_V2
>  MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
>  	.atag_offset	= 0x100,
> -	.init_machine	= netspace_v2_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= netspace_v2_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> @@ -283,11 +283,11 @@ MACHINE_END
>  #ifdef CONFIG_MACH_NETSPACE_MAX_V2
>  MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
>  	.atag_offset	= 0x100,
> -	.init_machine	= netspace_v2_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= netspace_v2_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
> index 31ae8de..42a9d75 100644
> --- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
> +++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
> @@ -400,11 +400,11 @@ static void __init netxbig_v2_init(void)
>  #ifdef CONFIG_MACH_NET2BIG_V2
>  MACHINE_START(NET2BIG_V2, "LaCie 2Big Network v2")
>  	.atag_offset	= 0x100,
> -	.init_machine	= netxbig_v2_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= netxbig_v2_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> @@ -412,11 +412,11 @@ MACHINE_END
>  #ifdef CONFIG_MACH_NET5BIG_V2
>  MACHINE_START(NET5BIG_V2, "LaCie 5Big Network v2")
>  	.atag_offset	= 0x100,
> -	.init_machine	= netxbig_v2_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= netxbig_v2_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
> index 01f8c89..e89b54c 100644
> --- a/arch/arm/mach-kirkwood/openrd-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd-setup.c
> @@ -215,11 +215,11 @@ subsys_initcall(openrd_pci_init);
>  MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
>  	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= openrd_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= openrd_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> @@ -228,11 +228,11 @@ MACHINE_END
>  MACHINE_START(OPENRD_CLIENT, "Marvell OpenRD Client Board")
>  	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= openrd_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= openrd_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> @@ -241,11 +241,11 @@ MACHINE_END
>  MACHINE_START(OPENRD_ULTIMATE, "Marvell OpenRD Ultimate Board")
>  	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= openrd_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= openrd_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
> index fd2c9c8..1e0cd22 100644
> --- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
> +++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
> @@ -80,10 +80,10 @@ subsys_initcall(rd88f6192_pci_init);
>  MACHINE_START(RD88F6192_NAS, "Marvell RD-88F6192-NAS Development Board")
>  	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= rd88f6192_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= rd88f6192_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-kirkwood/rd88f6281-setup.c
> index ef92207..2aa979a 100644
> --- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
> +++ b/arch/arm/mach-kirkwood/rd88f6281-setup.c
> @@ -116,10 +116,10 @@ subsys_initcall(rd88f6281_pci_init);
>  MACHINE_START(RD88F6281, "Marvell RD-88F6281 Reference Board")
>  	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= rd88f6281_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= rd88f6281_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
> index 85bff6b..d71fc59 100644
> --- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
> +++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
> @@ -139,11 +139,11 @@ static void __init sheevaplug_init(void)
>  MACHINE_START(SHEEVAPLUG, "Marvell SheevaPlug Reference Board")
>  	/* Maintainer: shadi Ammouri <shadi@marvell.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= sheevaplug_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= sheevaplug_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> @@ -151,11 +151,11 @@ MACHINE_END
>  #ifdef CONFIG_MACH_ESATA_SHEEVAPLUG
>  MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
>  	.atag_offset	= 0x100,
> -	.init_machine	= sheevaplug_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= sheevaplug_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-kirkwood/t5325-setup.c
> index 966b2b3..7d64cdd 100644
> --- a/arch/arm/mach-kirkwood/t5325-setup.c
> +++ b/arch/arm/mach-kirkwood/t5325-setup.c
> @@ -202,10 +202,10 @@ subsys_initcall(hp_t5325_pci_init);
>  MACHINE_START(T5325, "HP t5325 Thin Client")
>  	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= hp_t5325_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= hp_t5325_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
> index 73e2b6c..60675cb 100644
> --- a/arch/arm/mach-kirkwood/ts219-setup.c
> +++ b/arch/arm/mach-kirkwood/ts219-setup.c
> @@ -133,10 +133,10 @@ subsys_initcall(ts219_pci_init);
>  MACHINE_START(TS219, "QNAP TS-119/TS-219")
>  	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= qnap_ts219_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= qnap_ts219_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
> index 5bbca26..7d88dd5 100644
> --- a/arch/arm/mach-kirkwood/ts41x-setup.c
> +++ b/arch/arm/mach-kirkwood/ts41x-setup.c
> @@ -177,10 +177,10 @@ subsys_initcall(ts41x_pci_init);
>  MACHINE_START(TS41X, "QNAP TS-41x")
>  	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
>  	.atag_offset	= 0x100,
> -	.init_machine	= qnap_ts41x_init,
>  	.map_io		= kirkwood_map_io,
>  	.init_early	= kirkwood_init_early,
>  	.init_irq	= kirkwood_init_irq,
>  	.timer		= &kirkwood_timer,
> +	.init_machine	= qnap_ts41x_init,
>  	.restart	= kirkwood_restart,
>  MACHINE_END
> -- 
> 1.7.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111117/c6c84039/attachment.sig>
