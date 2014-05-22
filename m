From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 22 May 2014 22:03:09 +0400
Subject: [Patch v6 4/7] power: reset: add bindings for keystone reset
 driver
In-Reply-To: <1400777062-19276-5-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400777062-19276-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400777062-19276-5-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <537E3BDD.40106@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/22/2014 08:44 PM, Ivan Khoronzhuk wrote:

> This node is intended to allow SoC reset in case of software reset
> or appropriate watchdogs.

> The Keystone SoCs can contain up to 4 watchdog timers to reset
> SoC. Each watchdog timer event input is connected to the Reset Mux
> block. The Reset Mux block can be configured to cause reset or not.

> Additionally soft or hard reset can be configured.

> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>   .../bindings/power/reset/keystone-reset.txt        | 67 ++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/power/reset/keystone-reset.txt

> diff --git a/Documentation/devicetree/bindings/power/reset/keystone-reset.txt b/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
> new file mode 100644
> index 0000000..a8a0c31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
> @@ -0,0 +1,67 @@
> +* Device tree bindings for Texas Instruments keystone reset
> +
> +This node is intended to allow SoC reset in case of software reset
> +of selected watchdogs.
> +
> +The Keystone SoCs can contain up to 4 watchdog timers to reset
> +SoC. Each watchdog timer event input is connected to the Reset Mux
> +block. The Reset Mux block can be configured to cause reset or not.
> +
> +Additionally soft or hard reset can be configured.
> +
> +Required properties:
> +
> +- compatible:		ti,keystone-reset
> +
> +- ti,syscon-pll:	phandle/offset pair. The phandle to syscon used to
> +			access pll controller registers and the offset to use
> +			reset control registers.
> +
> +- ti,syscon-dev:	phandle/offset pair. The phandle to syscon used to
> +			access device state control registers and the offset
> +			in order to use mux block registers for all watchdogs.
> +
> +Optional properties:
> +
> +- ti,soft-reset:	Boolean option indicating soft reset.
> +			By default hard reset is used.
> +
> +- ti,wdt_list:		WDT list that can cause SoC reset. It's not related

    Hm, why underscore in this property while hyphens are used in the others? 
Hyphen is generally preferrable in the device tree names...

> +			to WDT driver, it's just needed to enable a SoC related
> +			reset that's triggered by one of WDTs. The list is
> +			in format: <0>, <2>; It can be in random order and
> +			begins from 0 to 3, as keystone can contain up to 4 SoC
> +			reset watchdogs and can be in random order.

WBR, Sergei
