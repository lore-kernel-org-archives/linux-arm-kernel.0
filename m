From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 13:59:02 +0800
Subject: [PATCH v2 10/12] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <20120522051005.GN8140@S2101-09.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-11-git-send-email-richard.zhao@freescale.com>
 <20120522051005.GN8140@S2101-09.ap.freescale.net>
Message-ID: <20120522055901.GR6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:10:08PM +0800, Shawn Guo wrote:
> On Mon, May 21, 2012 at 05:23:55PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |   18 ++++++++++++-
> >  arch/arm/boot/dts/imx6q.dtsi          |   44 +++++++++++++++++++++++++++++++-
> >  2 files changed, 59 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > index 1dd2261..1d28957 100644
> > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -48,10 +48,26 @@
> >  					status = "okay";
> >  				};
> >  			};
> > -
> > +			iomuxc at 020e0000 {
> > +				gpios {
> > +					pinctrl_gpio_hog: gpiohog {
> 
> This isn't really welcomed, and should really be removed after we have
> gpio_request() be able to call pinctrl to set the mux.
Yes, but we don't have now. If I add dependency which don't even hit
next tree, I experienced people refuse pick my patch.
Of course, If you're ok to pick other patches, I can leave the code
locally for test.
> 
> > +						fsl,pins = <1044 0x80000000
> > +							   144  0x80000000>;	/* MX6Q_PAD_GPIO_17__GPIO_7_12 */
> 
> Here are what I get from fsl,imx6q-pinctrl.txt.  The comment was put on
> the wrong line?
> 
> MX6Q_PAD_EIM_D22__GPIO_3_22                     144
> MX6Q_PAD_GPIO_17__GPIO_7_12                     1044 
Good catch.
> 
> > +					};
> > +				};
> > +			};
> >  		};
> >  
> ...
> 
> > @@ -495,6 +500,11 @@
> >  					};
> >  				};
> >  
> > +				gpios {
> > +					pinctrl_gpio_hog: gpiohog {
> > +					};
> > +				};
> > +
> Why the empty nodes?
It's place holder that let use know to add gpio hog-on-boot in board dts.

Thanks
Richard
> 
> -- 
> Regards,
> Shawn
> 
