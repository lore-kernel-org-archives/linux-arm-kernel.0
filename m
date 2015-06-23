From: sonnyrao@chromium.org (Sonny Rao)
Date: Tue, 23 Jun 2015 14:11:36 -0700
Subject: [PATCH] ARM: dts: rockchip: Add DMA tx and rx channels in UART
 interfaces for RK3288 SoCs
In-Reply-To: <1475991.JRcDMpQrFc@diego>
References: <1434475166-30338-1-git-send-email-romain.perier@gmail.com>
 <CABgxDo+8MafT8hOzpG=gjju=S7bVtNBOKxmi_JPHv1bDZSGeCQ@mail.gmail.com>
 <1475991.JRcDMpQrFc@diego>
Message-ID: <CAPz6YkUPm+r5BmfxYokJF22yS71VXcsutwKR9y7FiET_3eLpeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 4:09 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Romain,
>
> Am Dienstag, 23. Juni 2015, 08:53:17 schrieb Romain Perier:
>> ping :)
>
> I haven't forgotten this patch :-)
>
> I just haven't fully made up my mind concerning the bug in the pl330
> implementation on Rockchip SoCs - aka if we'll make it worse by also enabling
> dma on the uarts.
>
> So far the problem reports I read only mentioned degraded functionality like
> popping sounds in audio, not full system failures or freezes. So I tend to
> include the patch and see what happens ;-)

You should look out for corrupted data -- like zeros or repeated data
in the serial input or output.  That was what was causing the pops --
a sudden sample of zeros, or buzzing from repeated samples.

It may not happen at low speeds, but might happen if you tried doing
something like PPP over the UART.

>
>
> Heiko
>
>
>
>> 2015-06-16 19:19 GMT+02:00 Romain Perier <romain.perier@gmail.com>:
>> > This enable DMA capability for the corresponding UART interfaces, also it
>> > removes warning "ttyS%d - Failed to request dma" from kernel logs.
>> >
>> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> > ---
>> >
>> > Changes since v1 ("[PATCH] ARM: dts: rockchip: Add dmac_bus rx and tx for
> uart2"):
>> >         - Add DMA tx and rx channels for all UART interfaces
>> >         - Rename commit summary
>> >
>> >  arch/arm/boot/dts/rk3288.dtsi | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
>> > index 22316d0..1996452 100644
>> > --- a/arch/arm/boot/dts/rk3288.dtsi
>> > +++ b/arch/arm/boot/dts/rk3288.dtsi
>> > @@ -359,6 +359,8 @@
>> >
>> >                 clock-names = "baudclk", "apb_pclk";
>> >                 pinctrl-names = "default";
>> >                 pinctrl-0 = <&uart0_xfer>;
>> >
>> > +               dmas = <&dmac_peri 1>, <&dmac_peri 2>;
>> > +               dma-names = "tx", "rx";
>> >
>> >                 status = "disabled";
>> >
>> >         };
>> >
>> > @@ -372,6 +374,8 @@
>> >
>> >                 clock-names = "baudclk", "apb_pclk";
>> >                 pinctrl-names = "default";
>> >                 pinctrl-0 = <&uart1_xfer>;
>> >
>> > +               dmas = <&dmac_peri 3>, <&dmac_peri 4>;
>> > +               dma-names = "tx", "rx";
>> >
>> >                 status = "disabled";
>> >
>> >         };
>> >
>> > @@ -385,6 +389,8 @@
>> >
>> >                 clock-names = "baudclk", "apb_pclk";
>> >                 pinctrl-names = "default";
>> >                 pinctrl-0 = <&uart2_xfer>;
>> >
>> > +               dmas = <&dmac_bus_s 4>, <&dmac_bus_s 5>;
>> > +               dma-names = "tx", "rx";
>> >
>> >                 status = "disabled";
>> >
>> >         };
>> >
>> > @@ -398,6 +404,8 @@
>> >
>> >                 clock-names = "baudclk", "apb_pclk";
>> >                 pinctrl-names = "default";
>> >                 pinctrl-0 = <&uart3_xfer>;
>> >
>> > +               dmas = <&dmac_peri 7>, <&dmac_peri 8>;
>> > +               dma-names = "tx", "rx";
>> >
>> >                 status = "disabled";
>> >
>> >         };
>> >
>> > @@ -411,6 +419,8 @@
>> >
>> >                 clock-names = "baudclk", "apb_pclk";
>> >                 pinctrl-names = "default";
>> >                 pinctrl-0 = <&uart4_xfer>;
>> >
>> > +               dmas = <&dmac_peri 9>, <&dmac_peri 10>;
>> > +               dma-names = "tx", "rx";
>> >
>> >                 status = "disabled";
>> >
>> >         };
>> >
>> > --
>> > 1.9.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
