From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Thu, 26 May 2016 11:49:46 +0200
Subject: [PATCH 02/11] drivers: clk: st: Add clock propagation for audio
 clocks
In-Reply-To: <20160525172409.GA27913@rob-hp-laptop>
References: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
 <1463560892-7209-3-git-send-email-gabriel.fernandez@linaro.org>
 <20160525172409.GA27913@rob-hp-laptop>
Message-ID: <CAG374jDTCJfZB+PuAnggjXhbcd3NjJqrESpe_EnMniCAeoph9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2016 at 19:24, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 18, 2016 at 10:41:23AM +0200, Gabriel Fernandez wrote:
> > This patch allows fine tuning of the quads FS for audio clocks
> > accuracy.
> >
> > Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> > ---
> >  .../devicetree/bindings/clock/st/st,flexgen.txt    |  1 +
> >  drivers/clk/st/clk-flexgen.c                       | 24 ++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
> > index b7ee5c7..15b33c7 100644
> > --- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
> > +++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
> > @@ -60,6 +60,7 @@ This binding uses the common clock binding[2].
> >  Required properties:
> >  - compatible : shall be:
> >    "st,flexgen"
> > +  "st,stih407-clkgend0", "st,flexgen" (enable clock propagation on parent)
>
> What do "d0" and "d2" refer to?
>
> This seems to indicate you have too much clock detail in the DT (with
> individual clocks described) or not enough with genericish compatible
> strings. What happens for the mext clock you need to adjust the flags
> on? You should be able to make these adjustments without DT updates.
> Perhaps you need a wider fixing of clock compatible strings.
>
> Rob

Sorry i sent my response in html...

Hi Rob,

Thanks for reviewing.

Can i remove
"
st,stih407-clkgend0" & "
st,stih407-clkgend2" compatible strings and add proprieties instead ?
I only need to activate 2 features and then we can keep generic
compatible strings.

e.g.

clk_s_d2_flexgen: clk-s-d2-flexgen {
#clock-cells = <1>;
compatible = "st,flexgen";
        ...
       st-sync-mode;
        st-update
-parent-rate;
};

for d0_flexgen i will enable only st-sync-mode;

Best Regards
