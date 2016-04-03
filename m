From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 3 Apr 2016 17:08:54 +0900
Subject: dtc warnings
In-Reply-To: <20160403065909.GF2987@vireshk-i7>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
 <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
 <56FE7E4A.2000601@ti.com> <20160403065909.GF2987@vireshk-i7>
Message-ID: <20160403080854.GA12133@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 12:29:09PM +0530, Viresh Kumar wrote:
> On 01-04-16, 08:57, Nishanth Menon wrote:
> > On 04/01/2016 02:53 AM, Krzysztof Kozlowski wrote:
> > > On Fri, Apr 1, 2016 at 4:49 PM, Tomi Valkeinen <tomi.valkeinen@gmail.com> wrote:
> > >>
> > >> Hi Rob,
> > >>
> > >> On 01/04/16 04:40, Rob Herring wrote:
> > >>> You may have noticed that linux-next had gotten noisy with dtc
> > >>> warnings lately. I dropped the change for a bit, but added it back
> > >>> today except now it is disabled unless building with "W=1".
> > >>>
> > >>> There's ~25K (2500 unique) warnings generated from the ARM dts files.
> > >>> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
> > >>> on the similar counts, probably lots of duplicates). Please help
> > >>> remind contributors to test with W=1 and start to fix these.
> > >>>
> > >>> At least for memory nodes, I plan to whitelist allowing no
> > >>> unit-address. There could be others, but none that I've seen so far.
> > >>
> > >> What's the correct way to fix nodes for display platform devices? For
> > >> example, omap4-panda-common.dtsi has two connector nodes:
> > >>
> > >> dvi0: connector at 0 {
> > >>         compatible = "dvi-connector";
> > >>         label = "dvi";
> > >>         ...
> > >> };
> > >>
> > >>
> > >> hdmi0: connector at 1 {
> > >>         compatible = "hdmi-connector";
> > >>         label = "hdmi";
> > >>         ...
> > >> };
> > > 
> > > I have the same doubts. The ePAPR says in that case "the node-name
> > > alone differentiates the node from other nodes at the same level in
> > > the tree.". But which is preferred? Differentiating by number or by
> > > type?
> > > 
> > > Similarly, what to do with the opp modes (a lot of warnings) in
> > > Documentation/devicetree/bindings/opp/opp.txt?
> 
> What warnings are you talking about ?

Warnings coming from recent linux-next:

  DTC     arch/arm/boot/dts/exynos5800-peach-pi.dtb
Warning (unit_address_vs_reg): Node /opp_table0/opp at 1800000000 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /opp_table0/opp at 1700000000 has a unit name, but no reg property
...

Best regards,
Krzysztof
