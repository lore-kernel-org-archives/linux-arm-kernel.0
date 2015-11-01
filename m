From: marex@denx.de (Marek Vasut)
Date: Mon, 2 Nov 2015 00:56:46 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: Add support for DENX MA5D4 SoM and
 EVK
In-Reply-To: <20151101234520.GH22331@piout.net>
References: <1446420425-5491-1-git-send-email-marex@denx.de>
 <20151101234520.GH22331@piout.net>
Message-ID: <201511020056.46860.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 02, 2015 at 12:45:20 AM, Alexandre Belloni wrote:
> Hi Marek,

Hi!

> On 02/11/2015 at 00:27:05 +0100, Marek Vasut wrote :
> > +	clocks {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> 
> You probably don't need those three properties

Truth to be told, I copied those from sama5d4ek.dts , but I think
you're right, they make no sense in this context.

> > +		main_clock: clock at 0 {
> > +			compatible = "atmel,osc", "fixed-clock";
> > +			clock-frequency = <12000000>;
> > +		};
> > +
> 
> likewise, if you don't need to boot on older kernels, I'd suggest
> removing clock at 0.

Consider this fixed, I certainly don't plan to boot anything old(er).

> > +/ {
> > +	model = "DENX MA5D4EVK";
> > +	compatible = "denx,ma5d4evk", "atmel,sama5d4", "atmel,sama5";
> > +
> > +	chosen {
> > +		bootargs = "ignore_loglevel earlyprintk";
> 
> I think you don't really want to enforce those options, especially
> earlyprintk as it can lead to a crash if UART_PHYS is not set properly
> (for example, I usually boot the same kernel on sama5d3 and sama5d4).

Same here, fixed.

Thanks for the review! I will wait a bit and then submit a V2.

Best regards,
Marek Vasut
