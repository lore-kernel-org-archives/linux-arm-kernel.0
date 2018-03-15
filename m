From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 15 Mar 2018 17:47:01 +0000
Subject: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
In-Reply-To: <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
 <1519775750-21297-2-git-send-email-jollys@xilinx.com>
 <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
 <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
 <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
 <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
Message-ID: <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Geert, Marek,

> -----Original Message-----
> From: Marek Szyprowski [mailto:m.szyprowski at samsung.com]
> Sent: Tuesday, March 06, 2018 12:06 AM
> To: Geert Uytterhoeven <geert@linux-m68k.org>; Rob Herring
> <robh@kernel.org>
> Cc: Jolly Shah <JOLLYS@xilinx.com>; Matthias Brugger
> <matthias.bgg@gmail.com>; Andy Gross <andy.gross@linaro.org>; Shawn Guo
> <shawnguo@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Bj?rn Andersson <bjorn.andersson@linaro.org>; sean.wang at mediatek.com;
> Michal Simek <michal.simek@xilinx.com>; Mark Rutland
> <mark.rutland@arm.com>; Rajan Vaja <RAJANV@xilinx.com>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; Linux ARM <linux-arm-
> kernel at lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
> bindings
> 
> Hi All,
> 
> On 2018-03-06 08:59, Geert Uytterhoeven wrote:
> > Hi Rob, Jolly,
> >
> > On Mon, Mar 5, 2018 at 11:39 PM, Rob Herring <robh@kernel.org> wrote:
> >> On Tue, Feb 27, 2018 at 03:55:49PM -0800, Jolly Shah wrote:
> >>> Add documentation to describe ZynqMP power domain bindings.
> >>>
> >>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> >>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> >>> ---
> >>>   .../devicetree/bindings/power/zynqmp-genpd.txt     | 46
> ++++++++++++++++++++++
> >>>   1 file changed, 46 insertions(+)
> >>>   create mode 100644
> >>> Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>> b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>> new file mode 100644
> >>> index 0000000..25f9711
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
> >>> +This node contains a number of subnodes, each representing a single
> >>> +PM domain that PM domain consumer devices reference.
> >>> +
> >>> +== PM Domain Nodes ==
> >>> +
> >>> +Required properties:
> >>> + - #power-domain-cells: Number of cells in a PM domain specifier. Must be
> 0.
> >>> + - pd-id: List of domain identifiers of as defined by platform firmware.
> These
> >>> +       identifiers are passed to the PM firmware.
> >>> +
> >>> +Example:
> >>> +     zynqmp-genpd {
> >>> +             compatible = "xlnx,zynqmp-genpd";
> >> What's the control interface for controlling the domains?
> >>> +
> >>> +             pd_usb0: pd-usb0 {
> >>> +                     pd-id = <22>;
> >>> +                     #power-domain-cells = <0>;
> >> There's no need for all these sub nodes. Make #power-domain-cells 1
> >> and put the id in the cell value.
> > That was my first reaction, too...
> >>> +             };
> >>> +
> >>> +             pd_sata: pd-sata {
> >>> +                     pd-id = <28>;
> >>> +                     #power-domain-cells = <0>;
> >>> +             };
> >>> +
> >>> +             pd_gpu: pd-gpu {
> >>> +                     pd-id = <58 20 21>;
> > ... until I saw the above.
> > Controlling the GPU power area requires controlling 3 physical areas?
> >
> > However, doing it this way may bite you in the future, if a need
> > arises to control a subset. And what about power up/down order?
> 
> What about defining 3 separate domains and arranging them in parent-child
> relationship? generic power domains already supports that and this allows to
> nicely define the power on/off order.
> 
> >>> +                     #power-domain-cells = <0x0>;
> >>> +             };
> >>> +     };
> 

I agree it should be arranged in as parent child order to control subset or control order. Will incorporate those changes in next version.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
