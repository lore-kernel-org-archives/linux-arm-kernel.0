From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Nov 2015 15:13:55 -0600
Subject: [PATCH] ARM: OMAP2: use correct timer function for AM43XX and
 TI81XX
In-Reply-To: <4016134.4bReocePei@wuerfel>
References: <4016134.4bReocePei@wuerfel>
Message-ID: <87egfplka4.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> AM43XX and TI81XX use omap3_gptimer_timer_init(), but that is only
> built into the kernel for OMAP3 and AM33XX, otherwise we get:
>
> arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x124): undefined reference to `omap3_gptimer_timer_init'
>
> This changes the Kconfig logic for building the function to
> match the callers. Consequently, we no longer need to build
> the omap3_secure_sync32k_timer_init and omap4_local_timer_init
> for the platforms that have been moved over to other functions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

no, AM43xx uses omap4_local_timer_init(), there's already a fix in
Tony's tree IIRC.

> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_TI81XX)

[...]

> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)

someone doesn't like to run checkpatch.pl

care to provide a defconfig which would cause a build error ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151116/c77afd4f/attachment.sig>
