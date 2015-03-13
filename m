From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 13 Mar 2015 10:40:43 +0800
Subject: [PATCH 1/3] ARM: imx6qdl-sabreauto.dtsi: add max7310 support
In-Reply-To: <20150311014606.GY20455@dragon>
References: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
 <1425893288-1517-2-git-send-email-peter.chen@freescale.com>
 <20150311014606.GY20455@dragon>
Message-ID: <20150313024041.GA24143@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 09:46:09AM +0800, Shawn Guo wrote:
> On Mon, Mar 09, 2015 at 05:28:06PM +0800, Peter Chen wrote:
> > max7310 is an i2c interface gpio expander
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 43 ++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > index 009abd6..51acfec 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > @@ -28,6 +28,13 @@
> >  		};
> >  	};
> >  
> > +	max7310_reset: max7310-reset {
> > +		compatible = "gpio-reset";
> 
> The mainline kernel doesn't seem to have a gpio-reset driver/binding
> yet.
> 

Yeah, the driver still handles reset by itself instead of DT.
Even without reset operation, my max7310 chip works ok.
Would you accept that I delete this reset operation
and send v2?

-- 

Best Regards,
Peter Chen
