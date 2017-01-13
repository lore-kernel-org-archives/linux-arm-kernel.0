From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Jan 2017 17:40:13 +0100
Subject: [PATCH] ARM: mv78xx0: fix possible PCI buffer overflow
In-Reply-To: <20170111134159.3832518-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Wed, 11 Jan 2017 14:41:40 +0100")
References: <20170111134159.3832518-1-arnd@arndb.de>
Message-ID: <87a8au9amq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mer., janv. 11 2017, Arnd Bergmann <arnd@arndb.de> wrote:

> gcc-7.0 reports a potential array overflow:
>
> arch/arm/mach-mv78xx0/pcie.c: In function 'mv78xx0_pcie_preinit':
> arch/arm/mach-mv78xx0/pcie.c:81:4: error: output may be truncated before the last format character [-Werror=format-truncation=]
>
> I haven't checked if this can actually happen, but making the
> array one 32-bit word longer addresses the warning and makes
> it completely safe.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied on mvebu/soc

Thanks,

Gregory

> ---
>  arch/arm/mach-mv78xx0/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> index 13a7d72ee0c4..81ff4327a962 100644
> --- a/arch/arm/mach-mv78xx0/pcie.c
> +++ b/arch/arm/mach-mv78xx0/pcie.c
> @@ -29,7 +29,7 @@ struct pcie_port {
>  	u8			root_bus_nr;
>  	void __iomem		*base;
>  	spinlock_t		conf_lock;
> -	char			mem_space_name[16];
> +	char			mem_space_name[20];
>  	struct resource		res;
>  };
>  
> -- 
> 2.9.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
