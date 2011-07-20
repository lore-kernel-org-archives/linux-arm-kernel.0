From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 20 Jul 2011 11:33:56 -0700
Subject: [PATCH] arm/dt: tegra devicetree support
In-Reply-To: <20110720182823.GD4642@ponder.secretlab.ca>
References: <20110719234158.2779.15394.stgit@ponder>
	<74CDBE0F657A3D45AFBB94109FB122FF049EBDEE27@HQMAIL01.nvidia.com>
	<20110720182823.GD4642@ponder.secretlab.ca>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EBDEEFA@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote at Wednesday, July 20, 2011 12:28 PM:
> On Wed, Jul 20, 2011 at 08:37:19AM -0700, Stephen Warren wrote:
> > Grant Likely wrote at Tuesday, July 19, 2011 5:43 PM:
> > > Everything required to populate NVIDIA Tegra devices from the device
> > > tree.  This patch adds a new DT_MACHINE_DESC() which matches against
> > > a tegra20 device tree.  So far it only registers the on-chip devices,
> > > but it will be refined in follow on patches to configure clocks and
> > > pin IO from the device tree also.
...
> > > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> >
> > tegra-*.dts don't include status="disable" for all the unused controllers.
> > Should that be added?
> 
> I dropped that pattern since my preference has been to have boards
> explicitly disable unused cores and that has generally been the
> pattern on other DT platforms.

Sorry if I wasn't clear, but what I meant was that the board-specific
files tegra-harmony.dts and tegra-seaboard.dts don't include the status=
"disable" entries for the modules/ports they don't use.

Still, everything probably works OK without that...

-- 
nvpublic
