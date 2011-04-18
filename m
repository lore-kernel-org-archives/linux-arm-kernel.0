From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 18 Apr 2011 22:03:15 +0200
Subject: [PATCH 10/14] PM / MIPS: Use struct syscore_ops instead of
	sysdevs for PM
In-Reply-To: <20110418101218.GA25325@linux-mips.org>
References: <201103280125.11750.rjw@sisk.pl> <201104172312.35060.rjw@sisk.pl>
	<20110418101218.GA25325@linux-mips.org>
Message-ID: <201104182203.16171.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 18, 2011, Ralf Baechle wrote:
> This patch breaks the Alchemy kernel compile; below patch on top of it fixes
> that again.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!  If you don't mind, I'd like to fold your patch into [10/14].

Rafael


> ---
>  arch/mips/alchemy/common/irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-mips/arch/mips/alchemy/common/irq.c
> ===================================================================
> --- linux-mips.orig/arch/mips/alchemy/common/irq.c
> +++ linux-mips/arch/mips/alchemy/common/irq.c
> @@ -619,8 +619,8 @@ static struct syscore_ops alchemy_ic_sys
>  
>  static int __init alchemy_ic_syscore_init(void)
>  {
> -	alchemy_ic_data[0].base = ioremap(icbase[IC0_PHYS_ADDR], 0x1000);
> -	alchemy_ic_data[1].base = ioremap(icbase[IC1_PHYS_ADDR], 0x1000);
> +	alchemy_ic_data[0].base = ioremap(IC0_PHYS_ADDR, 0x1000);
> +	alchemy_ic_data[1].base = ioremap(IC1_PHYS_ADDR, 0x1000);
>  
>  	register_syscore_ops(&alchemy_ic_syscore_ops);
>  
> 
> 
