From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 26 Jul 2012 16:51:14 +0400
Subject: [PATCH 1/7] RTC: add DT bindings to pxa-rtc
In-Reply-To: <1343233066-15397-2-git-send-email-zonque@gmail.com>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-2-git-send-email-zonque@gmail.com>
Message-ID: <50113D42.5010503@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-07-2012 20:17, Daniel Mack wrote:

> This patch adds generic device tree bindings to the PXA RTC driver.
> Documentation for bindings were also added.

> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> ---
>   Documentation/devicetree/bindings/rtc/pxa-rtc.txt |   12 ++++++++++++
>   drivers/rtc/rtc-pxa.c                             |   11 +++++++++++
>   2 files changed, 23 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rtc/pxa-rtc.txt

> diff --git a/Documentation/devicetree/bindings/rtc/pxa-rtc.txt b/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
> new file mode 100644
> index 0000000..acba256
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/pxa-rtc.txt
> @@ -0,0 +1,12 @@
> +* PXA RTC
> +
> +PXA specific RTC driver.
> +
> +Required properties:
> +- compatible : Should be pxa-rtc
> +
> +Examples:
> +
> +rtc at 0 {

    Don't use the address postfix when the node doesn't have "reg" property.

> +    compatible = "mrvl,pxa-rtc";
> +};

WBR, Sergei
