From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 21:17:29 +0100
Subject: [PATCH] arm64: dts: add APM Merlin Board device tree
In-Reply-To: <1426007454-11848-1-git-send-email-fkan@apm.com>
References: <1426007454-11848-1-git-send-email-fkan@apm.com>
Message-ID: <2602208.VnWlmB6etW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 10:10:54 Feng Kan wrote:
> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               serial0: serial at 10600000 {
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <0 0x10600000 0x0 0x1000>;
> +                       reg-shift = <2>;
> +                       clock-frequency = <10000000>;
> +                       interrupt-parent = <&gic>;
> +                       interrupts = <0x0 0x4c 0x4>;
> +               };
> +
> +               sata1: sata at 1a000000 {
> +                       compatible = "apm,xgene-ahci";
> +                       reg = <0x0 0x1a000000 0x0 0x1000>,
> +                             <0x0 0x1f200000 0x0 0x1000>,
> +                             <0x0 0x1f20d000 0x0 0x1000>,
> +                             <0x0 0x1f20e000 0x0 0x1000>;
> +                       interrupts = <0x0 0x5a 0x4>;
> +                       dma-coherent;
> +               };
> +
> +               sata2: sata at 1a200000 {
> +                       compatible = "apm,xgene-ahci";
> +                       reg = <0x0 0x1a200000 0x0 0x1000>,
> +                             <0x0 0x1f210000 0x0 0x1000>,
> +                             <0x0 0x1f21d000 0x0 0x1000>,
> +                             <0x0 0x1f21e000 0x0 0x1000>;
> +                       interrupts = <0x0 0x5b 0x4>;
> +                       dma-coherent;
> +               };
> +
> +               sata3: sata at 1a400000 {
> +                       compatible = "apm,xgene-ahci";
> +                       reg = <0x0 0x1a400000 0x0 0x1000>,
> +                             <0x0 0x1f220000 0x0 0x1000>,
> +                             <0x0 0x1f22d000 0x0 0x1000>,
> +                             <0x0 0x1f22e000 0x0 0x1000>;
> +                       interrupts = <0x0 0x5c 0x4>;
> +                       dma-coherent;
> +               };
> +       };
> 

No dma-ranges here? Are the sata ports all 32-bit only?

	Arnd
