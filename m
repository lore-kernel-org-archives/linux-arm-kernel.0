From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 17 Nov 2013 00:37:08 +0100
Subject: [PATCH v2] ARM: sunxi: dt: add EMAC aliases
In-Reply-To: <1384625849-29849-1-git-send-email-emilio@elopez.com.ar>
References: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
 <1384625849-29849-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAOMqctTb0-B4y0DD6CWEi8Z7Bpd+pP-dWvvn5GiAkCeRD2v43g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfortunately,

a20 has two Ethernets so you can't alias both to ethernet0.

This has to be done on a per-board basis.

Thanks

Michal

On 16 November 2013 19:17, Emilio L?pez <emilio@elopez.com.ar> wrote:
> U-Boot uses the ethernet0 alias to locate the right node to fill in
> the MAC address of the first ethernet interface. This patch adds the
> alias on all the sunxi SoCs with EMAC. In this way, people using
> ethernet in U-Boot (eg, for tftp) can keep a consistent address on both
> U-Boot and Linux with no additional effort.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>
> v1->v2:
>    add to dtsi instead of dts as suggested by Maxime; it's easier to
>    maintain on the long run.
>
>  arch/arm/boot/dts/sun4i-a10.dtsi  | 4 ++++
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 4 ++++
>  arch/arm/boot/dts/sun7i-a20.dtsi  | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 09e7b43..23374da 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -15,6 +15,10 @@
>  / {
>         interrupt-parent = <&intc>;
>
> +       aliases {
> +               ethernet0 = &emac;
> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> index 9326b64..e95ab43 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -16,6 +16,10 @@
>  / {
>         interrupt-parent = <&intc>;
>
> +       aliases {
> +               ethernet0 = &emac;
> +       };
> +
>         cpus {
>                 cpu at 0 {
>                         compatible = "arm,cortex-a8";
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index c645a0f..6bea2b84 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -16,6 +16,10 @@
>  / {
>         interrupt-parent = <&gic>;
>
> +       aliases {
> +               ethernet0 = &emac;
> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> --
> 1.8.4.2
>
