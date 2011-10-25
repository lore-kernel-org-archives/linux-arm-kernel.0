From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 25 Oct 2011 21:05:08 +0200
Subject: [PATCH 3/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173E1B4189@HQMAIL01.nvidia.com>
References: <cover.1319313019.git.marvin24@gmx.de>
	<90ee88bcde84141e0280ffa4ccbd288462489eba.1319313020.git.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B4189@HQMAIL01.nvidia.com>
Message-ID: <2821699.TeokzqUUds@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2011 22:16:15 Stephen Warren wrote:
> Marc Dietrich wrote at Saturday, October 22, 2011 2:17 PM:
> > * NOT FOR COMMIT *
> > 
> > This just adds the dts for paz00. I like to add it to board-dt as
> > well as soon as I find out which tree to base it on.
> 
> ...
> 
> > +++ b/arch/arm/boot/dts/tegra-paz00.dts
> 
> One thing that cross my mind when writing the TrimSlice support and I
> forgot to mention: Should these files be named ${soc}-${board}.dts or
> ${vendor}-${board}.dts (tegra-paz00.dts or toshiba-paz00.dts or
> compal-paz00.dts). I'm OK either way; just want to follow any outside
> expectations.

I also don't know. I prefer compal for paz00 because Toshiba's code name was 
procyon (I think) and I don't want to change all the naming. Also Toshiba 
showed no interest in helping us, so I don't see why they should get the fame.

> > @@ -0,0 +1,51 @@
> > +/dts-v1/;
> > +
> > +/memreserve/ 0x1c000000 0x04000000;
> > +/include/ "tegra20.dtsi"
> > +
> > +/ {
> > +	model = "Toshiba AC100 / Dynabook AZ";
> > +	compatible = "compal,paz00", "nvidia,tegra20";
> > +
> > +	chosen {
> > +		bootargs = "console=ttyS0,115200n8 root=/dev/mmcblk1p1";
> > +	};
> > +
> > +	memory at 0 {
> 
> The other boards just have "memory" here; which is wrong?

I just copy-pasted from harmony, I guess it doesn't matter.

> 
> ...
> 
> > +	i2c at 7000c500 {
> > +		clock-frequency = <80000>;
> 
> That's a pretty odd I2C frequency...

no, 80000 is even ;-) Seriously, it just reflects the fact that the embedded 
controller bus runs at 80kHz. Even more seriously, reading "booting-without-
of.txt" in the Documentation/devicetree dir,

      | o PowerPC,970 at 0
      |   |- name = "PowerPC,970"
      |   |- device_type = "cpu"
      |   |- reg = <0>
      |   |- clock-frequency = <5f5e1000>
      |   |- 64-bit
      |   |- linux,phandle = <2>

 it looks like all clock-frequency values are hexadecimal. In this case even 
<400000> would be wrong (or the docu is --- ok, the docu is wrong).

Marc
