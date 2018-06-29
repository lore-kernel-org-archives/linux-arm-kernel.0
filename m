From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 29 Jun 2018 11:30:18 -0700
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Add thermal-zones node
In-Reply-To: <CAD=FV=UPCgEvN1F5jFhLxq=KrH2_BwEG=ZRX3npy_EPLZ_V0hA@mail.gmail.com>
References: <20180628210915.160893-1-mka@chromium.org>
 <CAD=FV=UPCgEvN1F5jFhLxq=KrH2_BwEG=ZRX3npy_EPLZ_V0hA@mail.gmail.com>
Message-ID: <20180629183018.GU129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 03:52:57PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > The node is empty for now. It is needed to allow other DT snippets
> > to add thermal zone entries.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Sorry if you received this twice, lists were missing in cc in the first attempt ...
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 00722b533a92..968390fb0933 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -9,6 +9,7 @@
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >         interrupt-parent = <&intc>;
> > @@ -1087,4 +1088,7 @@
> >                         };
> >                 };
> >         };
> > +
> > +       thermal_zones: thermal-zones {
> > +       };
> 
> Others can feel free to disagree, but IMO ${SUBJECT} patch is not
> needed.  Instead patch #3 in your series should just define a
> "thermal-zones" node at the root level.  The "thermal-zones" node is a
> well-defined node with a well-defined node name and location (see the
> "thermal.txt" binding).  If the SoC has a "thermal-zones" node and so
> does the PMIC then they'll just be merged.

Just defining it here makes perfect sense, thanks!
