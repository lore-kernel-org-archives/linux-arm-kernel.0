From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 1 Dec 2016 09:41:29 -0800
Subject: [PATCH v4 2/3] doc: dt: add cyclone-spi binding document
In-Reply-To: <137f03de76e5f865430b17ca247e8f73e3315c8d.1480551148.git.stillcompiling@gmail.com>
References: <cover.1480551148.git.stillcompiling@gmail.com>
 <137f03de76e5f865430b17ca247e8f73e3315c8d.1480551148.git.stillcompiling@gmail.com>
Message-ID: <CAAtXAHd_krKPpXRw5NxWhS6kcQ_fJcuyZYDOretRfNn+Cpkn2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 1, 2016 at 9:04 AM, Joshua Clayton <stillcompiling@gmail.com> wrote:
> Describe a cyclonei-ps-spi devicetree entry, required features
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

> ---
>
>  .../bindings/fpga/cyclone-ps-spi-fpga-mgr.txt      | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/cyclone-ps-spi-fpga-mgr.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/cyclone-ps-spi-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/cyclone-ps-spi-fpga-mgr.txt
> new file mode 100644
> index 0000000..3f515c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/cyclone-ps-spi-fpga-mgr.txt
> @@ -0,0 +1,25 @@
> +Altera Cyclone Passive Serial SPI FPGA Manager
> +
> +Altera Cyclone FPGAs support a method of loading the bitstream over what is
> +referred to as "passive serial".
> +The passive serial link is not technically spi, and might require extra
> +circuits in order to play nicely with other spi slaves on the same bus.
> +
> +See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf
> +
> +Required properties:
> +- compatible  : should contain "altr,cyclone-ps-spi-fpga-mgr"
> +- reg         : spi slave id of the fpga
> +- config-gpios : config pin (referred to as nCONFIG in the cyclone manual)
> +- status-gpios : status pin (referred to as nSTATUS in the cyclone manual)
> +
> +both gpio pins are normally active low open drain.
> +
> +Example:
> +       fpga_spi: evi-fpga-spi at 0 {
> +               compatible = "altr,cyclone-ps-spi-fpga-mgr";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +               config-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +               status-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> +       };
> --
> 2.9.3
>
