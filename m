From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Jan 2014 16:43:22 +0100
Subject: [PATCH v3 2/8] clk: sunxi: update clock-output-names dt binding
 documentation
In-Reply-To: <CAGb2v66+N9tgOO4X093WdiR4J+7Sk2TDVsMffDGo46iTezPQwA@mail.gmail.com>
References: <1389257565-19797-1-git-send-email-wens@csie.org>
 <1389257565-19797-3-git-send-email-wens@csie.org>
 <52D89BB1.3030206@elopez.com.ar>
 <CAGb2v66+N9tgOO4X093WdiR4J+7Sk2TDVsMffDGo46iTezPQwA@mail.gmail.com>
Message-ID: <20140130154322.GS3867@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Wed, Jan 29, 2014 at 09:52:57AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> On Fri, Jan 17, 2014 at 10:55 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> > Hi,
> >
> > El 09/01/14 05:52, Chen-Yu Tsai escribi?:
> >
> >> clock-output-names is now required for most of sunxi clock nodes, to
> >> provide the name of the corresponding clock. Add the new requirements,
> >> exceptions, as well as examples.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>   Documentation/devicetree/bindings/clock/sunxi.txt | 36
> >> +++++++++++++++++++----
> >>   1 file changed, 31 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt
> >> b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> index 0c127cd..8a9147d 100644
> >> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> >> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> @@ -44,10 +44,18 @@ Required properties for all clocks:
> >>         multiplexed clocks, the list order must match the hardware
> >>         programming order.
> >>   - #clock-cells : from common clock binding; shall be set to 0 except for
> >> -       "allwinner,*-gates-clk" where it shall be set to 1
> >> +       "allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk" and
> >> +       "allwinner,sun4i-pll6-clk" where it shall be set to 1
> >>
> >> -Additionally, "allwinner,*-gates-clk" clocks require:
> >> -- clock-output-names : the corresponding gate names that the clock
> >> controls
> >> +Additionally, most clocks require "clock-output-names":
> >> +- "allwinner,*-gates-clk" : the corresponding gate names that the clock
> >> controls
> >> +- "allwinner,sun4i-pll5-clk" : "pll5_ddr", "pll5_mbus"
> >> +- "allwinner,sun4i-pll6-clk" : "pll6_sata", "pll6_other"
> >> +- "allwinner,sun4i-cpu-clk", "allwinner,sun4i-axi-clk",
> >> +  "allwinner,sun4i-ahb-clk", "allwinner,sun4i-ahb-clk",
> >> +  "allwinner,sun4i-apb1-mux-clk", "allwinner,sun4i-apb1-clk"
> >> +  do not need "clock-output-names"
> >> +- all others clocks : the corresponding module name of that clock
> >
> >
> > As we discussed on IRC, I wonder if such verbosity is actually needed. Maybe
> > we should dictate that all clocks must list their corresponding outputs on
> > clock-output-names (with it being the module name if it only has one
> > output).
> 
> Maxime, could we get your input on this?

I didn't get it was a question for me. But I'm fine with both. If
making clock-output-names mandatory makes our life easier, let's do
it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140130/f0d18584/attachment.sig>
