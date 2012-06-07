From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jun 2012 20:07:38 +0200
Subject: [PATCH] ARM: mx35: add WEIM register addresses
In-Reply-To: <20120509131638.GA2057@lovely.krouter>
References: <20120509131638.GA2057@lovely.krouter>
Message-ID: <20120607180738.GM30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Wed, May 09, 2012 at 03:16:38PM +0200, Christoph Fritz wrote:
> 
> This patch adds WEIM register addresses to mx35 platform header file.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> ---
>  arch/arm/plat-mxc/include/mach/mx35.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
> index 80965a9..8b8f424 100644
> --- a/arch/arm/plat-mxc/include/mach/mx35.h
> +++ b/arch/arm/plat-mxc/include/mach/mx35.h
> @@ -111,6 +111,11 @@
>  #define MX35_EMI_CTL_BASE_ADDR			(MX35_X_MEMC_BASE_ADDR + 0x4000)
>  #define MX35_PCMCIA_CTL_BASE_ADDR		MX35_EMI_CTL_BASE_ADDR
>  
> +#define MX35_WEIM_CSCRx_BASE_ADDR(cs)	(MX35_WEIM_BASE_ADDR + (cs) * 0x10)
> +#define MX35_WEIM_CSCRxU(cs)		(MX35_WEIM_CSCRx_BASE_ADDR(cs))
> +#define MX35_WEIM_CSCRxL(cs)		(MX35_WEIM_CSCRx_BASE_ADDR(cs) + 0x4)
> +#define MX35_WEIM_CSCRxA(cs)		(MX35_WEIM_CSCRx_BASE_ADDR(cs) + 0x8)
> +

Honestly I'm not in the mood of adding another instance of the same
register defines. Currently we have:

#define MX31_WEIM_CSCRx_BASE_ADDR(cs) (MX31_WEIM_BASE_ADDR + (cs) * 0x10)
#define MX31_WEIM_CSCRxU(cs) (MX31_WEIM_CSCRx_BASE_ADDR(cs))
#define MX31_WEIM_CSCRxL(cs) (MX31_WEIM_CSCRx_BASE_ADDR(cs) + 0x4)
#define MX31_WEIM_CSCRxA(cs) (MX31_WEIM_CSCRx_BASE_ADDR(cs) + 0x8)

#define MX27_WEIM_CSCRx_BASE_ADDR(cs) (MX27_WEIM_BASE_ADDR + (cs) * 0x10)
#define MX27_WEIM_CSCRxU(cs) (MX27_WEIM_CSCRx_BASE_ADDR(cs))
#define MX27_WEIM_CSCRxL(cs) (MX27_WEIM_CSCRx_BASE_ADDR(cs) + 0x4)
#define MX27_WEIM_CSCRxA(cs) (MX27_WEIM_CSCRx_BASE_ADDR(cs) + 0x8)

The same could be used on i.MX25 aswell. I think we should clean this
up before adding more SoCs.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
