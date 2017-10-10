From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Oct 2017 11:39:29 +0200
Subject: [linux-sunxi] Re: [PATCH 3/6] ARM: sun8i: r40: add 5V regulator
 for Banana Pi M2 Ultra
In-Reply-To: <CAGb2v66r2UyR1NWrtjdoKLEi_2NdXkhr_c5D6or9_9amNnh6PQ@mail.gmail.com>
References: <20171008042906.46779-1-icenowy@aosc.io>
 <20171008042906.46779-4-icenowy@aosc.io>
 <20171009210407.ueharyifho3s6xvu@flea.home>
 <61E002C8-4046-44E4-8E1A-43C8AF74257C@aosc.io>
 <CAGb2v66r2UyR1NWrtjdoKLEi_2NdXkhr_c5D6or9_9amNnh6PQ@mail.gmail.com>
Message-ID: <20171010093929.owvrowlpvicw663e@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 02:25:35AM +0000, Chen-Yu Tsai wrote:
> On Tue, Oct 10, 2017 at 7:25 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> >
> >
> > ? 2017?10?10? GMT+08:00 ??5:04:07, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
> >>On Sun, Oct 08, 2017 at 04:29:03AM +0000, Icenowy Zheng wrote:
> >>> On newer revisions of the Banana Pi M2 Ultra boards, the 5V power
> >>output
> >>> (used by HDMI, SATA and USB) is controller via a GPIO.
> >>>
> >>> Add the regulator node for it.
> >>>
> >>> Older revisions just have the 5V power output always on, and the GPIO
> >>is
> >>> reserved on these boards. So it won't affect the older revisions.
> >>>
> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >>> ---
> >>>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> >>b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> >>> index 7b52608cebe6..035599d870b9 100644
> >>> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> >>> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> >>> @@ -78,6 +78,15 @@
> >>>              };
> >>>      };
> >>>
> >>> +    reg_vcc5v0: vcc5v0 {
> >>> +            compatible = "regulator-fixed";
> >>> +            regulator-name = "vcc5v0";
> >>> +            regulator-min-microvolt = <5000000>;
> >>> +            regulator-max-microvolt = <5000000>;
> >>> +            gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>; /* PH23 */
> >>> +            enable-active-high;
> >>
> >>This is redundant with the GPIO flag
> >
> > I remember someone suggested me to add this
> > property (maybe wens). It's said that the driver may not
> > process the GPIO_ACTIVE_HIGH correctly.
> 
> I believe it was me. The fixed regulator driver has not migrated to
> the GPIO descriptor API, and it doesn't look like it cares about the
> GPIO flags.

Maybe we should just migrate it then?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171010/89c1835c/attachment-0001.sig>
