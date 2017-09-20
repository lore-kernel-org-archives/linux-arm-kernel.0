From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 20 Sep 2017 16:04:02 +0800
Subject: [linux-sunxi] Re: [PATCH v4 1/6] dt-bindings: update the
 Allwinner GPADC device tree binding for H3
In-Reply-To: <20170920075223.jaeswlhcqgu4yhse@flea.home>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-2-icenowy@aosc.io>
 <20170918073336.j7finend3g76chsu@flea.lan>
 <310CE549-B8CE-4C0C-95B1-B545E38BDAF5@aosc.io>
 <20170918083045.7bfiialtbm7w6i7j@flea.lan>
 <e73ead447af89031749e85207cac1e69@aosc.io>
 <20170920075223.jaeswlhcqgu4yhse@flea.home>
Message-ID: <27449039-F0D4-4663-B596-C95D4408D471@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?9?20? GMT+08:00 ??3:52:23, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Mon, Sep 18, 2017 at 03:47:25PM +0000, icenowy at aosc.io wrote:
>> ? 2017-09-18 16:30?Maxime Ripard ???
>> > On Mon, Sep 18, 2017 at 03:36:43PM +0800, Icenowy Zheng wrote:
>> > > ? 2017?9?18? GMT+08:00 ??3:33:36, Maxime Ripard
>> > > <maxime.ripard@free-electrons.com> ??:
>> > > >On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
>> > > >> Allwinner H3 features a thermal sensor like the one in A33,
>but has
>> > > >its
>> > > >> register re-arranged, the clock divider moved to CCU
>(originally the
>> > > >> clock divider is in ADC) and added a pair of bus clock and
>reset.
>> > > >>
>> > > >> Update the binding document to cover H3.
>> > > >>
>> > > >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > > >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> > > >> ---
>> > > >> Changes in v4:
>> > > >> - Add nvmem calibration data (not yet used by the driver)
>> > > >> Changes in v3:
>> > > >> - Clock name changes.
>> > > >> - Example node name changes.
>> > > >> - Add interupts (not yet used by the driver).
>> > > >>
>> > > >>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30
>> > > >++++++++++++++++++++--
>> > > >>  1 file changed, 28 insertions(+), 2 deletions(-)
>> > > >>
>> > > >> diff --git
>a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> > > >b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> > > >> index badff3611a98..6c470d584bf9 100644
>> > > >> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> > > >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> > > >> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can
>also
>> > > >act as a thermal sensor
>> > > >>  and sometimes as a touchscreen controller.
>> > > >>
>> > > >>  Required properties:
>> > > >> -  - compatible: "allwinner,sun8i-a33-ths",
>> > > >> +  - compatible: must contain one of the following
>compatibles:
>> > > >> +		- "allwinner,sun8i-a33-ths"
>> > > >> +		- "allwinner,sun8i-h3-ths"
>> > > >>    - reg: mmio address range of the chip,
>> > > >>    - #thermal-sensor-cells: shall be 0,
>> > > >>    - #io-channel-cells: shall be 0,
>> > > >>
>> > > >> -Example:
>> > > >> +Optional properties:
>> > > >> +  - nvmem-cells: A phandle to the calibration data provided
>by a
>> > > >nvmem device.
>> > > >> +                 If unspecified default values shall be used.
>> > > >> +  - nvmem-cell-names: Should be "calibration-data"
>> > > >
>> > > >I'd prefer to have which sensor it applies to here. It wouldn't
>change
>> > > >anything for the H3, but it definitely does for example for the
>A83t
>> > > >that has two sensors, one for each cluster, and one for the GPU,
>each
>> > > >with calibration data.
>> > > >
>> > > >What about cluster0-calibration?
>> 
>> I prefer sensor0-calibration to sensor3-calibration now.
>> (Theortically the new generation THS can support up to 4 sensors)
>
>The mapping that explains what sensor0 means can change in the
>future. It's better to be explicit here, and just say upfront what
>it's about.

I think for some SoC (e.g. A64) there's no clear explain on
the functions of the sensors.

In addition, in the THS controller the sensors has a
explicit sequence, and when referencing it in the DT
the number is still needed (in thermal zones).

>
>Maxime
