From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Sep 2014 10:58:12 -0700
Subject: [PATCH 2/2] ARM: dts: add intmem node for rk3288 smp support
In-Reply-To: <1410343554-8383-3-git-send-email-kever.yang@rock-chips.com>
References: <1410343554-8383-1-git-send-email-kever.yang@rock-chips.com>
 <1410343554-8383-3-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=U3gqMeCp_z_uML3iPc6GC_nnYL9v6qwux2PQ5wzrbdwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Wed, Sep 10, 2014 at 3:05 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> This patch add intmem node des which is needed by platsmp.c
> and enable the smp.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>  arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index dca586e..562ec5f 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -40,6 +40,7 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               enable-method = "rockchip,rk3288-smp";
>                 cpu at 500 {
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a12";
> @@ -353,6 +354,23 @@
>                 status = "disabled";
>         };
>
> +       bus_intmem at ff700000 {
> +               compatible = "mmio-sram";
> +               reg = <0xff700000 0x18000>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0 0xff700000 0x18000>;
> +                       smp-sram at 0 {

nit: I think the "smp-sram at 0" line is indented one too many tabs.

I haven't done a full review of this series yet, though...
