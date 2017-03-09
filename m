From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Mar 2017 16:41:29 +0100
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <20170309150829.GM21222@n2100.armlinux.org.uk>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <3001681.2O13sqAj0p@amdc3058> <20170309150829.GM21222@n2100.armlinux.org.uk>
 <CGME20170309154131epcas5p1f9c668855ee33c1634d4491d8664848b@epcas5p1.samsung.com>
Message-ID: <38186948.tezz7FzVrI@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 09, 2017 03:08:29 PM Russell King - ARM Linux wrote:
> On Thu, Mar 09, 2017 at 03:57:37PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday, March 09, 2017 02:51:47 PM Russell King - ARM Linux wrote:
> > > On Thu, Mar 09, 2017 at 03:42:49PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > On Thursday, March 09, 2017 01:57:15 PM Russell King - ARM Linux wrote:
> > > > > On Thu, Mar 09, 2017 at 03:24:56PM +0300, Sergei Shtylyov wrote:
> > > > > > On 03/09/2017 03:20 PM, Sekhar Nori wrote:
> > > > > > 
> > > > > > >[...]
> > > > > > 
> > > > > > >>>diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
> > > > > > >>>b/arch/arm/mach-davinci/board-dm644x-evm.c
> > > > > > >>>index 023480b75244..60a1f23890cd 100644
> > > > > > >>>--- a/arch/arm/mach-davinci/board-dm644x-evm.c
> > > > > > >>>+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> > > > > > >>>@@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device
> > > > > > >>>*phydev)
> > > > > > >>>     return 0;
> > > > > > >>> }
> > > > > > >>>
> > > > > > >>>-#define HAS_ATA        IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
> > > > > > >>>+#define HAS_ATA        IS_ENABLED(CONFIG_PATA_BK3710)
> > > > > > >>
> > > > > > >>   I think it would be more correct to check for both libata and IDE
> > > > > > >>drivers here...
> > > > > > >
> > > > > > >As I understand, the plan is to remove the IDE driver soon.
> > > > > > 
> > > > > >    I'm not sure DaveM would support any removals in drivers/ide/. He has
> > > > > > explicitly expressed his will to maintain the IDE driuver forever.
> > > > > 
> > > > > As I keep saying, there are ARM machines where the IDE driver works but
> > > > > the PATA driver doesn't.  EBSA110's PCMCIA slots for instance.
> > > > 
> > > > Please be more specific, I'll be happy to help with migrating this
> > > > machines to libata PATA.
> > > > 
> > > > BTW the example you're giving has never worked with the old IDE
> > > > driver in the upstream kernel.
> > > 
> > > That's where you are wrong.  It worked for 10+ years with no
> > > modifications in the upstream IDE driver or ide-cs driver - only the
> > > patch I quoted was required.
> > 
> > ..and the patch you quoted is in which upstream kernel version exactly?
> 
> I don't claim that it works with the upstream kernel as a whole.  I claim
> that it works with the ide-cs driver _unmodified_ in the upstream kernel,
> but with a simple two line patch which is private to the ARM architecture.
> 
> Please pay attention to what I write, thanks.

Out-of-tree patches are on their own, as kernel evolves they need
to adapt, nothing new here.  For 10+ years you were just extremely
lucky with your out-of-tree patch. 8)

Anyway, if you ever get to running current upstream on your EBSA110
please ping me and I will provide you with the draft pata_pcmcia
patch to make EBSA110 work with libata.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
