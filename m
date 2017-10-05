From: horms@verge.net.au (Simon Horman)
Date: Thu, 5 Oct 2017 11:05:01 +0200
Subject: [PATCH v2 8/8] arm64: dts: renesas: eagle: add EtherAVB support
In-Reply-To: <CAMuHMdVCTORpfKN+GTka_6pT1VWjOneV2GBhGo7Y8DsZYSxdvw@mail.gmail.com>
References: <20170915194449.538504992@cogentembedded.com>
 <CAMuHMdXQXFuVzwW7G-U7XWZUEj8qFRjtfDQF1+TgyzO0Xb+eYg@mail.gmail.com>
 <c0390fc1-7da4-ac60-afee-97126d1fd372@cogentembedded.com>
 <CAMuHMdVCTORpfKN+GTka_6pT1VWjOneV2GBhGo7Y8DsZYSxdvw@mail.gmail.com>
Message-ID: <20171005090500.GC26369@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 06:09:34PM +0200, Geert Uytterhoeven wrote:
> Hi Sergei,
> 
> On Thu, Sep 21, 2017 at 6:03 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > On 9/21/2017 4:08 PM, Geert Uytterhoeven wrote:
> >>> Define the Eagle board  dependent part of the EtherAVB device node.
> >>> Enable DHCP  and NFS root for the kernel booting.
> >>>
> >>> Based  on the original (and large) patch by Vladimir Barinov.
> >>>
> >>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >>
> >>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> >>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> >
> > [...]
> >>>
> >>> @@ -43,3 +44,14 @@
> >>>   &scif0 {
> >>>          status = "okay";
> >>>   };
> >>> +
> >>> +&avb {
> >>> +       renesas,no-ether-link;
> >>> +       phy-handle = <&phy0>;
> >>> +       status = "okay";
> >>> +
> >>> +       phy0: ethernet-phy at 0 {
> >>> +               rxc-skew-ps = <1500>;
> >>> +               reg = <0>;
> >>
> >>
> >> Any specific reason why you don't want to wire up the interrupt?
> >>
> >>                  interrupt-parent = <&gpio2>;
> >
> >
> >    I thought it's quite obvious -- we don't have GPIOs yet, and GPIOs seem
> > to require PFC.
> 
> Of course. And these can be added later.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
