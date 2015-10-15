From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 15 Oct 2015 17:04:01 -0400
Subject: [PATCH v3 04/10] clk: nsp: add clock support for Broadcom
 Northstar Plus SoC
In-Reply-To: <56200F95.3040902@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-5-git-send-email-jonmason@broadcom.com>
 <56200F95.3040902@broadcom.com>
Message-ID: <20151015210400.GN32089@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 01:41:57PM -0700, Scott Branden wrote:
> Jon,
> 
> Review below.
> 
> On 15-10-15 12:48 PM, Jon Mason wrote:
> >The Broadcom Northstar Plus SoC is architected under the iProc
> 
> Based on changes in Makefile below - should this be for Northstar
> and Northstar Plus?

Yes, that would be more accurate (or the 5301x/4708 verbage we are
using now in Linux for that SoC family).  If there is the need for
another version of this patch, I'll fix it up.

Thanks,
Jon

> 
> >architecture. It has the following PLLs: ARMPLL, GENPLL, LCPLL0, all
> >derived from an onboard crystal.
> >
> >Signed-off-by: Jon Mason <jonmason@broadcom.com>
> >---
> >  drivers/clk/bcm/Makefile            |   2 +
> >  drivers/clk/bcm/clk-nsp.c           | 135 ++++++++++++++++++++++++++++++++++++
> >  include/dt-bindings/clock/bcm-nsp.h |  51 ++++++++++++++
> >  3 files changed, 188 insertions(+)
> >  create mode 100644 drivers/clk/bcm/clk-nsp.c
> >  create mode 100644 include/dt-bindings/clock/bcm-nsp.h
> >
> >diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> >index 8a7a477..e258b28 100644
> >--- a/drivers/clk/bcm/Makefile
> >+++ b/drivers/clk/bcm/Makefile
> >@@ -4,3 +4,5 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
> >  obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
> >  obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
> >  obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
> >+obj-$(CONFIG_ARCH_BCM_NSP)	+= clk-nsp.o
> >+obj-$(CONFIG_ARCH_BCM_5301X)	+= clk-nsp.o
> 
