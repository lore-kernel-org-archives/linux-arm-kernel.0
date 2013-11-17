From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 16 Nov 2013 18:25:52 -0800
Subject: Fwd: [PATCH 5/8] watchdog: davinci: add "timeout-sec" property
In-Reply-To: <527A28D8.9040901@ti.com>
References: <1383680783-12114-6-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28D8.9040901@ti.com>
Message-ID: <52882930.8020207@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2013 03:32 AM, ivan.khoronzhuk wrote:
> Since Davinci WDT has been switched to use WDT core, it became able
> to support timeout-sec property, so add it to it's binding description.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>   .../devicetree/bindings/watchdog/davinci-wdt.txt   |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> index 75558cc..1668b6e 100644
> --- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> @@ -4,9 +4,14 @@ Required properties:
>   - compatible : Should be "ti,davinci-wdt"
>   - reg : Should contain WDT registers location and length
>
> +Optional properties:
> +

empty line not needed here (and inconsistent).

> +- timeout-sec:		Contains the watchdog timeout in seconds
> +

Formatting is different to other bindings.

>   Examples:
>
>   wdt: wdt at 2320000 {
>   	compatible = "ti,davinci-wdt";
>   	reg = <0x02320000 0x80>;
> +	timeout-sec = <30>;
>   };
>
