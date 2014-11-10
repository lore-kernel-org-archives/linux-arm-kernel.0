From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Nov 2014 16:06:19 +0100
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <1415631557-22897-2-git-send-email-grygorii.strashko@ti.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1415631557-22897-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <5331397.OQCQmJO78C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 November 2014 16:59:16 Grygorii Strashko wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/ti,keystone-powerdomain.txt
> @@ -0,0 +1,31 @@
> +* TI Keystone 2 Generic PM Controller
> +
> +The TI Keystone 2 Generic PM Controller is responsible for Clock gating
> +for each controlled IP module.
> +
> +Required properties:
> +- compatible: Should be "ti,keystone-powerdomain"
> +- #power-domain-cells: Should be 0, see below:
> +
> +The PM Controller node is a PM domain as documented in
> +Documentation/devicetree/bindings/power/power_domain.txt.
> +
> +Example:
> +
> +       pm_controller: pm-controller {
> +               compatible = "ti,keystone-powerdomain";
> +               #power-domain-cells = <0>;
> +       };
> +
> +       netcp: netcp at 2090000 {
> +               reg = <0x2620110 0x8>;
> +               reg-names = "efuse";
> +               ...
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               power-domains = <&pm_controller>;
> +
> +               clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
> +               dma-coherent;
> +       }

I don't get it. What keystone specific about a "ti,keystone-powerdomain"
device? It seems that the device has no registers whatsoever and the
driver doesn't really do anything that relates to the platform.

	Arnd
