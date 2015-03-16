From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 13:50:09 -0700
Subject: [PATCH 2/3] ARM: dts: am335x: Add DTS for ChiliSOM module
In-Reply-To: <1423493285-4231-2-git-send-email-lisovy@jablotron.cz>
References: <1423493285-4231-1-git-send-email-lisovy@jablotron.cz>
 <1423493285-4231-2-git-send-email-lisovy@jablotron.cz>
Message-ID: <20150316205008.GB12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rostislav Lisovy <lisovy@gmail.com> [150209 06:51]:
> Since this is a SOM (System on Module) that will be part
> of another embedded board (and can't really exist on its own)
> define it as a "dtsi" that will be included in the Device tree
> describing the whole system later on.
> 
> Hardware specification:
> * AM335x SoC
> * up to 512 MB RAM
> * NAND Flash (8x interface, cs0)
> * UART0
> * PMIC
> * I2C0 (for PMIC)
> * 1x Ethernet MAC

Applying all three into omap-for-v4.1/dt with one change
below.
 
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
> +
> +&gpmc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nandflash_pins>;
> +	ranges = <0 0 0x08000000 0x01000000>; /* CS0 0 @addr 0x08000000, size 0x01000000 */
> +	nand at 0,0 {
> +		reg = <0 0 0x01000000>; /* CS0 */

I've changed this to say just:
		reg = <0 0 4>;  /* CS0, offset 0, IO size 4 */

As for NAND the device has just one IO register. The 0x01000000
is the size of a minimum GPMC partition.

Regards,

Tony
