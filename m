From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Jul 2016 10:26:48 +0200
Subject: [PATCH 06/14] ARM: dts: sun8i: Add cpu0 label to sun8i-h3.dtsi
In-Reply-To: <49ce09ae-052a-bb2b-ce66-f0aa0d0024e3@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-7-megous@megous.com>
 <CAGb2v66eskVAxdz8VtjBJBCO7VV9WL4bdFDVrPWrSmxk4RASCw@mail.gmail.com>
 <adaf7f61-af80-cc02-8c47-af721b86f81e@megous.com>
 <CAGb2v665O75vQEfo5WdWtWJSbKEbLi6MBAHbgZC7pyrOCOu+6g@mail.gmail.com>
 <20160625070208.GA4000@lukather>
 <49ce09ae-052a-bb2b-ce66-f0aa0d0024e3@megous.com>
Message-ID: <20160725082648.GG7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 17, 2016 at 04:39:27PM +0200, Ond?ej Jirman wrote:
> 
> 
> On 25.6.2016 09:02, Maxime Ripard wrote:
> > On Sat, Jun 25, 2016 at 09:02:48AM +0800, Chen-Yu Tsai wrote:
> >> On Sat, Jun 25, 2016 at 6:51 AM, Ond?ej Jirman <megous@megous.com> wrote:
> >>> Hello,
> >>>
> >>> comments below.
> >>>
> >>> On 24.6.2016 05:48, Chen-Yu Tsai wrote:
> >>>> On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
> >>>>> From: Ondrej Jirman <megous@megous.com>
> >>>>>
> >>>>> Add label to the first cpu so that it can be referenced
> >>>>> from derived dts files.
> >>>>>
> >>>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
> >>>>> ---
> >>>>>  arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> >>>>> index 9938972..82faefc 100644
> >>>>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> >>>>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> >>>>> @@ -52,7 +52,7 @@
> >>>>>                 #address-cells = <1>;
> >>>>>                 #size-cells = <0>;
> >>>>>
> >>>>> -               cpu at 0 {
> >>>>> +               cpu0: cpu at 0 {
> >>>>>                         compatible = "arm,cortex-a7";
> >>>>>                         device_type = "cpu";
> >>>>>                         reg = <0>;
> >>>>
> >>>> Can you also set the cpu clock here? It is part of the SoC
> >>>> and does not belong in the board DTS files.
> >>>
> >>> Do you mean operating-points, or something else? Different SBCs will
> >>> probably require different combinations of operating points just for
> >>> safety's sake, because they have different regulators and [some have
> >>> botched] thermal designs, so it might make sense to customize it for
> >>> differnt boards, and I don't feel adventurous enough setting it for all
> >>> H3 boards out there.
> >>
> >> I meant clocks = <...> and clock-latency = <...>.
> >>
> >> These 2 are part of the SoC.
> >>
> >> The OPP can stay in the board files. It's a pity there's no standard
> >> OPP table for H3 though. :(
> > 
> > This has never been the case, and we always had some deviation in the
> > FEX files for all the SoCs.
> > 
> > If we could come up with standard OPPs that work for every one,
> > there's no reason it can't happen here.
> > 
> > I don't really see why the thermal design should change anything. If a
> > boards heats faster, it will throttle down to a lower OPP faster, but
> > those OPPs are not going to change.
> 
> So I tried, and found out that it will not be so easy. Different boards
> have different regulators, and linux doesn't deal well with voltages
> that are not supported by the regulator.
> 
> So even if the board can run at certain frequency if you round the
> voltage to the next higher voltage supported by the regulator, opp
> implementation doesn't do the rounding and just drops the operating
> points that have no support in the voltage regulator.
> 
> We have boards that have 1.1/1.3V switching, only 1.3V, fine tuned
> voltage regulation and every such board will need it's own set of
> operating points.
> 
> I'd leave the OPP definitions in the board files for now.

Works for me.

Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/402ec2ce/attachment.sig>
