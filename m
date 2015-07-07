From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 7 Jul 2015 14:56:46 +0800
Subject: [PATCH v2 2/4] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock controllers
In-Reply-To: <CAGS+omAo-d_bK=2HDu98xHvqhnVgJUBy4jbYVGKqsfWRX-EfDA@mail.gmail.com>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-3-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omD9Mvz0-RQMc5TsWCPct80S5fyqMn3+-zR7HB9yb7KoDQ@mail.gmail.com>
 <1435805534.3526.23.camel@mtksdaap41>
 <CAGS+omCgNstb+NPmRdbngnLm754hDPLO28KRc4RanCD2Myv7dQ@mail.gmail.com>
 <5595CBDC.7090101@codeaurora.org>
 <CAGS+omAo-d_bK=2HDu98xHvqhnVgJUBy4jbYVGKqsfWRX-EfDA@mail.gmail.com>
Message-ID: <1436252206.3526.80.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 2015-07-03 at 18:46 +0800, Daniel Kurtz wrote:
> On Fri, Jul 3, 2015 at 7:40 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > DT nodes typically have a reg property. Not having a reg property is a
> > good indicator of a problem with the binding. A syscon is used when you
> > have a DT node with a reg property and some driver attached to it, but
> > you need to poke some bits in another register region that isn't part of
> > the reg property. Instead of having multiple nodes with two reg
> > properties where the second one is the same, we use a phandle and a syscon.
> >
> > If clock-controller isn't acceptable maybe clock-reset-contoller would
> > work? Or "power-controller"? We certainly shouldn't be making up
> > multiple nodes for one hardware block. Of course, the subject of the
> > patch is "bindings for clock controllers", so it may be that the
> > registers are predominantly clock related and so the name is appropriate
> > already.
> 
> Using "clock-controller" seems to fit best with the bindings
> introduced by this patch.
> 
> However, if these bindings are for hardware blocks that contain a grab
> bag of various functionality that will be added in later patches, then
> I think "syscon" might be best.

I referred some dt-binding documents that contain clock and reset
controller in the same unit:

qcom,gcc.txt:

	clock-controller at 900000 {
		compatible = "qcom,gcc-msm8960";

nvidia,tegra124-car.txt:

	tegra_car: clock {
		compatible = "nvidia,tegra124-car";

rockchip,rk3188-cru.txt:

	cru: cru at 20000000 {
		compatible = "rockchip,rk3188-cru";

Rockchip use "Clock and Reset Unit" as their controller's name. The
other two use "clock" or "clock-controller" as their controller's name.

It looks like "clock-controller" is also an acceptable name for
clock/reset controllers. So I would like to keep this name in next
patch.


Best regards,

James
