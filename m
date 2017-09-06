From: joel@jms.id.au (Joel Stanley)
Date: Wed, 6 Sep 2017 14:53:26 +0930
Subject: [PATCH v3 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <20170906003016.2159-3-brendanhiggins@google.com>
References: <20170906003016.2159-1-brendanhiggins@google.com>
 <20170906003016.2159-3-brendanhiggins@google.com>
Message-ID: <CACPK8Xc0jrnx96=BoGMwQgoT2brgc0UTNU5HMHXDeFfeToVgxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 6, 2017 at 10:00 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> +++ b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
> @@ -0,0 +1,6 @@
> +NPCM Platforms Device Tree Bindings
> +-----------------------------------
> +NPCM750 SoC
> +Required root node properties:
> +       - compatible = "nuvoton,npcm750";
> +

This is minimal. I assume there will be more content added as more
support is added?

Does it need it's own directory?


> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> new file mode 100644
> index 000000000000..54df32cff21b
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts

> +
> +/dts-v1/;
> +#include "nuvoton-npcm750.dtsi"
> +
> +/ {
> +       model = "Nuvoton npcm750 Development Board (Device Tree)";
> +       compatible = "nuvoton,npcm750";
> +
> +       chosen {
> +               stdout-path = &serial3;
> +               bootargs = "earlyprintk=serial,serial3,115200";
> +       };
> +
> +       memory {
> +               reg = <0 0x40000000>;
> +       };
> +
> +       cpus {
> +               enable-method = "nuvoton,npcm7xx-smp";
> +       };
> +
> +       clk: clock-controller at f0801000 {
> +               status = "okay";
> +       };
> +
> +       apb {
> +               watchdog1: watchdog at f0009000 {
> +                       status = "okay";
> +               };

You've already got the label for the node, is there are reason you
don't use a phandle to set the status?

&watchdog1 {
   status = "okay";
};

Same with the serial nodes below.

> +
> +               serial0: serial0 at f0001000 {
> +                       status = "okay";
> +               };
> +
> +               serial1: serial1 at f0002000 {
> +                       status = "okay";
> +               };
> +
> +               serial2: serial2 at f0003000 {
> +                       status = "okay";
> +               };
> +
> +               serial3: serial3 at f0004000 {
> +                       status = "okay";
> +               };
> +       };
