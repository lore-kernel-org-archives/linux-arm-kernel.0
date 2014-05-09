From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 May 2014 20:08:47 +0800
Subject: [PATCH v2] ARM: dts: imx6: add new board RIoTboard
In-Reply-To: <536C8837.9090802@gmail.com>
References: <53695C34.5000604@gmail.com> <20140508054106.GH2794@dragon>
 <536B4ACD.30001@gmail.com> <20140509030938.GK2794@dragon>
 <536C8837.9090802@gmail.com>
Message-ID: <20140509120845.GO2794@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 08:48:07AM +0100, Iain Paton wrote:
> On 09/05/14 04:09, Shawn Guo wrote:
> > On Thu, May 08, 2014 at 10:13:49AM +0100, Iain Paton wrote:
> 
> >> +&ecspi1 {
> >> +	fsl,spi-num-chipselects = <1>;
> >> +	cs-gpios = <&gpio5 17 0>;
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pinctrl_ecspi1>;
> >> +	status = "okay";
> >> +
> >> +	spidev at 0 {
> >> +		spi-max-frequency = <24000000>;
> >> +		reg = <0>;
> >> +		compatible = "spidev";
> >> +	};
> > 
> > What's this?  Is this the common way we code spi devices in device tree?
> 
> I'd appreciate your guidance here, what would you prefer?
> 
> My reasons for adding spidev were as follows:
> 
> 1. The SPI pins are not used on the board, they go to an expansion header.
> 2. Board is targeted at makers who are likely to want to attach 
>    external devices.
> 3. Experience has been that if they don't find an easy and already 
>    configured way to use something they reach for devmem2 or similar.
> 4. devicetree is often seen as being too hard by people who come to these
>    boards from things like arduino
> 
> I've already had questions on how to find the physical address of /dev/i2c-0 
> seemingly due to some of the above.
> 
> I'm happy to drop the spidev entries if that's what you'd prefer, but if I
> do that I'm undecided if I should then just drop the ecspi sections as well 
> and free up more gpio pins on the expansion header for other uses.

You can decide if you want to drop or keep the ecspi sections.  I prefer
to drop those spidev nodes, before we're not sure this is the right way
to go.

Shawn
