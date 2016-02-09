From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 9 Feb 2016 11:18:33 +0100
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <2530828.WgKqLzsO0l@wuerfel>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
 <2530828.WgKqLzsO0l@wuerfel>
Message-ID: <20160209101833.GD5388@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Mon, Feb 08, 2016 at 01:20:40PM +0100, Arnd Bergmann wrote:
> On Monday 08 February 2016 10:11:38 Antoine Tenart wrote:
> > index 000000000000..3e3080fa45e4
> > --- /dev/null
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	model = "Annapurna Labs Alpine v2";
> > +	compatible = "al,alpine-v2";
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart1;
> > +		serial2 = &uart2;
> > +		serial3 = &uart3;
> > +	};
> 
> Move the aliases to the .dts files and drop the ones that are disabled.

Sure.

> > +
> > +		pcie-internal at 0xfbc00000 {
> 
> make this
> 
> 		pci at fbc00000 {

Will do.

> 
> > +			compatible = "pci-host-ecam-generic";
> > +			device_type = "pci";
> > +			#size-cells = <2>;
> > +			#address-cells = <3>;
> > +			#interrupt-cells = <1>;
> > +			reg = <0x0 0xfbc00000 0x0 0x100000>;
> > +			interrupt-map-mask = <0xf800 0 0 7>;
> > +			/* add legacy interrupts for SATA only */
> > +			interrupt-map = <0x4000 0 0 1 &gic 0 53 4>,
> > +					<0x4800 0 0 1 &gic 0 54 4>;
> 
> What's wrong with the other IRQs? Not connected?

>From what I know the other IRQs are disconnected.

> > +
> > +		uart0: uart at fd883000 {
> 
> 			serial at fd883000
> 
> 
> Almost all devices are in the 0xfd000000 range. Could this be a bus in the
> SoC that has all the devices attached to it? Maybe use a "ranges" property
> to reflect that. In doubt, use the register numbers from the data sheet if you
> have one.

I'll try using a range property in the v2 of the series.

Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/4136e467/attachment.sig>
