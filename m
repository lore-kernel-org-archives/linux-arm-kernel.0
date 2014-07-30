From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 Jul 2014 09:07:06 -0700
Subject: [PATCH 2/3] ARM: dts: add rk3288 ehci usb devices
In-Reply-To: <1406676273-20701-3-git-send-email-dianders@chromium.org>
References: <1406676273-20701-1-git-send-email-dianders@chromium.org>
 <1406676273-20701-3-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=WXmaForADQGCS0zQ--aFguANSfgyg=6tq6_D0mfmKjEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 29, 2014 at 4:24 PM, Doug Anderson <dianders@chromium.org> wrote:
> rk3288 has two kind of usb controller; this adds the ehci variant for
> host0 and hsic.
>
> At the moment we don't add any phys for these controllers, but the
> default settings seem to work OK.
>
> There is a hardware problem in ohci controller which make it
> unavailable and host0 controller can only support high-speed devices.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 3ef8951..0bb4480 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -251,6 +251,26 @@
>                 status = "disabled";
>         };
>
> +       usb_host0_ehci: ehci at ff500000 {

According to sergei.shtylyov at cogentembedded.com in another thread,
this should be "usb at ff500000".

I will fix (and the hsic one) this when I spin the series shortly.

-Doug
