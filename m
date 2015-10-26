From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 26 Oct 2015 18:09:47 -0500
Subject: [PATCH v4] Tegra: DT: add device tree binding doc for QSPI
In-Reply-To: <1445898140-3561-1-git-send-email-twarren@nvidia.com>
References: <1445898140-3561-1-git-send-email-twarren@nvidia.com>
Message-ID: <CAL_Jsq+ns8eFrXpERA4+DoXcC3cGFtbu=72ehpkxDf8KQzQguQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 5:22 PM, Tom Warren <twarren@nvidia.com> wrote:
> This patch adds the device tree binding doc for the Tegra
> QSPI controller on Tegra210.
>
> Signed-off-by: Tom Warren <twarren@nvidia.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes in v2:
> - based it more on kernel's nvidia,tegra114-spi.txt binding
> - changes based on prelim review by swarren at nvidia.com
> Changes in v3:
> - renamed to 'nvidia,tegra210-qspi.txt' to match kernel bindings
> - more changes based on review from swarren at nvidia.com
> Changes in v4:
> - move 'clock' up under 'clock-names' entry
>
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt | 42 ++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
> new file mode 100644
> index 0000000..fe1558f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
> @@ -0,0 +1,42 @@
> +NVIDIA Tegra QSPI controller.
> +
> +Required properties:
> +- compatible : for Tegra210, must contain "nvidia,tegra210-qspi".
> +- reg: Should contain QSPI registers location and length.
> +- interrupts: Should contain QSPI interrupt.
> +- clock-names : Must include the following entries:
> +  - qspi
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- resets : Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names : Must include the following entries:
> +  - qspi
> +
> +Optional properties:
> +- dmas : Must contain an entry for each entry in clock-names.
> +  See ../dma/dma.txt for details.
> +- dma-names : Must include the following entries:
> +  - rx
> +  - tx
> +
> +Recommended properties:
> +- spi-max-frequency: Definition as per spi-bus.txt
> +
> +Example:
> +
> +spi at 70410000 {
> +       compatible = "nvidia,tegra210-qspi";
> +       reg = <0x0 0x70410000 0x0 0x1000>;
> +       interrupts = <0 10 0x04>;
> +       spi-max-frequency = <24000000>;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       clocks = <&tegra_car 211>;
> +       clock-names = "qspi";
> +       resets = <&tegra_car 211>;
> +       reset-names = "qspi";
> +       dmas = <&apbdma 16>, <&apbdma 16>;
> +       dma-names = "rx", "tx";
> +       status = "disabled";
> +};
> --
> 1.8.2.1.610.g562af5b
>
