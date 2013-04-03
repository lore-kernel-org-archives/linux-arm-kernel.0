From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 14:28:32 +0800
Subject: [PATCH V5 7/9] ARM: dts: tegra: add non-removable and
 keep-power-in-suspend property for MMC
In-Reply-To: <20130403054549.GA6764@avionic-0098.mockup.avionic-design.de>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
 <1364901613-25080-8-git-send-email-josephl@nvidia.com>
 <515B3871.50801@wwwdotorg.org>
 <20130403054549.GA6764@avionic-0098.mockup.avionic-design.de>
Message-ID: <1364970512.16957.15.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-03 at 13:45 +0800, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Apr 02, 2013 at 01:58:41PM -0600, Stephen Warren wrote:
> > On 04/02/2013 05:20 AM, Joseph Lo wrote:
> > > This patch adds "non-removable" property of MMC host where the eMMC device
> > > is for Tegra platform.
> > > 
> > > And the "keep-power-in-suspend" property was used for the SDIO device that
> > > need this to go into suspend mode (e.g. BRCM43xx series).
> > 
> > >  arch/arm/boot/dts/tegra20-paz00.dts      | 1 +
> > >  arch/arm/boot/dts/tegra20-seaboard.dts   | 2 ++
> > >  arch/arm/boot/dts/tegra20-ventana.dts    | 2 ++
> > >  arch/arm/boot/dts/tegra20-whistler.dts   | 1 +
> > >  arch/arm/boot/dts/tegra30-beaver.dts     | 1 +
> > >  arch/arm/boot/dts/tegra30-cardhu-a02.dts | 1 +
> > >  arch/arm/boot/dts/tegra30-cardhu-a04.dts | 1 +
> > >  arch/arm/boot/dts/tegra30-cardhu.dtsi    | 1 +
> > 
> > I think there are a bunch of other boards that need a similar change,
> > right? There are certainly eMMC devices on other boards, and shouldn't
> > they be marked with non-removable? In particular, Beaver, Dalmore, and
> > Pluto, and likely some/all of the Colibri and Avionic Design boards. I
> > think it should be obvious which SDHCI devices need this, since there
> > won't be any cd-gpios property and the bus-width will likely be 8.
> 
> For Tegra20 Tamonten we don't use eMMC. Ideally we'd be using NAND to
> boot from but that doesn't have mainline support. I have a semi-working
> patch and will probably spend some more time getting it ready. The MMC
> cards are all removable, though I guess since they are the boot device
> they still should remain powered in suspend?
> 
The "non-removable" property is a specific property to avoid the risk of
writing back data to a different card after resume. If you just want to
test the suspend function, you can add "mmc_core.removable=0" in your
boot arg.

The "keep-power-in-suspend" is used for the BRCM43xx series SDIO device.
Without this, it can't go into suspend mode.
