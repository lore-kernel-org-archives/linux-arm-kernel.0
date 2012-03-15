From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 15 Mar 2012 16:32:31 +0100
Subject: [PATCH v2] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <201203142001.58762.sr@denx.de>
References: <1331737232-25477-1-git-send-email-sr@denx.de>
 <201203141749.05899.sr@denx.de>
 <20120314172435.GP18320@game.jcrosoft.org>
 <201203142001.58762.sr@denx.de>
Message-ID: <20120315153231.GA7757@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:01 Wed 14 Mar     , Stefan Roese wrote:
> On Wednesday 14 March 2012 18:24:35 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > diff --git a/arch/arm/boot/dts/spear600-evb.dts
> > > > > b/arch/arm/boot/dts/spear600-evb.dts new file mode 100644
> > > > > index 0000000..cbfda8d
> > > > > --- /dev/null
> > > > > +++ b/arch/arm/boot/dts/spear600-evb.dts
> > > > > @@ -0,0 +1,30 @@
> > > > > +/*
> > > > > + * Copyright 2012 Stefan Roese <sr@denx.de>
> > > > > + *
> > > > > + * The code contained herein is licensed under the GNU General
> > > > > Public + * License. You may obtain a copy of the GNU General Public
> > > > > License + * Version 2 or later at the following locations:
> > > > > + *
> > > > > + * http://www.opensource.org/licenses/gpl-license.html
> > > > > + * http://www.gnu.org/copyleft/gpl.html
> > > > > + */
> > > > > +
> > > > > +/dts-v1/;
> > > > > +/include/ "spear600.dtsi"
> > > > > +
> > > > > +/ {
> > > > > +	model = "ST SPEAr600 Evaluation Board";
> > > > > +	compatible = "st,spear600-evb", "st,spear600";
> > > > > +	#address-cells = <1>;
> > > > > +	#size-cells = <1>;
> > > > 
> > > > please put the mem size here
> > > 
> > > Might I ask why? Other *.dtsi files don't have it either.
> > 
> > do not expect the bootloader to put it. I t's not mandatory
> 
> But the memory node it is already present in spear600.dtsi (see below). Do we 
> really need to duplicate this in the board specific dts file?
no if the mem is the same size please drop the commentabout bootloader update
it's a common knowlegde on DT for ARM
>  
> > > > > +
> > > > > +	soc {
> > > > > +		gmac0: ethernet at e0800000 {
> > > > > +			phy-mode = "gmii";
> > > > > +		};
> > > > > +
> > > > > +		i2c at d0200000 {
> > > > > +			clock-frequency = <400000>;
> > > > > +		};
> > > > > +	};
> > > > > +};
> > > > > diff --git a/arch/arm/boot/dts/spear600.dtsi
> > > > > b/arch/arm/boot/dts/spear600.dtsi new file mode 100644
> > > > > index 0000000..e45e58f
> > > > > --- /dev/null
> > > > > +++ b/arch/arm/boot/dts/spear600.dtsi
> > > > > @@ -0,0 +1,162 @@
> > > > > +/*
> > > > > + * Copyright 2012 Stefan Roese <sr@denx.de>
> > > > > + *
> > > > > + * The code contained herein is licensed under the GNU General
> > > > > Public + * License. You may obtain a copy of the GNU General Public
> > > > > License + * Version 2 or later at the following locations:
> > > > > + *
> > > > > + * http://www.opensource.org/licenses/gpl-license.html
> > > > > + * http://www.gnu.org/copyleft/gpl.html
> > > > > + */
> > > > > +
> > > > > +/include/ "skeleton.dtsi"
> > > > > +
> > > > > +/ {
> > > > > +	compatible = "st,spear600";
> > > > > +
> > > > > +	cpus {
> > > > > +		cpu at 0 {
> > > > > +			compatible = "arm,arm926ejs";
> > > > > +		};
> > > > > +	};
> > > > > +
> > > > > +	memory {
> > > > > +		device_type = "memory";
> > > > > +		reg = <0 0>; /* Filled by U-Boot */
> > > > 
> > > > please put the max mem of the SoC here
> > > 
> > > Why? It's always updated by the bootloader. And a max. mem size (when not
> > > updated to the correct mem size by the bootloader) would crash the board
> > > if it is equipped with less memory.
> > 
> > yes but we descripbe the soc here and on the dts you reduce it
> > Never expect the bootloader to update it.
> 
> Without update to real size we're doomed.
yes but the board dts is supposed to udpate it

you put the max in the soc dtsi

and the real mem size in board dts

Best Regards,
J.
