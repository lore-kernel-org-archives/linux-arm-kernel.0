From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 14:28:51 +0800
Subject: [linux-sunxi] [PATCH v4 04/10] arm64: allwinner: dts: h6: add
 USB2-related device nodes
In-Reply-To: <CAGb2v66Lndq1GMRDda3+2go1snGVS1fKTJTrHpP-B20FtG6VZA@mail.gmail.com>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-5-icenowy@aosc.io>
 <CAGb2v668dozjLm9mWUw_Y12AZ6DM2ku9dgQ8B8feABNeFf3QSw@mail.gmail.com>
 <4B5BD39B-22E2-4DEA-A199-29094DB8C317@aosc.io>
 <CAGb2v66Lndq1GMRDda3+2go1snGVS1fKTJTrHpP-B20FtG6VZA@mail.gmail.com>
Message-ID: <CAGb2v64_=YhrDPYAoPxO4YH6OZENAM-nDDhqnCD0Fj26sKwQ7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:16 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Nov 14, 2018 at 6:31 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> > ? 2018?11?14? GMT+08:00 ??6:21:33, Chen-Yu Tsai <wens@csie.org> ??:
> > >Hi,
> > >
> > >On Thu, Oct 4, 2018 at 8:30 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> > >>
> > >> Allwinner H6 has two USB2 ports, one OTG and one host-only.
> > >>
> > >> Add device tree nodes related to them.
> > >>
> > >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > >> ---
> > >> No changes in v4.
> > >>
> > >> Changes in v3:
> > >> - Removed the wrongly introduced usb3phy node.
> > >> - Added Chen-Yu's Review tag.
> > >>
> > >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 81
> > >++++++++++++++++++++
> > >>  1 file changed, 81 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >> index 040828d2e2c0..3d60af6cb3ae 100644
> > >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >> @@ -258,6 +258,87 @@
> > >>                         status = "disabled";
> > >>                 };
> > >>
> > >> +               usb2otg: usb at 5100000 {
> > >> +                       compatible = "allwinner,sun8i-a33-musb";
> > >
> > >I added an SoC-specific compatible: "allwinner,sun50i-h6-musb".
> > >
> > >I'm also curious as to whether the MUSB controller was tested or not,
> > >since Allwinner now has EHCI/OHCI host pairs for host mode, and the
> > >Pine H64
> > >only does host mode.
> >
> > USB plug-in detection relays on MUSB if it's enabled.
>
> That's not what I meant. Have you actually used the MUSB core in either
> device or host mode to know that it is compatible with the A33? And
> that it works correctly?
>
> IIRC ID detection is done by the PHY driver, using the GPIO lines.
> In host mode, since it's already directly routed to the host pair,
> it's the host pair that does plug-in detection. The MUSB core is
> completely unused. It should be quite clear if you look at the times
> each interrupt line fired.

I forced the routing to use MUSB and it looks like it works OK.
And the BSP figures for the number of endpoints looks correct.
I'll push the patches out. Thanks.

ChenYu
