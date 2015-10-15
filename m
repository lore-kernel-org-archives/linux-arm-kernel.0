From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 15 Oct 2015 17:10:25 -0400
Subject: [PATCH v3 08/10] clk: ns2: add clock support for Broadcom
 Northstar 2 SoC
In-Reply-To: <562014C9.5070708@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-9-git-send-email-jonmason@broadcom.com>
 <56200F39.1060102@broadcom.com> <562012A8.8050707@broadcom.com>
 <562014C9.5070708@broadcom.com>
Message-ID: <20151015211025.GP32089@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 02:04:09PM -0700, Scott Branden wrote:
> Hi Ray,
> 
> Comment at near end.
> 
> On 15-10-15 01:55 PM, Ray Jui wrote:
> >
> >
> >On 10/15/2015 1:40 PM, Scott Branden wrote:
> >>We need some sort of kconfig option to differentiate NS2 clock driver
> >>from being pulled in all the time.
> >>
> >>On 15-10-15 12:48 PM, Jon Mason wrote:
> >>>The Broadcom Northstar 2 SoC is architected under the iProc
> >>>architecture. It has the following PLLs: GENPLL SCR, GENPLL SW,
> >>>LCPLL DDR, LCPLL Ports, all derived from an onboard crystal.
> >>>
> >>>Signed-off-by: Jon Mason <jonmason@broadcom.com>
> >>>---
> >>>   drivers/clk/Makefile                |   2 +-
> >>>   drivers/clk/bcm/Makefile            |   1 +
> >>>   drivers/clk/bcm/clk-ns2.c           | 288
> >>>++++++++++++++++++++++++++++++++++++
> >>>   include/dt-bindings/clock/bcm-ns2.h |  72 +++++++++
> >>>   4 files changed, 362 insertions(+), 1 deletion(-)
> >>>   create mode 100644 drivers/clk/bcm/clk-ns2.c
> >>>   create mode 100644 include/dt-bindings/clock/bcm-ns2.h
> >>>
> >>>diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> >>>index d08b3e5..6124bd3 100644
> >>>--- a/drivers/clk/Makefile
> >>>+++ b/drivers/clk/Makefile
> >>>@@ -47,7 +47,7 @@ obj-$(CONFIG_COMMON_CLK_WM831X)        += clk-wm831x.o
> >>>   obj-$(CONFIG_COMMON_CLK_XGENE)        += clk-xgene.o
> >>>   obj-$(CONFIG_COMMON_CLK_PWM)        += clk-pwm.o
> >>>   obj-$(CONFIG_COMMON_CLK_AT91)        += at91/
> >>>-obj-$(CONFIG_ARCH_BCM)            += bcm/
> >>>+obj-y                    += bcm/
> >>>   obj-$(CONFIG_ARCH_BERLIN)        += berlin/
> >>>   obj-$(CONFIG_ARCH_HISI)            += hisilicon/
> >>>   obj-$(CONFIG_ARCH_MXC)            += imx/
> >>>diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> >>>index e258b28..2d1cbc5 100644
> >>>--- a/drivers/clk/bcm/Makefile
> >>>+++ b/drivers/clk/bcm/Makefile
> >>>@@ -3,6 +3,7 @@ obj-$(CONFIG_CLK_BCM_KONA)    += clk-kona-setup.o
> >>>   obj-$(CONFIG_CLK_BCM_KONA)    += clk-bcm281xx.o
> >>>   obj-$(CONFIG_CLK_BCM_KONA)    += clk-bcm21664.o
> >>>   obj-$(CONFIG_COMMON_CLK_IPROC)    += clk-iproc-armpll.o
> >>>clk-iproc-pll.o clk-iproc-asiu.o
> >>>+obj-$(CONFIG_COMMON_CLK_IPROC)    += clk-ns2.o
> >>
> >>NS2 code is dragged in for all IPROC SoCs.  We need a config option for
> >>NS2 (CONFIG_ARCH_BCM_NS2) to avoid this (if Arnd allows this for ARMv8
> >>processors... ?).
> >>
> >>You can see below ARMv7 processors don't have this problem.
> >>
> >
> >The arm64 maintainers (Catalin, Mark, and etc.) stated they only want
> >one ARCH options per chip family.
> >
> >>If not we need to add CONFIG_CLK_NS2.
> >
> >If using CONFIG_CLK_NS2, how is it going to be enabled/selected?
> 
> Since CONFIG_ARCH_BCM_NS2 isn't "allowed" to be introduced we will
> need to create and select a CONFIG_CLK_BCM_NS2 in the defconfig
> instead.

Is this better than the binary becoming slightly bigger?  I thought
the extra complexity was worse than having an unused chunk of clk code
(and Kona is already doing the same thing above).  I believe Ray was
in agreement with me during the internal review of this code.

Thanks,
Jon

> >
> >Ray
> >
> 
> Regards,
>  Scott
