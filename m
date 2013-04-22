From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Apr 2013 11:53:53 +0100
Subject: [PATCH 08/32] dmaengine: ste_dma40: Optimise local MAX() macro
In-Reply-To: <20130422101029.GP24632@intel.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
 <20130422101029.GP24632@intel.com>
Message-ID: <20130422105353.GN3432@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Apr 2013, Vinod Koul wrote:

> On Thu, Apr 18, 2013 at 11:11:50AM +0100, Lee Jones wrote:
> > The current implementation of the DMA40's local MAX() macro evaluates
> > its arguments more times than is necessary. This patch strips it
> > optimises it to only evaluate what's appropriate.
> > 
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <djbw@fb.com>
> > Cc: Per Forlin <per.forlin@stericsson.com>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Reported-by: Harvey Harrison <harvey.harrison@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/dma/ste_dma40.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> > index b21a8a3..7b451b2 100644
> > --- a/drivers/dma/ste_dma40.c
> > +++ b/drivers/dma/ste_dma40.c
> > @@ -53,7 +53,7 @@
> >  #define D40_ALLOC_PHY		BIT(30)
> >  #define D40_ALLOC_LOG_FREE	BIT(0)
> >  
> > -#define MAX(a, b) (((a) < (b)) ? (b) : (a))
> > +#define MAX(a, b) ((a > b) ? a : b)
> Am not a big fan of own redefines, can you use kernel max() macro instead

Unfortunately not in this instance, as the kernel max() macro uses
curly braces and is not suitable for this use-case. There is a thread
regarding this on the MLs with Arnd Bergmann, Russell King and myself.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
