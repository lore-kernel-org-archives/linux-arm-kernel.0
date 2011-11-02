From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Nov 2011 18:24:18 +0200
Subject: [PATCH v2 8/8] arm/tegra: add support for tegra30 based board
	cardhu
In-Reply-To: <20111102161919.GM13358@tbergstrom-lnx.Nvidia.com>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
	<1320242948-21061-9-git-send-email-pdeschrijver@nvidia.com>
	<20111102154610.GJ13358@tbergstrom-lnx.Nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A46C4@HQMAIL01.nvidia.com>
	<20111102161919.GM13358@tbergstrom-lnx.Nvidia.com>
Message-ID: <20111102162418.GN13358@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 05:19:19PM +0100, Peter De Schrijver wrote:
> On Wed, Nov 02, 2011 at 05:07:52PM +0100, Stephen Warren wrote:
> > Peter De Schrijver wrote at Wednesday, November 02, 2011 9:46 AM:
> > > On Wed, Nov 02, 2011 at 03:09:07PM +0100, Peter De Schrijver wrote:
> > > > Add support for the tegra30 based cardhu development board. Cardhu is a tablet
> > > > formfactor reference design for tegra30. The patch provides a device tree for
> > > > the board, updates Makefile.boot to build the dtb, includes the platform in
> > > > Kconfig and updates board-dt.c.
> > ...
> > > > diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
> > > > new file mode 100644
> > > > index 0000000..70c41fc
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/tegra-cardhu.dts
> > > > @@ -0,0 +1,36 @@
> > > > +/dts-v1/;
> > > > +
> > > > +/include/ "tegra30.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "NVIDIA Tegra30 Cardhu evaluation board";
> > > 
> > > And this should probably be removed.
> > 
> > I don't follow the reasoning here; it seems correct to identify what this
> > .dts file applies to, and having a model property is consistent with other
> > .dts files, including non-Tegra boards.
> 
> hmm :) Based on your comments on the previous version, I thought you wanted
> to move this do a different patch which also does it for other boards.
> 

Ok. The comment was related to device_type = "memory"; in the same patch.
Sorry for the confusion.

Cheers,

Peter.
