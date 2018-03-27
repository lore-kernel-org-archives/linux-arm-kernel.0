From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Mar 2018 10:17:16 +0200
Subject: [PATCH v2 2/3] arm64: dts: renesas: salvator-common: Configure
 PMIC for DDR Backup Power
In-Reply-To: <CAMuHMdW5ox34+_Z76T+cDyZeuJJE4OZ8=hEpdjbCcg+TwSX61A@mail.gmail.com>
References: <1521029386-29975-1-git-send-email-geert+renesas@glider.be>
 <1521029386-29975-3-git-send-email-geert+renesas@glider.be>
 <9c6289e4-23dd-c79b-bd1f-058d843739d2@cogentembedded.com>
 <CAMuHMdUO-Op4u44naZJ37VgzN1GJBL33yRWnF11D9a24y8+x1g@mail.gmail.com>
 <1ae32fee-578e-1091-561a-200a8036b670@cogentembedded.com>
 <20180326090625.espsuzblp7gy767t@verge.net.au>
 <CAMuHMdW5ox34+_Z76T+cDyZeuJJE4OZ8=hEpdjbCcg+TwSX61A@mail.gmail.com>
Message-ID: <20180327081715.rab6rr4xobmgwofl@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 11:13:54AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Mar 26, 2018 at 11:06 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Mar 16, 2018 at 03:08:13PM +0300, Sergei Shtylyov wrote:
> >> On 03/16/2018 03:00 PM, Geert Uytterhoeven wrote:
> >>
> >> >>> On Salvator-X(S), all of the DDR0, DDR1, DDR0C, and DDR1C power rails
> >> >>> need to be kept powered when backup mode is enabled.  Reflect this in
> >> >>> the "rohm,ddr-backup-power" property for the BD9571MWV PMIC node.
> >> >>>
> >> >>> The accessory power switch (SW23) is a toggle switch, hense specify
> >> >>> "rohm,rstbmode-level".
> >> >>>
> >> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> >>> ---
> >> >>> v2:
> >> >>>   - Add rohm,rstbmode-level.
> >> >>> ---
> >> >>>  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 ++
> >> >>>  1 file changed, 2 insertions(+)
> >> >>>
> >> >>> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> >> >>> index 2a7f36abd2dd85c6..80794c38c2669d75 100644
> >> >>> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> >> >>> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> >> >>> @@ -376,6 +376,8 @@
> >> >>>               #interrupt-cells = <2>;
> >> >>>               gpio-controller;
> >> >>>               #gpio-cells = <2>;
> >> >>> +             rohm,ddr-backup-power = <15>;
> >> >>
> >> >>   Why not 0xf if those are all bit flags?
> >> >
> >> > Because it's a small number?
> >> > Does it matter?
> >>
> >>    I think hex is preferable for the bit flags. Decimal makes one think it's something
> >> else -- some magnitude, etc...
> >
> > Geert, it seems that Rob Herring is of the same opinion.
> > Would you care to respin this series?
> 
> Sure, after the respun driver series has been accepted.

Perfect, thanks!
