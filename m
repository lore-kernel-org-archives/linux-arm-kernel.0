From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 24 Mar 2016 10:16:08 -0700
Subject: [PATCH 2/3] ARM64: dts: amlogic: add Hardkernel ODROID-C2
In-Reply-To: <56F41C76.8090805@suse.de>
References: <1458758013-11890-1-git-send-email-khilman@baylibre.com>
 <1458758013-11890-2-git-send-email-khilman@baylibre.com>
 <8055578.HDz4P7ZJ9W@wuerfel> <56F41C76.8090805@suse.de>
Message-ID: <CAOi56cVoLrHjeT_BhSZAvj5yZvf8Qkg8y=_zh+kikM+96+LGVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 9:57 AM, Andreas F?rber <afaerber@suse.de> wrote:
>
> Am 24.03.2016 um 13:58 schrieb Arnd Bergmann:
> > On Wednesday 23 March 2016 11:33:32 Kevin Hilman wrote:
> >> +/ {
> >> +       compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
> >> +       model = "Hardkernel ODROID-C2";
> >> +
> >> +       chosen {
> >> +               stdout-path = "serial0:115200n8";
> >> +       };
> >> +
> >> +       memory at 0 {
> >> +               device_type = "memory";
> >> +               reg = <0x0 0x0 0x0 0x80000000>;
> >> +       };
> >> +};
> >> +
> >> +&uart_AO {
> >> +       status = "okay";
> >> +};
> >>
> >
> > Shouldn't this also add the serial0 alias?
> >
> > It seems that the .dtsi file accidentally sets an alias to a disabled
> > device, which isn't really valid. Can you fix that when adding the
> > .dts?
>
> Hm, would it be any better to not disable either of the serials and
> leave the aliases in the .dtsi?

I'm going to respin, moving the aliases that are actually into the
.dts that use them, and dropping the unused/disabled serial1.

Kevin
