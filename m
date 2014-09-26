From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 26 Sep 2014 10:19:50 +0200
Subject: [PATCH v3 02/13] PM / Domains: Add DT bindings for power-on/off
 latencies
In-Reply-To: <1411662520-22795-3-git-send-email-geert+renesas@glider.be>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
 <1411662520-22795-3-git-send-email-geert+renesas@glider.be>
Message-ID: <CAPDyKFrAv9oyBzX764+CWkOxfN1kN_MddB3ks1q69+TnmnHXuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2014 18:28, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> PM domain power on/off-latencies are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> v3:
>   - No changes
> v2:
>   - Add Acked-by
>
>  Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 98c16672ab5f49e0..7bc421d84367d636 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -19,12 +19,18 @@ Required properties:
>     providing multiple PM domains (e.g. power controllers), but can be any value
>     as specified by device tree binding documentation of particular provider.
>
> +Optional properties:
> + - power-on-latency: Power-on latency of the PM domain, in ns,
> + - power-off-latency: Power-off latency of the PM domain, in ns.
> +
>  Example:
>
>         power: power-controller at 12340000 {
>                 compatible = "foo,power-controller";
>                 reg = <0x12340000 0x1000>;
>                 #power-domain-cells = <1>;
> +               power-on-latency = <250000>;
> +               power-off-latency = <250000>;
>         };
>
>  The node above defines a power controller that is a PM domain provider and
> --
> 1.9.1
>
