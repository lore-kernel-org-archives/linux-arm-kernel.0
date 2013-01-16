From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 16 Jan 2013 13:28:56 +0200
Subject: [PATCH v4 5/9] ARM: Tegra: Define Tegra30 CAR binding
In-Reply-To: <1357890387-23245-6-git-send-email-pgaikwad@nvidia.com>
References: <1357890387-23245-1-git-send-email-pgaikwad@nvidia.com>
 <1357890387-23245-6-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130116132856.2896df94f553f78273c4574c@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013 08:46:23 +0100
Prashant Gaikwad <pgaikwad@nvidia.com> wrote:

> The device tree binding models Tegra30 CAR (Clock And Reset)
> as a single monolithic clock provider.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---
>  .../bindings/clock/nvidia,tegra30-car.txt          |  262 ++++++++++++++++++++
>  arch/arm/boot/dts/tegra30.dtsi                     |    6 +
>  2 files changed, 268 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
> new file mode 100644
> index 0000000..121d203
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
> @@ -0,0 +1,262 @@
> +NVIDIA Tegra30 Clock And Reset Controller
> +
> +This binding uses the common clock binding:
......
> +  215  cml0
> +  216  cml1
> +  217  hclk
> +  218  pclk
> +
> +Example SoC include file:
> +
> +/ {
> +       tegra_car: clock {
> +               compatible = "nvidia,tegra30-car";
> +               reg = <0x60006000 0x1000>;
> +               #clock-cells = <1>;
> +       };
> +
> +       usb at c5004000 {
> +               clocks = <&tegra_car 58>; /* usb2 */
> +       };
> +};
> +
> +Example board file:
> +
> +/ {
> +       clocks {
> +               compatible = "simple-bug";

typo, 's/simple-bug/simple-bus/' ?
