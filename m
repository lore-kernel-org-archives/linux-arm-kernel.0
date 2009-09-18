From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 18 Sep 2009 20:39:22 +0200
Subject: [PATCH v3] arm: remove unused code in delay.S
In-Reply-To: <1253292418.3273.257.camel@linux-1lbu>
References: <1253292418.3273.257.camel@linux-1lbu>
Message-ID: <20090918183922.GL29905@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:46 Fri 18 Sep     , Steve Chen wrote:
> Document #if 0 code block in delay.S and make it selectable for compile.
> 
> Signed-off-by: Steve Chen <schen@mvista.com>
> 
> ---
>  arch/arm/Kconfig     |   31 +++++++++++++++++++++++++++++++
>  arch/arm/lib/delay.S |    2 +-
>  2 files changed, 32 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aef63c8..f44cb70 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -813,6 +813,37 @@ config ARM_ERRATA_460075
>  	  ACTLR register. Note that setting specific bits in the ACTLR
> register
>  	  may not be available in non-secure mode.
>  
> +config OLD_CPU_DELAY
> +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> +	bool "Different delay() code for some older CPUs"
> +	def_bool n
IIRC it will be no by default

Best Regards,
J.
