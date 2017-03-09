From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Mar 2017 14:51:47 +0000
Subject: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
In-Reply-To: <3285453.g1rFzTv5DW@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <a8eab3b1-8867-00dd-08e4-bcece23010a6@cogentembedded.com>
 <20170309135714.GJ21222@n2100.armlinux.org.uk>
 <CGME20170309144256epcas1p25b4c18f7ced857f71e2f8c53ce7b2345@epcas1p2.samsung.com>
 <3285453.g1rFzTv5DW@amdc3058>
Message-ID: <20170309145147.GL21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 03:42:49PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Thursday, March 09, 2017 01:57:15 PM Russell King - ARM Linux wrote:
> > On Thu, Mar 09, 2017 at 03:24:56PM +0300, Sergei Shtylyov wrote:
> > > On 03/09/2017 03:20 PM, Sekhar Nori wrote:
> > > 
> > > >[...]
> > > 
> > > >>>diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
> > > >>>b/arch/arm/mach-davinci/board-dm644x-evm.c
> > > >>>index 023480b75244..60a1f23890cd 100644
> > > >>>--- a/arch/arm/mach-davinci/board-dm644x-evm.c
> > > >>>+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> > > >>>@@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device
> > > >>>*phydev)
> > > >>>     return 0;
> > > >>> }
> > > >>>
> > > >>>-#define HAS_ATA        IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
> > > >>>+#define HAS_ATA        IS_ENABLED(CONFIG_PATA_BK3710)
> > > >>
> > > >>   I think it would be more correct to check for both libata and IDE
> > > >>drivers here...
> > > >
> > > >As I understand, the plan is to remove the IDE driver soon.
> > > 
> > >    I'm not sure DaveM would support any removals in drivers/ide/. He has
> > > explicitly expressed his will to maintain the IDE driuver forever.
> > 
> > As I keep saying, there are ARM machines where the IDE driver works but
> > the PATA driver doesn't.  EBSA110's PCMCIA slots for instance.
> 
> Please be more specific, I'll be happy to help with migrating this
> machines to libata PATA.
> 
> BTW the example you're giving has never worked with the old IDE
> driver in the upstream kernel.

That's where you are wrong.  It worked for 10+ years with no
modifications in the upstream IDE driver or ide-cs driver - only the
patch I quoted was required.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
