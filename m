From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Mon, 20 Mar 2017 09:45:27 +0100
Subject: [PATCH v2 05/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
In-Reply-To: <6d997cc1-585e-e25c-a53f-d7b28613dfbb@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-6-quentin.schulz@free-electrons.com>
 <5798131489173902@web12o.yandex.ru>
 <6d997cc1-585e-e25c-a53f-d7b28613dfbb@free-electrons.com>
Message-ID: <20170320084527.7cah2g7doas7ykyf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 11, 2017 at 03:07:55PM +0100, Quentin Schulz wrote:
> Hi Icenowy,
> 
> On 10/03/2017 20:25, Icenowy Zheng wrote:
> > 
> > 
> > 10.03.2017, 18:56, "Quentin Schulz" <quentin.schulz@free-electrons.com>:
> >> This patch adds documentation for the A33 GPADC binding.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >> ---
> >>
> >> added in v2
> >>
> >>  .../devicetree/bindings/mfd/sun4i-gpadc.txt | 59 ++++++++++++++++++++++
> >>  1 file changed, 59 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> new file mode 100644
> >> index 0000000..17242c8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> @@ -0,0 +1,59 @@
> >> +Allwinner SoCs' GPADC Device Tree bindings
> >> +------------------------------------------
> >> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> >> +and sometimes as a touchscreen controller.
> >> +
> >> +Required properties:
> >> + - compatible: "sun8i-a33-gpadc-iio",
> >> + - reg: mmio address range of the chip,
> >> + - #thermal-sensor-cells: shall be 0,
> >> + - #io-channel-cells: shall be 0,
> >> +
> >> +Example:
> >> + rtp: rtp at 01c25000 {
> > 
> > I think we'd better call it ths.
> 
> To match the datasheet, I agree.

I agree too.

> > And can you make thermal-sensor-cells become 1?
> > 
> > Maxime Ripard wants to base H3/H5/A64 thermal driver on this patchset, and
> > for H5/A64 there's 2/3 thermal sensors.
> 
> Yes, that'll require a specific DT node for those thermal sensors. Then
> since we would update the possible compatibles in the documentation
> anyway, that would be a good idea to update to say that
> thermal-sensor-cells could be different from 0 too.
> 
> That was my mindset to set thermal-sensor-cells to 0, since we only
> support SoC which has only one thermal sensor at the moment.

And I agree here as well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/e15c6e41/attachment.sig>
