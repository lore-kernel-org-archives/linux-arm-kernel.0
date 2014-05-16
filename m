From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:04:13 +0900
Subject: [PATCH v6 13/17] ARM: shmobile: marzen: Add to shmobile defconfig
In-Reply-To: <20140515225027.GA29432@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
 <1400153532-23675-14-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXPm_=ejkcnOFOgfnsz9MUc8KpAjkuMcHMKJeaEmVbhQA@mail.gmail.com>
 <20140515225027.GA29432@verge.net.au>
Message-ID: <20140516000409.GB29432@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 07:50:28AM +0900, Simon Horman wrote:
> On Thu, May 15, 2014 at 01:57:58PM +0200, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Thu, May 15, 2014 at 1:32 PM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> > > index 6d6437c..ea7673a 100644
> > > --- a/arch/arm/configs/shmobile_defconfig
> > > +++ b/arch/arm/configs/shmobile_defconfig
> > > @@ -9,11 +9,13 @@ CONFIG_EMBEDDED=y
> > >  CONFIG_PERF_EVENTS=y
> > >  CONFIG_SLAB=y
> > >  CONFIG_ARCH_SHMOBILE_MULTI=y
> > > +CONFIG_ARCH_R8A7779=y
> > >  CONFIG_ARCH_EMEV2=y
> > >  CONFIG_ARCH_R8A7790=y
> > >  CONFIG_ARCH_R8A7791=y
> > >  CONFIG_MACH_KOELSCH=y
> > >  CONFIG_MACH_LAGER=y
> > > +CONFIG_MACH_MARZEN=y
> > >  # CONFIG_SWP_EMULATE is not set
> > >  CONFIG_CPU_BPREDICT_DISABLE=y
> > >  CONFIG_PL310_ERRATA_588369=y
> > 
> > I think you also need:
> >     CONFIG_SPI_SH_HSPI=y
> >     CONFIG_USB_RCAR_PHY=y
> >     CONFIG_PM_RUNTIME=y
> > 
> > (the last one is set in all shmobile defconfigs, except ape6evm and shmobile).
> > 
> > The other differences seem to be cruft not really related to hardware support.
> 
> Thanks, I'll verify that and make a follow-up patch.

After some more consideration I have decided on a slightly modified plan.

1. SPI_SH_HSPI and USB_RCAR_PHY

   Thanks for noticing these. I think they do belong in this patch.
   I plan to queue up the version below:

2. PM_RUNTIME

   I would like to handle this as a follow-up patch.
   In particular, I seem to recall that Magnus wanted to
   hold back on this at some point. So I'd like his input.

From: Simon Horman <horms+renesas@verge.net.au>

[PATCH v6.1] ARM: shmobile: marzen: Add to shmobile defconfig

Add marzen to shmobile defconfig now that it supports multiplatform

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v6.1
* Also enable SPI_SH_HSPI and USB_RCAR_PHY

v2 - v6
* No Change

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b76fb9b..114e88e 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -10,10 +10,12 @@ CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE_MULTI=y
 CONFIG_ARCH_EMEV2=y
+CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_MACH_KOELSCH=y
 CONFIG_MACH_LAGER=y
+CONFIG_MACH_MARZEN=y
 # CONFIG_SWP_EMULATE is not set
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
@@ -81,6 +83,7 @@ CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
 CONFIG_SPI_SH_MSIOF=y
+CONFIG_SPI_SH_HSPI=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
@@ -108,12 +111,14 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_USB=y
-CONFIG_USB_RCAR_GEN2_PHY=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
+CONFIG_USB_RCAR_PHY=y
+CONFIG_USB_RCAR_GEN2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
+CONFIG_USB_ETH=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
