From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 17 Mar 2011 23:07:46 +0100
Subject: [PATCH 7/9] lpc2k: Add EmbeddedArtists LPC2478 Developer's Kit
	board
In-Reply-To: <1300377264-10843-8-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-8-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <083DF309106F364B939360100EC290F80B15AC2B39@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +#define EXTPOLAR	0x14c
> +
> +static unsigned long mfp_cfgs[] = {

Should this be initdata?

> +
> +MACHINE_START(LPC2478OEM, "Embedded Artists LPC2478 OEM Board")

Just a nit, but the machine ID should probably be unique to this
board and not the 2478, ie EA2478OEM. If someone else releases a
LPC2478 based board, it can't use this same id. This would apply
to the filename too (lpc2478oem.c) - the name is somewhat generic
and might be better named something like plat-ea2478oem.c.

> +	.init_irq	= lpc2478oem_init_irq,
> +	.timer		= &lpc2k_timer,
> +	.init_machine	= lpc2478oem_init_machine,
> +MACHINE_END
> --
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
