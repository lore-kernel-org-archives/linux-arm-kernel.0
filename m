From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Dec 2013 17:00:48 +0100
Subject: [PATCH 2/2] ARM: mvebu: move Armada 370/XP specific definitions
 to armada-370-xp.h
In-Reply-To: <1388046026-332-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1388046026-332-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131226160048.GA19323@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 09:20:26AM +0100, Thomas Petazzoni wrote:
> In preparation to the introduction of the support for additional SoC,
> the mvebu/common.h should be clear of Armada 370/XP-specific
> definitions. Therefore, move the Armada 370/XP SMP specific
> definitions to the armada-370-xp.h file.

Hi Thomas

Just a question. How much of armada-370-xp.h is specific to just one
of these? Things like all the SMP support is XP only. Does it make
sense to have armada-370.h, armada-xp.h, then a shared
armada-370-xp.h, followed by common.h?

As more SoCs move in, having a clean well defined structure is going
to help with the merging.

Thanks
	Andrew

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.h | 2 ++
>  arch/arm/mach-mvebu/common.h        | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
> index c612b2c..775d9c3 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.h
> +++ b/arch/arm/mach-mvebu/armada-370-xp.h
> @@ -20,6 +20,8 @@
>  
>  void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq);
>  void armada_xp_mpic_smp_cpu_init(void);
> +void armada_xp_secondary_startup(void);
> +extern struct smp_operations armada_xp_smp_ops;
>  #endif
>  
>  #endif /* __MACH_ARMADA_370_XP_H */
> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index 4c84689..c23b077 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -22,6 +22,5 @@
>  void mvebu_restart(enum reboot_mode mode, const char *cmd);
>  
>  void armada_xp_cpu_die(unsigned int cpu);
> -void armada_xp_secondary_startup(void);
> -extern struct smp_operations armada_xp_smp_ops;
> +
>  #endif
> -- 
> 1.8.3.2
> 
