From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 13 Dec 2014 07:45:35 -0800
Subject: [PATCH v2 2/2] ARM: mediatek: dts: Add bindings for watchdog
In-Reply-To: <1418395859-32209-3-git-send-email-matthias.bgg@gmail.com>
References: <1418395859-32209-1-git-send-email-matthias.bgg@gmail.com>
 <1418395859-32209-3-git-send-email-matthias.bgg@gmail.com>
Message-ID: <548C5F1F.8070804@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2014 06:50 AM, Matthias Brugger wrote:
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> new file mode 100644
> index 0000000..af9eb5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -0,0 +1,13 @@
> +Mediatek SoCs Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "mediatek,mt6589-wdt"

"mediatek" is undefined as vendor prefix in the current upstream code.
Is this vendor prefix coming in from another patch set ?

Guenter

> +- reg : Specifies base physical address and size of the registers.
> +
> +Example:
> +
> +wdt: watchdog at 010000000 {
> +	compatible = "mediatek,mt6589-wdt";
> +	reg = <0x10000000 0x18>;
> +};
>
