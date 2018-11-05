From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Mon, 5 Nov 2018 14:55:48 +0100
Subject: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
In-Reply-To: <0298f7ec-fbff-8edb-92bb-70a736ddaf25@mentor.com>
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
 <20181104144614.GJ26016@tiger>
 <0298f7ec-fbff-8edb-92bb-70a736ddaf25@mentor.com>
Message-ID: <CAJiuCcde0n5VGnqsXgnevKEk9KkPHf=_JMo7yyBBvX-PF_v2-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 5 Nov 2018 at 09:58, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
>
> Adding Cl?ment.
>
> On 11/04/2018 04:46 PM, Shawn Guo wrote:
> > On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
> >> The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> >> function blocks. Add their ipg and per clocks to the device tree.
> >>
> >> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> >
> > Are these EPIT devices actually used in upstream kernel, or just
> > somewhere else?
>
> Cl?ment wrote a good driver, which has already passed a series of reviews,
> but this clocks add-on is actually missing.
>
> Cl?ment, can you please add clock-names property and the corresponding
> functional change to your driver? Thank you in advance.

I'm converting it with the new timer-of framework, will check for
adding both clocks.

New patch should come this week I hope.

Regards,
Clement>
> --
> Best wishes,
> Vladimir
>
> >> ---
> >>
> >> I tried to make this similar to gpt1 and gpt2.
> >>
> >>  arch/arm/boot/dts/imx25.dtsi | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> >> index b25309d26ea5..e80101847aff 100644
> >> --- a/arch/arm/boot/dts/imx25.dtsi
> >> +++ b/arch/arm/boot/dts/imx25.dtsi
> >> @@ -388,12 +388,16 @@
> >>                      epit1: timer at 53f94000 {
> >>                              compatible = "fsl,imx25-epit";
> >>                              reg = <0x53f94000 0x4000>;
> >> +                            clocks = <&clks 83>, <&clks 43>;
> >> +                            clock-names = "ipg", "per";
> >>                              interrupts = <28>;
> >>                      };
> >>
> >>                      epit2: timer at 53f98000 {
> >>                              compatible = "fsl,imx25-epit";
> >>                              reg = <0x53f98000 0x4000>;
> >> +                            clocks = <&clks 84>, <&clks 43>;
> >> +                            clock-names = "ipg", "per";
> >>                              interrupts = <27>;
> >>                      };
> >>
> >> --
> >> 2.1.4
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
