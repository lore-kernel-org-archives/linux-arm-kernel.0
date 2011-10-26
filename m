From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 25 Oct 2011 23:40:55 -0700
Subject: [PATCH 3/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <4EA7134C.3050102@gmail.com>
References: <cover.1319313019.git.marvin24@gmx.de>
	<90ee88bcde84141e0280ffa4ccbd288462489eba.1319313020.git.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B4189@HQMAIL01.nvidia.com>
	<4EA7134C.3050102@gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B4535@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote at Tuesday, October 25, 2011 1:52 PM:
> On 10/25/2011 12:16 AM, Stephen Warren wrote:
> > Marc Dietrich wrote at Saturday, October 22, 2011 2:17 PM:
> >> * NOT FOR COMMIT *
> >>
> >> This just adds the dts for paz00. I like to add it to board-dt as
> >> well as soon as I find out which tree to base it on.
> > ...
> >> +++ b/arch/arm/boot/dts/tegra-paz00.dts
> >
> > One thing that cross my mind when writing the TrimSlice support and I
> > forgot to mention: Should these files be named ${soc}-${board}.dts or
> > ${vendor}-${board}.dts (tegra-paz00.dts or toshiba-paz00.dts or
> > compal-paz00.dts). I'm OK either way; just want to follow any outside
> > expectations.
> >
> >> @@ -0,0 +1,51 @@
> >> +/dts-v1/;
> >> +
> >> +/memreserve/ 0x1c000000 0x04000000;
> >> +/include/ "tegra20.dtsi"
> >> +
> >> +/ {
> >> +	model = "Toshiba AC100 / Dynabook AZ";
> >> +	compatible = "compal,paz00", "nvidia,tegra20";
> >> +
> >> +	chosen {
> >> +		bootargs = "console=ttyS0,115200n8 root=/dev/mmcblk1p1";
> >> +	};
> >> +
> >> +	memory at 0 {
> >
> > The other boards just have "memory" here; which is wrong?
> 
> Both... I believe it should be "memory@<base address>".

Tegra20's memory base address is 0, so I assume the quoted example above
is correct then.

-- 
nvpublic
