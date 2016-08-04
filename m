From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 4 Aug 2016 20:58:46 +0000
Subject: [PATCH] ARM: dts: da850: Add basic DTS for the L138/C6748 Dev Kit
In-Reply-To: <m2popopcqu.fsf@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <m2popopcqu.fsf@baylibre.com>
Message-ID: <20160804205846.GC15013@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 12:15:05PM -0700, Kevin Hilman wrote:
> + Sekhar
> 
> Hi Karl,
> 
> Karl Beldan <kbeldan@baylibre.com> writes:
> 
> > The LCDK is the successor to the late Hawkboard and has the same machine
> > number.
> 
> Machine number is only relevant for legacy (non-DT) boot and this is DT
> boot, so the machine number bit really relevant for this changelog.
> 
Hi Kevin,

It was purely informative.

> BTW, have you tried legacy boot on LCDK with board-omapl138-hawk.c?  I
> assume it mostly works?
> 
Yes.

> > Among the differences are the flash (16bits vs 8bits) and some pins
> > (MMC, LEDs, buttons, some external connectors), however the main
> > components remain the same (eth. PHY, Audio Codec, Video decoder and
> > DAC) except for the main PMIC, different and hard-wired on the LCDK (the
> > LDOs and DCDCs are always ON).
> > A DT-only boot with this addition gives functional uart, reboot via
> > watchdog, rtc, ethernet and MMC (I added the CD gpio for the MMC
> > although davinci_mmc doesn't call yet the mmc core OF facilities).
> >
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> 
> Tested with v4.7 on my LCDK board.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
> Note that I also needed CONFIG_RTC_DRV_OMAP=m enabled in
> davinci_all_defconfig for the RTC driver. Could you add a patch for that
> to this series as well?
> 
No problem. BTW do you also consider CONFIG_ items not arch specific
(like CONFIG_NET_VENDOR_SMSC) ?

> Also, plese Cc the co-maintainer Sekhar Nori (now Cc'd) on all future
> davinci patches.
> 
Sure.

> > ---
> >  Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
> >  arch/arm/boot/dts/Makefile                        |  1 +
> >  arch/arm/boot/dts/omapl138-lcdk.dts               | 71 +++++++++++++++++++++++
> 
> I think this should be called da850-lcdk.dts.
> 
> The OMAP prefix in the DT directory is just going to cause confusion,
> and the other DTs using this same SoC are already called da850.
> 
That's what I thought too, mainline U-Boot is using omapl138_lcdk but
yes da850 is less confusing given the code already present (downside is
when you search for da850 on the net there's nothing).

> Sekhar do you have any opinion here?
> 
> [...]
> 
> > +/ {
> > +	model = "DA850/AM1808/OMAP-L138 LCDK";
> > +	compatible = "ti,omapl138-lcdk", "ti,da850";
> > +
> > +	aliases {
> > +		serial2 = &serial2;
> > +	};
> > +
> > +	chosen {
> > +		bootargs = "console=ttyS2,115200n8 earlycon";
> 
> earlycon is kind of a debug option, so probably should be left out of
> the default DT.
> 
Sure.
 
Karl
