From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 02 Mar 2011 22:16:12 +0530
Subject: [PATCH 1/8 resend] dw_dmac: Remove compilation dependency from
	AVR32
In-Reply-To: <d41145ce4d5e3d870f720709f68d5b1dbf34d6a0.1298889267.git.viresh.kumar@st.com>
References: <cover.1298889267.git.viresh.kumar@st.com>
	<d41145ce4d5e3d870f720709f68d5b1dbf34d6a0.1298889267.git.viresh.kumar@st.com>
Message-ID: <1299084372.6974.91.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 16:11 +0530, Viresh Kumar wrote:
> This will be used in SPEAr, ARM family.
Does this mean it can be used on AVR32 now? Did you implay it will
*also* be....
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 1c28816..95c7db7 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -82,7 +82,6 @@ config INTEL_IOP_ADMA
>  
>  config DW_DMAC
>  	tristate "Synopsys DesignWare AHB DMA support"
> -	depends on AVR32
Shouldn't you be adding a corresponding depends on new arch? And since
this supports old arch as well, it should say depends on both...
>  	select DMA_ENGINE
>  	default y if CPU_AT32AP7000
>  	help


-- 
~Vinod
