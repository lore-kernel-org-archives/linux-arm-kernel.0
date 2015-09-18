From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Sep 2015 23:30:05 +0200
Subject: [PATCH v2 4/9] ARM: dts: Put Cygnus core components under core bus
In-Reply-To: <1442611454-16331-5-git-send-email-rjui@broadcom.com>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
 <1442611454-16331-5-git-send-email-rjui@broadcom.com>
Message-ID: <1472876.fGCm1r9KFG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 September 2015 14:24:09 Ray Jui wrote:
> 
> +       core {
> +               compatible = "simple-bus";
> +               ranges;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               timer at 19020200 {
> +                       compatible = "arm,cortex-a9-global-timer";
> +                       reg = <0x19020200 0x100>;
> +                       interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&periph_clk>;
> +               };
> +
> +               gic: interrupt-controller at 19021000 {
> 

Could it be that all 'core' components are in the 0x19xxxxxx address range?
If so, please set up an appropriate ranges property for the bus. Also
add the address field for the bus according to which addresses are routed
to it.

	Arnd
