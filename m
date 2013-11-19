From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 18 Nov 2013 21:15:22 -0800
Subject: [PATCH 4/6] watchdog: davinci: add "timeout-sec" property
In-Reply-To: <1384795139-19466-5-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384795139-19466-5-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <528AF3EA.4070103@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 09:18 AM, Ivan Khoronzhuk wrote:
> Since Davinci WDT has been switched to use WDT core, it became able
> to support timeout-sec property, so add it to it's binding description.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/davinci-wdt.txt   |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> index 75558cc..e450134 100644
> --- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> @@ -4,9 +4,13 @@ Required properties:
>   - compatible : Should be "ti,davinci-wdt"
>   - reg : Should contain WDT registers location and length
>
> +Optional properties:
> +- timeout-sec : Contains the watchdog timeout in seconds
> +
>   Examples:
>
>   wdt: wdt at 2320000 {
>   	compatible = "ti,davinci-wdt";
>   	reg = <0x02320000 0x80>;
> +	timeout-sec = <30>;
>   };
>
