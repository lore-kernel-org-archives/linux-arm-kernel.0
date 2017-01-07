From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 6 Jan 2017 21:01:20 -0600
Subject: [PATCH 1/5] ARM: dts: qcom: apq8064: Add missing scm clock
In-Reply-To: <CALAqxLVGMzPmRBM5SPO=pQjuasf0f_aRJ+94FUHtidYYU7yhpA@mail.gmail.com>
References: <20161221114939.19973-1-bjorn.andersson@linaro.org>
 <CALAqxLVGMzPmRBM5SPO=pQjuasf0f_aRJ+94FUHtidYYU7yhpA@mail.gmail.com>
Message-ID: <20170107030120.GC5710@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 05:10:44PM -0800, John Stultz wrote:
> On Wed, Dec 21, 2016 at 3:49 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > As per the device tree binding the apq8064 scm node requires the core
> > clock to be specified, so add this.
> >
> > Cc: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-apq8064.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> > index 268bd470c865..78bf155a52f3 100644
> > --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> > @@ -303,6 +303,9 @@
> >         firmware {
> >                 scm {
> >                         compatible = "qcom,scm-apq8064";
> > +
> > +                       clocks = <&gcc CE3_CORE_CLK>;
> > +                       clock-names = "core";
> 
> 
> Tested-by: John Stultz <john.stultz@linaro.org>
> 
> I know Bjorn has a new version of this patch that uses the
> RPM_DAYTONA_FABRIC_CLK value, but that one results in problems with
> usb gadget functionality on my Nexus7.  This one seems to work ok
> though.

Odd.  Is the usb gadget using the daytona but not getting a reference?  I wonder
if this is related to not having the bus driver running the bus clk enablement
and frequencies.


Andy
