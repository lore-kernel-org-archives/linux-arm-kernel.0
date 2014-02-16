From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 16 Feb 2014 21:33:52 +0100
Subject: [PATCH 02/12] dt-bindings: document s3c24xx controller for
 external clock output
In-Reply-To: <52F6DFE0.7030508@gmail.com>
References: <201312131356.40755.heiko@sntech.de>
 <201312131359.00450.heiko@sntech.de> <52F6DFE0.7030508@gmail.com>
Message-ID: <5620516.DA2mHk7Kko@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 9. Februar 2014, 02:54:40 schrieb Tomasz Figa:
> Hi Heiko,
> 
> On 13.12.2013 13:59, Heiko St?bner wrote:
> > The clock settings are distributed over a regular register and parts
> > of the misccr register.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >   .../bindings/clock/samsung,s3c2410-dclk.txt        |   53
> >   ++++++++++++++++++++ 1 file changed, 53 insertions(+)
> >   create mode 100644
> >   Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt> 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
> > b/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt new
> > file mode 100644
> > index 0000000..0a1f7b1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
> > @@ -0,0 +1,53 @@
> > +* Samsung S3C24XX External Clock Output Controller
> > +
> > +The S3C24XX series can generate clock signals on two clock output pads.
> > +The clock binding described here is applicable to all SoCs in
> > +the s3c24x family.
> > +
> > +Required Properties:
> > +
> > +- compatible: should be one of the following.
> > +  - "samsung,s3c2410-dclk" - controller in S3C2410 SoCs.
> > +  - "samsung,s3c2412-dclk" - controller in S3C2412 SoCs.
> > +  - "samsung,s3c2440-dclk" - controller in S3C2440 and S3C2442 SoCs.
> > +  - "samsung,s3c2443-dclk" - controller in S3C2443 and later SoCs.
> > +- reg: physical base address of the controller and length of memory
> > mapped
> > +  region.
> > +- #clock-cells: should be 1.
> > +- samsung,misccr: phandle to the syscon managing the misccr register,
> > which +  holds configuration settings for different soc-components
> > (clocks, usb, ...).
> Hmm, looking at the datasheet, DCLK and CLKOUT registers seem to be part
> of the pin controller. I wonder if there is really a need for different
> driver and device node to handle them.
> 
> Could this be simply made a part of the s3c24xx pinctrl driver,
> extending it to register also a clock provider under the same DT node?

it could, but of course the non-dt platforms would not be able to use it in 
this case.

So I guess, we could get rid of this dt binding, implement the clkout handling 
in the pinctrl driver for dt platforms, but use the platform-driver this 
binding described for the time we're still handling non-dt s3c24xx machines.


Heiko
