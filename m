From: atull@kernel.org (Alan Tull)
Date: Mon, 5 Jun 2017 10:11:34 -0500
Subject: [PATCH v12 2/6] doc: dt: document altera-passive-serial binding
In-Reply-To: <4945d90535e701e4e0207c08a7543a7623b94aeb.1496434383.git.stillcompiling@gmail.com>
References: <20170525172911.11467-1-stillcompiling@gmail.com>
 <684ea151ba9aa2c6555a299daf56552ddc11f596.1496434383.git.stillcompiling@gmail.com>
 <4945d90535e701e4e0207c08a7543a7623b94aeb.1496434383.git.stillcompiling@gmail.com>
Message-ID: <CANk1AXQTyBRw_BdWDPxqUcAnKESYNhmYMNRwzX+YeSF9-L69TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 2, 2017 at 3:30 PM, Joshua Clayton <stillcompiling@gmail.com> wrote:
> Describe an altera-passive-serial devicetree entry, required features
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Signed-off-by: Alan Tull <atull@kernel.org>

> ---
>  .../bindings/fpga/altera-passive-serial.txt        | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt b/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
> new file mode 100644
> index 000000000000..48478bc07e29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
> @@ -0,0 +1,29 @@
> +Altera Passive Serial SPI FPGA Manager
> +
> +Altera FPGAs support a method of loading the bitstream over what is
> +referred to as "passive serial".
> +The passive serial link is not technically SPI, and might require extra
> +circuits in order to play nicely with other SPI slaves on the same bus.
> +
> +See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf
> +
> +Required properties:
> +- compatible: Must be one of the following:
> +       "altr,fpga-passive-serial",
> +       "altr,fpga-arria10-passive-serial"
> +- reg: SPI chip select of the FPGA
> +- nconfig-gpios: config pin (referred to as nCONFIG in the manual)
> +- nstat-gpios: status pin (referred to as nSTATUS in the manual)
> +
> +Optional properties:
> +- confd-gpios: confd pin (referred to as CONF_DONE in the manual)
> +
> +Example:
> +       fpga: fpga at 0 {
> +               compatible = "altr,fpga-passive-serial";
> +               spi-max-frequency = <20000000>;
> +               reg = <0>;
> +               nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +               nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
> +               confd-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
> +       };
> --
> 2.11.0
>
