From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 29 Sep 2014 11:53:29 +0100
Subject: [PATCH 3/4] ARM: DT: apq8064: Add USB OTG support
In-Reply-To: <542933E1.8010809@smartplayin.com>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982127-8048-1-git-send-email-srinivas.kandagatla@linaro.org>
 <542933E1.8010809@smartplayin.com>
Message-ID: <20140929105329.GA2432@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 11:26:41AM +0100, Kiran Padwal wrote:
> Hi Srinivas,
> 
> Some review are comments inline.
> 
> On Monday 29 September 2014 02:45 PM, Srinivas Kandagatla wrote:
> > This patch adds USB OTG support on USB1 of APQ8064 SOC.
> > Tested on IFC6410 with ethernet gadget.
> > 
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 14 +++++++++
> >  arch/arm/boot/dts/qcom-apq8064.dtsi        | 46 ++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> > index d6036b8..f41fb39 100644
> > --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> > +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> > @@ -40,6 +40,11 @@
> >  			};
> >  		};
> >  
> > +		/* OTG */
> > +		usb1_phy:phy at 12500000 {
> > +			status = "ok";
> 
> Its canonical value is "okay" (although in practice anything
> other than "disabled" should work).

That's not quite true, there are other "bad" values like "fail" and
"fail-sss" documented by ePAPR. In Linux, of_device_is_available errs on
the side of caution and checks for either "okay" or "ok", failing
otherwise

Regardless, please use the canonical "okay".

Mark.
